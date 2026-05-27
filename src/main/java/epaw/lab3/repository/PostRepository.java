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

    private PostRepository() {
        super();
    }

    public static synchronized PostRepository getInstance() {
        if (instance == null) {
            instance = new PostRepository();
        }
        return instance;
    }

    /** Insert a new post */
    public void save(Post post) {
        String query = "INSERT INTO post (user_id, created_at, text) VALUES (?,?,?)";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, post.getUid());
            st.setTimestamp(2, post.getPostDateTime());
            st.setString(3, post.getContent());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /** Delete a post (only if owned by the user) */
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

    /** Get paginated posts by a user, newest first */
    public Optional<List<Post>> findByUser(Integer userId, Integer start, Integer end) {
        List<Post> posts = new ArrayList<>();
        String query =
            "SELECT post.id, post.user_id, post.created_at, post.text, users.name " +
            "FROM post " +
            "INNER JOIN users ON post.user_id = users.id " +
            "WHERE post.user_id = ? " +
            "ORDER BY post.created_at DESC " +
            "LIMIT ?,?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, userId);
            st.setInt(2, start);
            st.setInt(3, end);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setUid(rs.getInt("user_id"));
                    post.setPostDateTime(rs.getTimestamp("created_at"));
                    post.setContent(rs.getString("text"));
                    post.setUname(rs.getString("name"));
                    posts.add(post);
                }
                return Optional.of(posts);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
