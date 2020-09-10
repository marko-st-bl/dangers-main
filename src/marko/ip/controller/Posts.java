package marko.ip.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import marko.ip.beans.PostBean;
import marko.ip.dto.Post;
import marko.ip.rss.RSSFeed;
import marko.ip.rss.RSSFeedMessage;
import marko.ip.rss.RSSFeedParser;

/**
 * Servlet implementation class Posts
 */
@WebServlet("/Posts")
public class Posts extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Gson gson = new Gson();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Posts() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Post> posts = new PostBean().getAllPosts();
		RSSFeedParser rssParser = new RSSFeedParser("https://europa.eu/newsroom/calendar.xml_en?field_nr_events_by_topic_tid=151");
		RSSFeed rssFeed = rssParser.readFeed();
		DateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z");
		for(RSSFeedMessage message: rssFeed.getEntries()) {
			Post post = new Post();
			post.setType("rss");
			post.setTitle(message.getTitle());
			post.setText(message.getDescription());
			post.setUrl(message.getLink());
			try {
				post.setCreatedAt(new Timestamp(sdf.parse(message.getPubDate()).getTime()));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			posts.add(post);
		}
		Collections.sort(posts);
		String postsJSONString = this.gson.toJson(posts);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE, HEAD");
        response.addHeader("Access-Control-Allow-Headers", "X-PINGOTHER, Origin, X-Requested-With, Content-Type, Accept");
        response.addHeader("Access-Control-Max-Age", "1728000");
		out.print(postsJSONString);
		out.flush();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
