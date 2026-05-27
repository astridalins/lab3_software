package epaw.lab3.repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import epaw.lab3.model.Post;

public class PostRepository extends BaseRepository {

    private static PostRepository instance;

    private PostRepository() { super(); }

    public static synchronized PostRepository getInstance() {
        if (instance == null) instance = new PostRepository();
        return instance;
    }

    // ── visibility constants ──────────────────────────────────────────────────
    public static final int VISIBILITY_TOTS   = 0;
    public static final int VISIBILITY_PRIVAT = 1;
    public static final int VISIBILITY_COLLA  = 2;

    // ── shared column select ──────────────────────────────────────────────────
    private static final String SELECT_COLS =
        "SELECT p.id, p.user_id, p.created_at, p.text, p.private, " +
        "       u.name AS uname, u.picture AS userPicture, " +
        "       (SELECT COUNT(*) FROM likes WHERE post_id = p.id) AS likeCount, " +
        "       (SELECT COUNT(*) FROM likes WHERE post_id = p.id AND user_id = ?) AS likedByMe " +
        "FROM post p JOIN users u ON p.user_id = u.id ";

    // ── save ──────────────────────────────────────────────────────────────────
    public void save(Post post) {
        String query = "INSERT INTO post (user_id, created_at, text, private) VALUES (?,?,?,?)";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, post.getUid());
            st.setTimestamp(2, post.getPostDateTime());
            st.setString(3, post.getContent());
            st.setInt(4, post.getVisibility());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── delete ────────────────────────────────────────────────────────────────
    public void delete(Integer id, Integer userId) {
        String query = "DELETE FROM post WHERE id = ? AND user_id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, id);
            st.setInt(2, userId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── findPrivat ────────────────────────────────────────────────────────────
    /**
     * Posts with visibility=1 visible to the current user:
     *   - own posts (user_id = userId)
     *   - posts from users the current user follows
     */
    public List<Post> findPrivat(Integer userId) {
        String query = SELECT_COLS +
            "WHERE p.private = " + VISIBILITY_PRIVAT + " " +
            "AND (p.user_id = ? " +
            "     OR p.user_id IN (SELECT followed_id FROM follows WHERE follower_id = ?)) " +
            "ORDER BY p.created_at DESC";
        List<Post> posts = new ArrayList<>();
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, userId);  // likedByMe subquery
            st.setInt(2, userId);  // p.user_id = ?
            st.setInt(3, userId);  // follower_id = ?
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) posts.add(mapPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // ── findColla ─────────────────────────────────────────────────────────────
    /** Posts visibility=2 whose author is in the same colla */
    public List<Post> findColla(String colla, Integer userId) {
        String query = SELECT_COLS +
            "WHERE u.colla = ? AND p.private = " + VISIBILITY_COLLA + " " +
            "ORDER BY p.created_at DESC";
        List<Post> posts = new ArrayList<>();
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, userId);       // likedByMe subquery param
            st.setString(2, colla);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) posts.add(mapPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    // ── findTots ──────────────────────────────────────────────────────────────
    /** All posts with visibility=0 */
    public List<Post> findTots(Integer userId) {
        String query = SELECT_COLS +
            "WHERE p.private = " + VISIBILITY_TOTS + " " +
            "ORDER BY p.created_at DESC";
        return executeQuery(query, userId);
    }

    // ── addLike ───────────────────────────────────────────────────────────────
    public int addLike(Integer userId, Integer postId) {
        String ins = "INSERT OR IGNORE INTO likes (user_id, post_id) VALUES (?,?)";
        try (PreparedStatement st = db.prepareStatement(ins)) {
            st.setInt(1, userId);
            st.setInt(2, postId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getLikeCount(postId);
    }

    // ── removeLike ────────────────────────────────────────────────────────────
    public int removeLike(Integer userId, Integer postId) {
        String del = "DELETE FROM likes WHERE user_id = ? AND post_id = ?";
        try (PreparedStatement st = db.prepareStatement(del)) {
            st.setInt(1, userId);
            st.setInt(2, postId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getLikeCount(postId);
    }

    // ── getLikeCount ──────────────────────────────────────────────────────────
    public int getLikeCount(Integer postId) {
        String q = "SELECT COUNT(*) FROM likes WHERE post_id = ?";
        try (PreparedStatement st = db.prepareStatement(q)) {
            st.setInt(1, postId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ── findByUser (used by old Posts/Timeline) ───────────────────────────────
    public Optional<List<Post>> findByUser(Integer userId, Integer start, Integer end) {
        String query =
            "SELECT p.id, p.user_id, p.created_at, p.text, p.private, " +
            "       u.name AS uname, u.picture AS userPicture, 0 AS likeCount, 0 AS likedByMe " +
            "FROM post p JOIN users u ON p.user_id = u.id " +
            "WHERE p.user_id = ? ORDER BY p.created_at DESC LIMIT ?,?";
        List<Post> posts = new ArrayList<>();
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, userId);
            st.setInt(2, start);
            st.setInt(3, end);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) posts.add(mapPost(rs));
                return Optional.of(posts);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    // ── helpers ───────────────────────────────────────────────────────────────
    /** Execute a query where the first param is the userId for likedByMe */
    private List<Post> executeQuery(String query, Integer userId) {
        List<Post> posts = new ArrayList<>();
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) posts.add(mapPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    /** Execute a query where (?, userId) = (likedByMe param, filter param) */
    private List<Post> executeQuery(String query, Integer likedByMeParam, Integer filterParam) {
        List<Post> posts = new ArrayList<>();
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, likedByMeParam);
            st.setInt(2, filterParam);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) posts.add(mapPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    private Post mapPost(ResultSet rs) throws SQLException {
        Post p = new Post();
        p.setId(rs.getInt("id"));
        p.setUid(rs.getInt("user_id"));
        p.setUname(rs.getString("uname"));
        p.setUserPicture(rs.getString("userPicture"));
        p.setPostDateTime(rs.getTimestamp("created_at"));
        p.setContent(rs.getString("text"));
        p.setVisibility(rs.getInt("private"));
        p.setLikeCount(rs.getInt("likeCount"));
        p.setLikedByMe(rs.getInt("likedByMe"));
        return p;
    }
}
