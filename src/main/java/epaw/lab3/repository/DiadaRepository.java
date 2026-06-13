package epaw.lab3.repository;

import epaw.lab3.model.Diada;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DiadaRepository extends BaseRepository {

    public DiadaRepository() { super(); }

    private Diada map(ResultSet rs) throws SQLException {
        Diada d = new Diada();
        d.setId(rs.getInt("id"));
        d.setName(rs.getString("name"));
        d.setDia(rs.getString("dia"));
        d.setLocation(rs.getString("location"));
        d.setColla(rs.getString("colla"));
        d.setCreatedAt(rs.getString("created_at"));
        return d;
    }

    public List<Diada> findAll() {
        List<Diada> list = new ArrayList<>();
        String sql = "SELECT id, name, dia, location, colla, created_at FROM diada ORDER BY dia ASC";
        try (PreparedStatement ps = db.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Diada findById(int id) {
        String sql = "SELECT id, name, dia, location, colla, created_at FROM diada WHERE id = ?";
        try (PreparedStatement ps = db.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public void save(Diada d) {
        String sql = "INSERT INTO diada (name, dia, location, colla, created_at) VALUES (?,?,?,?,datetime('now'))";
        try (PreparedStatement ps = db.prepareStatement(sql)) {
            ps.setString(1, d.getName());
            ps.setString(2, d.getDia());
            ps.setString(3, d.getLocation());
            ps.setString(4, d.getColla());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deleteById(int id) {
        String sql = "DELETE FROM diada WHERE id = ?";
        try (PreparedStatement ps = db.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}
