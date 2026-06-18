package epaw.lab3.repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import epaw.lab3.model.User;

public class UserRepository extends BaseRepository {

    private static UserRepository instance;

    private UserRepository() {
        super();
    }

    public static synchronized UserRepository getInstance() {
        if (instance == null) {
            instance = new UserRepository();
        }
        return instance;
    }

    // ── findAll ───────────────────────────────────────────────────────────────
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String query =
            "SELECT u.id, u.name, u.username, u.email, u.location, u.userType, " +
            "       u.colla, u.picture, u.posicions, " +
            "       CASE WHEN a.user_id IS NOT NULL THEN 1 ELSE 0 END AS isAdmin " +
            "FROM users u LEFT JOIN admin a ON a.user_id = u.id";
        try (PreparedStatement st = db.prepareStatement(query);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                users.add(mapUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // ── existsByUsername ──────────────────────────────────────────────────────
    public boolean existsByUsername(String username) {
        String query = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── existsByEmail ─────────────────────────────────────────────────────────
    public boolean existsByEmail(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── checkLogin ────────────────────────────────────────────────────────────
    // admin column removed from users; joined from separate admin table
    public boolean checkLogin(User user) {
        String query =
            "SELECT u.id, u.name, u.username, u.password, u.email, u.location, " +
            "       u.userType, u.posicions, u.picture, u.colla, " +
            "       CASE WHEN a.user_id IS NOT NULL THEN 1 ELSE 0 END AS isAdmin " +
            "FROM users u LEFT JOIN admin a ON a.user_id = u.id " +
            "WHERE u.username = ? AND u.password = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setLocation(rs.getString("location"));
                    user.setUserType(rs.getString("userType"));
                    user.setPosicions(rs.getString("posicions"));
                    user.setPicture(rs.getString("picture"));
                    user.setColla(rs.getString("colla"));
                    user.setAdmin(rs.getInt("isAdmin"));
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── save ──────────────────────────────────────────────────────────────────
    public void save(User user) {
        String query =
            "INSERT INTO users (name, password, picture, colla, username, location, userType, email, posicions) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setString(1, user.getName());
            st.setString(2, user.getPassword());
            st.setString(3, user.getPicture());
            st.setString(4, user.getColla());
            st.setString(5, user.getUsername());
            st.setString(6, user.getLocation());
            st.setString(7, user.getUserType());
            st.setString(8, user.getEmail());
            st.setString(9, user.getPosicions());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── findByName ────────────────────────────────────────────────────────────
    public Optional<User> findByName(String username) {
        String query = "SELECT id, username, password, picture, email FROM users WHERE name = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setPicture(rs.getString("picture"));
                user.setEmail(rs.getString("email"));
                return Optional.of(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    // ── findById ──────────────────────────────────────────────────────────────
    public Optional<User> findById(Integer id) {
        String query = "SELECT id, name, username, picture FROM users WHERE id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setUsername(rs.getString("username"));
                    user.setPicture(rs.getString("picture"));
                    return Optional.of(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    // ── update ────────────────────────────────────────────────────────────────
    public void update(User user) {
        String query = "UPDATE users SET name=?, email=?, location=?, colla=?, posicions=? WHERE id=?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setString(1, user.getName());
            st.setString(2, user.getEmail());
            st.setString(3, user.getLocation());
            st.setString(4, user.getColla());
            st.setString(5, user.getPosicions());
            st.setInt(6, user.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── findFullById ──────────────────────────────────────────────────────────
    public Optional<User> findFullById(Integer id) {
        String query =
            "SELECT u.id, u.name, u.username, u.email, u.location, u.userType, " +
            "       u.colla, u.picture, u.posicions, " +
            "       CASE WHEN a.user_id IS NOT NULL THEN 1 ELSE 0 END AS isAdmin " +
            "FROM users u LEFT JOIN admin a ON a.user_id = u.id " +
            "WHERE u.id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) return Optional.of(mapUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    // ── deleteById ───────────────────────────────────────────────────────────
    public void deleteById(Integer id) {
        // FK ON DELETE CASCADE handles posts, likes, follows, admin entries
        String query = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── existsByEmailExcluding ────────────────────────────────────────────────
    public boolean existsByEmailExcluding(String email, Integer userId) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ? AND id != ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setString(1, email);
            st.setInt(2, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── collaExists ───────────────────────────────────────────────────────────
    public boolean collaExists(String colla) {
        List<String> collesValides = List.of(
            "Castellers de Vilafranca",
            "Colla Vella dels Xiquets de Valls",
            "Colla Joves Xiquets de Valls",
            "Minyons de Terrassa",
            "Capgrossos de Mataró"
        );
        return collesValides.contains(colla);
    }

    // ── private helper ────────────────────────────────────────────────────────
    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setName(rs.getString("name"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setLocation(rs.getString("location"));
        user.setUserType(rs.getString("userType"));
        user.setColla(rs.getString("colla"));
        user.setPicture(rs.getString("picture"));
        user.setPosicions(rs.getString("posicions"));
        user.setAdmin(rs.getInt("isAdmin"));
        return user;
    }
}
