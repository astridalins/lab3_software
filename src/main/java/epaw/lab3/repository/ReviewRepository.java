package epaw.lab3.repository;

import epaw.lab3.model.Review;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewRepository extends BaseRepository {

    public ReviewRepository() { super(); }

    public List<Review> findByDiada(int diadaId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.id, r.user_id, u.name AS uname, r.value, r.created_at " +
                     "FROM review r JOIN users u ON u.id = r.user_id " +
                     "WHERE r.diada_id = ? ORDER BY r.created_at DESC";
        try (PreparedStatement ps = db.prepareStatement(sql)) {
            ps.setInt(1, diadaId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review rev = new Review();
                rev.setId(rs.getInt("id"));
                rev.setUserId(rs.getInt("user_id"));
                rev.setUname(rs.getString("uname"));
                rev.setValue(rs.getInt("value"));
                rev.setCreatedAt(rs.getString("created_at"));
                list.add(rev);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public boolean hasReviewed(int diadaId, int userId) {
        String sql = "SELECT COUNT(*) FROM review WHERE diada_id=? AND user_id=?";
        try (PreparedStatement ps = db.prepareStatement(sql)) {
            ps.setInt(1, diadaId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public Double getAverage(int diadaId) {
        String sql = "SELECT ROUND(AVG(CAST(value AS REAL)), 1) FROM review WHERE diada_id=?";
        try (PreparedStatement ps = db.prepareStatement(sql)) {
            ps.setInt(1, diadaId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double avg = rs.getDouble(1);
                if (!rs.wasNull()) return avg;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public void save(int diadaId, int userId, int value) {
        String sql = "INSERT OR IGNORE INTO review (diada_id, user_id, value, espectador, created_at) " +
                     "VALUES (?, ?, ?, 0, datetime('now'))";
        try (PreparedStatement ps = db.prepareStatement(sql)) {
            ps.setInt(1, diadaId);
            ps.setInt(2, userId);
            ps.setInt(3, value);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}
