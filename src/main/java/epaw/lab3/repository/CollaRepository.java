package epaw.lab3.repository;

import epaw.lab3.model.Colla;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CollaRepository extends BaseRepository {

    public CollaRepository() { super(); }

    public List<Colla> findAll() {
        List<Colla> list = new ArrayList<>();
        String sql = "SELECT name FROM colla ORDER BY name ASC";
        try (PreparedStatement ps = db.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(new Colla(rs.getString("name")));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
