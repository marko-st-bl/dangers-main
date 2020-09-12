package marko.ip.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class LogutListener implements HttpSessionListener{
	
	@Override
	public void sessionDestroyed(final HttpSessionEvent event) {
		System.out.println("Session destroyed");
	}

}
