package marko.ip.controller;

import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import marko.ip.beans.UserBean;
import marko.ip.dto.User;
import marko.ip.util.FormValidator;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
@MultipartConfig
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controller() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String address = "/WEB-INF/pages/index.jsp";
		String action = request.getParameter("action");
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(60 * 30);

		if (action == null || action.equals("")) {
			address = "/WEB-INF/pages/index.jsp";
		}
		/*
		 * LOGIN
		 */
		else if (action.equals("login")) {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			UserBean userBean = new UserBean();
			if (userBean.login(username, password)) {
				session.setAttribute("userBean", userBean);
				address = "/WEB-INF/pages/home.jsp";
			}
		}
		/*
		 * LOGOUT
		 */
		else if (action.equals("logout")) {
			session.invalidate();
			address = "/WEB-INF/pages/index.jsp";
		}
		/*
		 * REGISTER
		 */
		else if (action.equals("register")) {
			address = "/WEB-INF/pages/register.jsp";
		}
		/*
		 * REGISTER USER
		 */
		else if (action.equals("registerUser")) {
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String username = request.getParameter("username");
			String password1 = request.getParameter("password1");
			String password2 = request.getParameter("password2");
			String email = request.getParameter("email");

			String registerResultMessage = FormValidator.validateRegisterForm(firstName, lastName, username, password1,
					password2, email);
			UserBean userBean = new UserBean();
			User newUser = new User(firstName, lastName, username, password1, email);
			userBean.setUser(newUser);
			session.setAttribute("userBean", userBean);
			if (registerResultMessage.equals("OK")) {
				if (!(userBean.isUsernameUsed(username))) {
					if (!(userBean.isEmailUsed(email))) {
						if (userBean.addUser()) {
							System.out.println(newUser.getUsername() + " succesfully registered.");
							userBean.readUser();
							session.setAttribute("userBean", userBean);
							address = "WEB-INF/pages/profile.jsp";
						}
					} else {
						registerResultMessage = "Email is already used.";
						address = "WEB-INF/pages/register.jsp";
					}
				} else {
					registerResultMessage = "Username is already used.";
					address = "WEB-INF/pages/register.jsp";
				}
			} else {
				address = "WEB-INF/pages/register.jsp";
			}
			session.setAttribute("registerResultMessage", registerResultMessage);
		}
		/*
		 * PROFILE PAGE
		 */
		else if(action.equals("profile")) {
			address = "WEB-INF/pages/profile.jsp";
		}
		/*
		 * UPDATE PROFILE
		 */
		else if (action.equals("updateUserProfile")) {
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String username = request.getParameter("username");
			String oldPassword = request.getParameter("oldPassword");
			String password1 = request.getParameter("password1");
			String password2 = request.getParameter("password2");
			String email = request.getParameter("email");
			String country = request.getParameter("country");
			String region = request.getParameter("region");
			String city = request.getParameter("city");
			String flag = request.getParameter("flag");
			String avatar = "";
			String[] checkedValues = request.getParameterValues("notification");
			boolean notificationApp = false;
			boolean notificationEmail = false;
			if (checkedValues != null) {
				for (String checked : checkedValues) {
					if (checked.equals("notificationApp")) {
						notificationApp = true;
					}
					if (checked.equals("notificationEmail")) {
						notificationEmail = true;
					}
				}
			}
			String profileUpdateResult = FormValidator.validateProfileForm(firstName, lastName, username, email);
			if (profileUpdateResult.equals("OK")) {
				Part imgPart = request.getPart("img");
				InputStream input = imgPart.getInputStream();
				if (imgPart.getSubmittedFileName().equals("")) {
					avatar = flag;
				} else {
					avatar = "http://127.0.0.1:8080/dangers-main/assets/img/avatar/" + username + ".jpg";
					ByteArrayOutputStream out = new ByteArrayOutputStream();
					String contextPath = getServletContext().getRealPath("/assets/img/");
					System.out.println(contextPath);
					byte[] buffer = new byte[1024 * 4];
					int read;
					while ((read = input.read(buffer)) != -1) {
						out.write(buffer, 0, read);
					}
					try (OutputStream outputStream = new FileOutputStream(contextPath + username + ".jpg")) {
						out.writeTo(outputStream);
					}
					input.close();
				}
				UserBean userBean = (UserBean) session.getAttribute("userBean");
				if (!oldPassword.equals("")) {
					userBean.getUser().setPassword(oldPassword);
					userBean.readUser();
					if (userBean.getUser() == null) {
						profileUpdateResult = "Wrong password.";
					} else {
						if (!(password1.equals(password2))) {
							profileUpdateResult = "Passwords dont match.";
						}
					}
				}
				if (!(username.equals(userBean.getUser().getUsername()))) {
					if (!(new UserBean().isUsernameUsed(username))) {
						userBean.getUser().setUsername(username);
					} else {
						profileUpdateResult = "Username is already used.";
					}
				}
				if (!(email.equals(userBean.getUser().getEmail()))) {
					if (!(new UserBean().isEmailUsed(email))) {
						userBean.getUser().setEmail(email);
						;
					} else {
						profileUpdateResult = "Username is already used.";
					}
				}
				if (profileUpdateResult.equals("OK")) {
					userBean.getUser().setUsername(username);
					userBean.getUser().setFirstName(firstName);
					userBean.getUser().setLastName(lastName);
					userBean.getUser().setEmail(email);
					userBean.getUser().setCountry(country);
					userBean.getUser().setRegion(region);
					userBean.getUser().setCity(city);
					userBean.getUser().setAvatar(avatar);
					userBean.getUser().setNotificationApp(notificationApp);
					userBean.getUser().setNotificationEmail(notificationEmail);
					userBean.updateUser();
				} else {
					address = "WEB-INF/pages/profile.jsp";
				}
			} else {
				address = "WEB-INF/pages/profile.jsp";
			}
			session.setAttribute("profileUpdateResult", profileUpdateResult);
		}
		/*
		 * WARNING
		 */
		else if(action.equals("warning")) {
			address = "WEB-INF/pages/warning.jsp";
		}
		/*
		 * ADD WARNING
		 */
		else if(action.equals("addWarning")) {
			String[] categories =request.getParameterValues("category");
			for(String s:categories) {
				System.out.println(s);
			}
			System.out.println(request.getParameter("lat"));
			System.out.println(request.getParameter("lng"));
			address = "WEB-INF/pages/warning.jsp";
		}
		else {
			address = "/WEB-INF/pages/index.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(address);
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
