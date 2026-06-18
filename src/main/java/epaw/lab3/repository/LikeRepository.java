package epaw.lab3.repository;

import epaw.lab3.model.Like;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikeRepository extends BaseRepository {

    private static LikeRepository instance;

    private LikeRepository() {
        super();
    }

    public static synchronized LikeRepository getInstance() {
        if (instance == null) {
            instance = new LikeRepository();
        }
        return instance;
    }

    // ── save ──────────────────────────────────────────────────────────────────
    public void save(Like l) {
        String query = "INSERT OR IGNORE INTO likes (user_id, post_id) VALUES (?,?)";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, l.getUserId());
            st.setInt(2, l.getPostId());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── delete ────────────────────────────────────────────────────────────────
    public void delete(Like l) {
        String query = "DELETE FROM likes WHERE user_id = ? AND post_id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, l.getUserId());
            st.setInt(2, l.getPostId());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── getCount ──────────────────────────────────────────────────────────────
    public int getCount(Integer postId) {
        String query = "SELECT COUNT(*) FROM likes WHERE post_id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, postId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
