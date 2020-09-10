package marko.ip.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import marko.ip.beans.CommentBean;
import marko.ip.beans.PostBean;
import marko.ip.dto.Comment;
import marko.ip.dto.News;
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
		List<News> news = new ArrayList<>();
		List<Post> posts = new PostBean().getAllPosts();
		for(Post post : posts) {
			List<Comment> comments = new CommentBean().getCommentsByPostId(post.getId());
			news.add(new News(post.getId(), post.getOwner(), post.getText(), post.getType(), post.getUrl(), post.getCreatedAt(), comments));
		}
		RSSFeedParser rssParser = new RSSFeedParser("https://europa.eu/newsroom/calendar.xml_en?field_nr_events_by_topic_tid=151");
		RSSFeed rssFeed = rssParser.readFeed();
		DateFormat sdf = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z");
		for(RSSFeedMessage message: rssFeed.getEntries()) {
			try {
				news.add(new News(message.getGuid().replaceAll("[^a-zA-Z]", ""), message.getTitle(), message.getDescription(),
						message.getLink(), new Timestamp(sdf.parse(message.getPubDate()).getTime())));
			} catch (ParseException e1) {
				e1.printStackTrace();
			}
		}
		Collections.sort(news);
		String newsJSONString = this.gson.toJson(news);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE, HEAD");
        response.addHeader("Access-Control-Allow-Headers", "X-PINGOTHER, Origin, X-Requested-With, Content-Type, Accept");
        response.addHeader("Access-Control-Max-Age", "1728000");
		out.print(newsJSONString);
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
