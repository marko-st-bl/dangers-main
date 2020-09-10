package marko.ip.beans;

import java.io.Serializable;

import marko.ip.dao.UserDAO;
import marko.ip.dto.User;

public class UserBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private boolean isLoggedIn = false;
	private User user = new User();
	
	public boolean login(String username, String password) {
		user = new UserDAO().getUserByUsernamePassword(username, password);
		if(user != null && user.getStatus().equals("active")) {
			isLoggedIn = true;
			return true;
		}
		return false;
	}
	
	public boolean isUsernameUsed(String username) {
		return new UserDAO().isUsernameUsed(username);
	}
	
	public boolean isEmailUsed(String email) {
		return new UserDAO().isEmailUsed(email);
	}
	
	public boolean addUser() {
		return new UserDAO().addUser(user);
	}
	
	public void readUser() {
		user = new UserDAO().getUserByUsernamePassword(user.getUsername(), user.getPassword());
	}
	
	public boolean updateUser() {
		return new UserDAO().updateUser(user);
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	
}
