package marko.ip.util;

public class FormValidator {
	
	//ADD EMAIL VALIDATION REGEX
	public static String validateRegisterForm(String firstName, String lastName, String username, String password1, 
			String password2, String email) {
		if(firstName == null || firstName.equals("")) {
			return "First name cannot be blank.";
		}
		if(lastName == null || lastName.equals("")) {
			return "Last name cannot be blank.";
		}
		if(username == null || username.equals("")) {
			return "Username name cannot be blank.";
		}
		if(email == null || email.equals("")) {
			return "Email cannot be blank.";
		}
		if(password1 == null || password1.equals("")) {
			return "Password cannot be blank.";
		}
		if(password2 == null || password2.equals("")) {
			return "Password cannot be blank.";
		}
		if(!(password1.equals(password2))){
			return "Passwords do not match";
		}
		return "OK";
	}
	
	public static String validateProfileForm(String firstName, String lastName, String username, String email){
		if(firstName == null || firstName.equals("")) {
			return "First name cannot be blank.";
		}
		if(lastName == null || lastName.equals("")) {
			return "Last name cannot be blank.";
		}
		if(username == null || username.equals("")) {
			return "Username name cannot be blank.";
		}
		if(email == null || email.equals("")) {
			return "Email cannot be blank.";
		}
		return "OK";
	}
}
