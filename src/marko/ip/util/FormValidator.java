package marko.ip.util;

import marko.ip.beans.UserBean;

public class FormValidator {
	
	//ADD EMAIL VALIDATION REGEX
	public static String validateRegisterForm(String firstName, String lastName, String username, String password1, 
			String password2, String email) {
		String retVal = "OK";
		UserBean userBean = new UserBean();
		
		if(firstName == null || firstName.equals("")) {			
			retVal = "First name cannot be blank.";			
		} else if(lastName == null || lastName.equals("")) {			
			retVal = "Last name cannot be blank.";			
		} else if(username == null || username.equals("")) {			
			retVal = "Username name cannot be blank.";			
		} else if (userBean.isUsernameUsed(username)){			
			retVal = "Username already used";			
		} else if(email == null || email.equals("")) {
			retVal = "Email cannot be blank.";
		} else if (userBean.isEmailUsed(email)) {			
			retVal = "Email already used.";			
		} else if(password1 == null || password1.equals("")) {			
			retVal = "Password cannot be blank.";			
		} else if(password2 == null || password2.equals("")) {			
			retVal = "Password cannot be blank.";		
		} else if(!(password1.equals(password2))){		
			retVal = "Passwords do not match";
		} 
		
		return retVal;
	}
	
	public static String validateProfileForm(String firstName, String lastName, String username, String oldPassword, String password1, String password2, String email, UserBean userBean){
		
		String retVal = "OK";
		
		if(firstName == null || firstName.equals("")) {
			retVal = "First name cannot be blank.";
		} else if(lastName == null || lastName.equals("")) {
			retVal = "Last name cannot be blank.";
		} else if(username == null || username.equals("")) {
			retVal = "Username name cannot be blank.";
		} else if (!username.equals(userBean.getUser().getUsername()) && userBean.isUsernameUsed(username)){		
			retVal = "Username already used.";
		} else if(email == null || email.equals("")) {
			retVal = "Email cannot be blank.";
		} else if(!email.equals(userBean.getUser().getEmail()) && userBean.isEmailUsed(email)) {
			retVal = "Email alraedy used.";
		} else if(!oldPassword.equals("")) {
			if (!(new UserBean().login(userBean.getUser().getUsername(), oldPassword))){
				retVal = "Invalid password.";
			} else if(password1 == null || password1.equals("") || password2 == null || password2.equals("")) {
				retVal = "Password cannot be blank.";
			} else if(!password1.equals(password2)) {
				retVal = "Passwords dont match";
			}
		}
		
		return retVal;
	}
	
	public static String validateWarningForm(String description, String lat, String lng, String[] categories) {
		String retVal = "OK";
		
		if(description == null || description.equals("")) {
			retVal = "You must enter description.";
		} else if(lat != null && !lat.equals("") && lng != null && !lng.equals("")) {
			try {
				double latitude = Double.parseDouble(lat);
				double longitude = Double.parseDouble(lng);
				
				if(latitude < -90) {
					retVal = "Latitude cannot be smaller than -90.";
				} else if (latitude > 90) {
					retVal = "Latitude cannot be greater than 90.";
				} else if ( longitude < -180) {
					retVal = "Longitude cannot be smaller than -180.";
				} else if ( longitude > 180 ) {
					retVal = "Longitude cannot be greater than 180.";
				}
			} catch(NumberFormatException e) {
				retVal = "Error parsing lat/lng. You must enter valid number.";
			}
		} else if ( categories == null) {
			retVal = "You must choose at least one category.";
		}
		
		return retVal;
	}
}
