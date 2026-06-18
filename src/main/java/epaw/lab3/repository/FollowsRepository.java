package epaw.lab3.repository;

import epaw.lab3.model.Follows;
import epaw.lab3.model.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class FollowsRepository extends BaseRepository {

    private static FollowsRepository instance;

    private FollowsRepository() {
        super();
    }

    public static synchronized FollowsRepository getInstance() {
        if (instance == null) {
            instance = new FollowsRepository();
        }
        return instance;
    }

    // ── save ──────────────────────────────────────────────────────────────────
    public void save(Follows f) {
        String query = "INSERT INTO follows (follower_id, followed_id, followed_at) VALUES (?,?,?)";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, f.getFollowerId());
            st.setInt(2, f.getFollowedId());
            st.setString(3, LocalDate.now().toString());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── delete ────────────────────────────────────────────────────────────────
    public void delete(Follows f) {
        String query = "DELETE FROM follows WHERE follower_id = ? AND followed_id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, f.getFollowerId());
            st.setInt(2, f.getFollowedId());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── findById ──────────────────────────────────────────────────────────────
    public Optional<Follows> findById(int followerId, int followedId) {
        String query = "SELECT follower_id, followed_id FROM follows WHERE follower_id = ? AND followed_id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, followerId);
            st.setInt(2, followedId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(new Follows(rs.getInt("follower_id"), rs.getInt("followed_id")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    // ── isFollowing ───────────────────────────────────────────────────────────
    public boolean isFollowing(Integer followerId, Integer followedId) {
        return findById(followerId, followedId).isPresent();
    }

    // ── findFollowed ──────────────────────────────────────────────────────────
    public Optional<List<User>> findFollowed(Integer userId, Integer start, Integer end) {
        String query =
            "SELECT u.id, u.name, u.username, u.picture " +
            "FROM users u INNER JOIN follows f ON u.id = f.followed_id " +
            "WHERE f.follower_id = ? ORDER BY u.name LIMIT ?,?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, userId);
            st.setInt(2, start);
            st.setInt(3, end);
            try (ResultSet rs = st.executeQuery()) {
                List<User> users = new ArrayList<>();
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setUsername(rs.getString("username"));
                    user.setPicture(rs.getString("picture"));
                    users.add(user);
                }
                return Optional.of(users);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    // ── findNotFollowed ───────────────────────────────────────────────────────
    public Optional<List<User>> findNotFollowed(Integer userId, Integer start, Integer end) {
        String query =
            "SELECT id, name, username, picture FROM users " +
            "WHERE id NOT IN (SELECT followed_id FROM follows WHERE follower_id = ?) " +
            "AND id <> ? ORDER BY name LIMIT ?,?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, userId);
            st.setInt(2, userId);
            st.setInt(3, start);
            st.setInt(4, end);
            try (ResultSet rs = st.executeQuery()) {
                List<User> users = new ArrayList<>();
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setUsername(rs.getString("username"));
                    user.setPicture(rs.getString("picture"));
                    users.add(user);
                }
                return Optional.of(users);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
