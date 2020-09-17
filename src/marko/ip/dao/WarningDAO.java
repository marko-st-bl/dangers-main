package marko.ip.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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
		String query1 = "insert into warning_has_danger_category (warningId, dangerCategoryId) values(?, ?)";
		
		try {
			conn = ConnectionPool.getConnectionPool().checkOut();
			ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
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
	
	public List<Warning> getAllWarnings(){
		List<Warning> retVal = new ArrayList<>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String query = "select id, userId, lat, lon, createdAt, urgent "
				+ "from warning";
		
		try {
			conn = ConnectionPool.getConnectionPool().checkOut();
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Warning warning = new Warning(rs.getInt(1), rs.getDouble(3), rs.getDouble(4), 
						rs.getTimestamp(5), rs.getBoolean(6));
				warning.setAuthor(new UserDAO().getUserById(rs.getInt(2)));
				warning.setCategories(new CategoryDAO().getCategoriesForWarning(rs.getInt(1)));
				retVal.add(warning);
			}
			
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			ConnectionPool.getConnectionPool().checkIn(conn);
		}
		return retVal;
	}
	
	public Category getCategoryById(int id) {
		Category retVal = null;
		Connection conn = null;
		PreparedStatement ps =null;
		ResultSet rs = null;
		
		String query = "select id, name "
				+ "from danger_category "
				+ "where id=?";
		
		try {
			conn = ConnectionPool.getConnectionPool().checkOut();
			ps = conn.prepareStatement(query);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				retVal = new Category(rs.getInt(1), rs.getString(2));
			}
			
			ps.close();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.getConnectionPool().checkIn(conn);
		}
		return retVal; 
	}

}
