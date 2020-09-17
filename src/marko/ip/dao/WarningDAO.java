package marko.ip.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import marko.ip.dto.Category;
import marko.ip.dto.Warning;

public class WarningDAO {

	public boolean addWarning(Warning warning) {
		boolean retVal = false;
		Connection conn = null;
		PreparedStatement ps =null;
		PreparedStatement ps1 = null;
		ResultSet rs = null;
		
		String query = "insert into warning (userId, urgent, lat, lon) values (?, ?, ?, ?)";
		String query1 = "insert into warning_has_danger_category () values(?, ?)";
		
		try {
			conn = ConnectionPool.getConnectionPool().checkOut();
			ps = conn.prepareStatement(query);
			ps.setInt(1, warning.getAuthor().getId());
			ps.setBoolean(2, warning.isUrgent());
			ps.setDouble(3, warning.getLat());
			ps.setDouble(4, warning.getLng());
			retVal = ps.executeUpdate() == 1;
			rs = ps.getGeneratedKeys();
			rs.next();
			int warningId = rs.getInt(1);
			ps1 = conn.prepareStatement(query1);
			for(Category cat: warning.getCategories()) {
				ps1.setInt(1, warningId);
				ps1.setInt(2, cat.getId());
				ps1.executeUpdate();
			}
			ps.close();
			ps1.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			ConnectionPool.getConnectionPool().checkIn(conn);
		}
		return retVal;
	}

}
