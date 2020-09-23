<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="marko.ip.dto.Warning"%>
<%@page import="marko.ip.dto.Category"%>
<jsp:useBean id="userBean" class="marko.ip.beans.UserBean"
	scope="session" />
<jsp:useBean id="warningBean" class="marko.ip.beans.WarningBean"
	scope="session" />
<%
	List<Warning> warnings = warningBean.getAllWarnings();
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dangers Info</title>
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"></script>
<link rel="shortcut icon" href="#">
<link rel="stylesheet" href="css/styles.css" />
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<script src="./js/weather.js"></script>
</head>

<body>
	<!--Navbar-->
	<nav class="navbar sticky-top navbar-expand-md navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="#">Dangers Info</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-ckntrols="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse ml-auto"
				id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a href="?action=home" class="nav-link">Home</a></li>
					<li class="nav-item"><a href="?action=profile"
						class="nav-link">Profile</a></li>
					<li class="nav-item"><a href="?action=warning"
						class="nav-link">Warn</a></li>
					<li class="nav-item"><a href="?action=logout" class="nav-link">Logout</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div id="main-page" class="container">
		<div class="row">
			<!--SIDEBAR-->
			<div class="profile-sidebar col-md-4 col-lg-3">
				<div class="avatar row justify-content-center">
					<img class="rounded-circle"
						src="<%=userBean.getUser().getAvatar()%>" />
				</div>
				<div id="firstName" class="row justify-content-center">
					<h5><%=userBean.getUser().getFirstName()%></h5>
				</div>
				<div id="lastName" class="row justify-content-center">
					<h5><%=userBean.getUser().getLastName()%></h5>
				</div>
				<div class="row justify-content-center text-muted" id="numOfLogin">
					Number of logins
					<%=userBean.getNumOfLogins()%></div>
				<div class="row p-2 text-primary">
					<h5>Notifications</h5>
				</div>
				<div class="notifications-container">
					<div id="warn-list" class="list-group">
					<%
						for(Warning warn:warningBean.getAllWarnings()){
							out.print("<a id=\"warn-"+warn.getId()+"\"");
							if(warn.isLocationSet()){
								out.print("target=\"_blank\" href=\"https://www.google.com/maps/@" +warn.getLat() +","+ warn.getLng()+",15z\"");
							}else{
								out.print("href=\"#\"");
							}						
							out.print("class=\"list-group-item list-group-item-action flex-column align-items-start\">"
							+ "<div class=\"d-flex w-100 justify-content-between\">"
							+	"<h5 class=\"mb-1\">");
							for(Category cat:warn.getCategories()){
								out.print(cat.getName() + " ");
							}
							out.print("</h5>");
							if(warn.isLocationSet()){
								out.print("<i class=\"fas fa-map-marker-alt\"></i>");
							}
								
							out.print("</div>"
							+"<p class=\"mb-1\">");
							out.print(warn.getDescription()
							+"</p> <small>"
							+ warn.getDate() 
							+ "</small>"
							+ "</a>");
						}
						%>
					</div>
				</div>
			</div>
			<!--MAIN-->
			<div class="posts-container col-md-8 col-lg-7">
				<!--POST-FORM-->
				<div class="post-form-container border rounded">
					<div class="post-form-header">
						<h3 class="text-primary">Add new post...</h3>
					</div>
					<div class="post-form">
						<form id="new-post-form" class="form"
							action="http://localhost:8080/dangers-main/NewPost" method="POST"
							enctype="multipart/form-data">
							<div class="row justify-content-center">
								<textarea id="post-text" class="form-control col-11" name="text"
									cols="30" rows="3"
									placeholder="Share text, image, video or link"></textarea>
							</div>
							<div class="row justify-content-center">
								<div class="col-11">
									<button id="img-btn" class="btn" type="button">
										<i class="fas fa-image"></i>
									</button>
									<button id="video-btn" class="btn" type="button">
										<i class="fas fa-video"></i>
									</button>
									<button id="yt-btn" class="btn" type="button">
										<i class="fab fa-youtube"></i>
									</button>
									<button id="link-btn" class="btn" type="button">
										<i class="fas fa-link"></i>
									</button>
								</div>
							</div>
							<input type="file" id="img-input" name="img" accept="image/*"
								style="display: none" /> <input type="file" id="video-input"
								name="video" accept="video/*" style="display: none" /> <input
								type="text" id="post-type" name="type" value="text"
								style="display: none" />
							<div class="row justify-content-center">
								<input id="link-input" class="form-control p-2 col-11"
									type="url" id="link-input" name="link" placeholder="Paste url"
									style="display: none" />
							</div>
							<div class="row justify-content-center">
								<input id="youtube-input" class="p-2 col-11 form-control"
									type="url" name="youtube" placeholder="Paste youtube link"
									style="display: none" />
							</div>
							<div class="row justify-content-center">
								<img id="img-preview" class="p-1 col-11" src="">
								<video id="video" class="p-1 col-11" width="100%" controls
									style="display: none">
									<source id="video-preview" src="" type="video/mp4" />
									<source src="" type="video/ogg" />
								</video>
							</div>

							<div class="text-right">
								<input type="submit" value="Add" class="btn btn-primary m-2" />
							</div>
						</form>
					</div>
				</div>
				<!--POSTS-->
				<div class="posts"></div>
			</div>
			<!--WEATHER-->
			<div class="col-lg-2">
				<div class="forecast">
					<div class="row justify-content-center">
						<div class="cityName" id="cityName1"></div>
					</div>
					<div class="row justify-content-center">
						<img id="icon1" src="" alt="">
					</div>
					<div class="row justify-content-center">
						<div id="temp1"></div>
					</div>
				</div>
				<div class="forecast">
					<div class="row justify-content-center">
						<div class="cityName" id="cityName2"></div>
					</div>
					<div class="row justify-content-center">
						<img id="icon2" src="" alt="">
					</div>
					<div class="row justify-content-center">
						<div id="temp2"></div>
					</div>
				</div>
				<div class="forecast">
					<div class="row justify-content-center">
						<div class="cityName" id="cityName3"></div>
					</div>
					<div class="row justify-content-center">
						<img id="icon3" src="" alt="">
					</div>
					<div class="row justify-content-center">
						<div id="temp3"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
	<!-- JQuery-->
	<script src="./js/jquery-3.5.1.js"></script>
</body>
<!--Script-->
<script>
        //ADD EVENT LISTENERS

        //LOAD FORECAST
    window.addEventListener('DOMContentLoaded', loadForecast('<%= userBean.getUser().getCountry() %>'));


	//SHOW-IMG-PREVIEW
	image = document.getElementById('img-preview');
	document.getElementById('img-input').addEventListener('change', function() {
		let file = this.files[0];
		if (file) {
			video.style = "display: none";
			image.style = "display: block";
			let src = URL.createObjectURL(file);
			console.log(src);
			image.src = src;
		} else {
			image.src = "";
		}
	});
	//SHOW VIDEO PREVIEW
	document.getElementById('video-input').addEventListener('change',
			function() {
				let video = document.getElementById('video');
				let file = this.files[0];
				if (file) {
					let src = URL.createObjectURL(file);
					console.log(src);
					image.style = "display: none";
					video.style = "display: block";
					document.getElementById('video-preview').src = src;
					video.load();
					video.play();
				} else {
					video.style = "display: none";
					document.getElementById('video-preview').src = "";
				}
			});
	// LOAD WARNINGS
	$(document).ready(function(){
		setInterval(loadWarnings, 5000);
	});

	// LOAD POSTS
	$(document).ready(function() {
		loadPosts();
		setInterval(loadPosts, 30000);
	});
	
	function loadWarnings(){
		$.ajax({
			url: 'http://localhost:8080/dangers-main/warnings',
			type: 'get'
		}).done(function(warnings){
			console.log(warnings);
			if(warnings){
				for(let i in warnings){
					let output='';
					if($('#warn-' + warnings[i].id).length == 0){
						output+= '<a id="warn-'+warnings[i].id+'"';
						if(warnings[i].lat && warnings[i].lng){
							output+= 'target="_blank" href="https://www.google.com/maps/@'+warnings[i].lat+','+warnings[i].lng+',15z"';
						}else{
							output+= 'href"#';
						}
						output+= 'class="list-group-item list-group-item-action flex-column align-items-start">';
						output+= '<div class="d-flex w-100 justify-content-between">';
						output+= '<h5 class="mb-1">';
						for(let j in warnings[i].categories){
							output+=warnings[i].categories[j].name + " ";
						}
						output+= '</h5>';
						if(warnings[i].lat && warnings[i].lng){
							output+= '<i class="fas fa-map-marker-alt"></i>'
						}
						output+= '</div>';
						output+= '<p class="mb-1">' + warnings[i].description + '</p>';
						output+='<small>'+warnings[i].createdAt+ '</small>';
						output+= '</a>';
						$('#warn-list').prepend(output);
						
					}
				}
			}
		});
	}

	function loadPosts() {
		$
				.ajax({
					url : 'http://localhost:8080/dangers-main/Posts',
					type : 'get'
				})
				.done(
						function(posts) {
							//console.log(posts);
							for ( let i in posts) {
								let output = '';
								if ($('#post-' + posts[i].id).length == 0
										&& posts[i].type != "rss") {
									output += '<div id="post-'+posts[i].id+'" class="post border rounded my-1">'
											+ '<div class="row align-items-center">'
											+ '<img class="avatar rounded-circle" src="' + posts[i].owner.avatar +'" alt="">'
											+ '<h5 class="p-2">'
											+ posts[i].owner.firstName
											+ posts[i].owner.lastName
											+ '</h5>'
											+ '</div>'
											+ '<div class="row text-muted">'
											+ posts[i].createdAt
											+ '</div>'
											+ '<div class="row">'
											+ '<p class="my-1">'
											+ posts[i].text + '</p>' + '</div>';
									if (posts[i].type == "image") {
										output += '<div class="row">'
												+ '<img class="my-2 post-image" src="'+posts[i].url+'">'
												+ '</div>';
									} else if (posts[i].type == "video") {
										output += '<div class="row">'
												+ '<video class="my-2" width="100%" controls>'
												+ '<source src="' + posts[i].url + '" type="video/mp4"/>'
												+ '</video>' + '</div>';
									} else if (posts[i].type == "youtube") {
										output += '<div class="row">'
												+ '<div class="embed-responsive embed-responsive-16by9">'
												+ '<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/'
												+ posts[i].url.split('?v=')[1]
												+ '" allowfullscreen></iframe>'
												+ '</div>' + '</div>';
									} else if (posts[i].type == "link") {
										output += '<div class="row">'
												+ '<a class="my-2" target="_blank" href="'+posts[i].url+'">LINK</a>'
												+ '</div>';
									}
									output += '<div class="row">'
											+ '<button id="comment-btn-'+ posts[i].id +'" class="post-button btn col-6" type="button"><i class="far fa-comment"></i> Comment</button>'
											+ '<button id="comments-btn-'+posts[i].id+'" class="post-button btn col-6" type="button"><i class="far fa-comments"></i> Comments</button>'
											+ '</div>'
											+ '<div class="share-buttons-container row justify-content-end">'
											+ '<iframe id="tweet-button" allowtransparency="true" frameborder="0" scrolling="no" src="http://platform.twitter.com/widgets/tweet_button.html?via=&amp;text='
											+ posts[i].url
											+ '&amp;count=horizontal" style="width:110px; height:20px;"></iframe>'
											+ '<iframe id="share-button" src="https://www.facebook.com/plugins/share_button.php?href='
											+ posts[i].url
											+ '&layout=button&size=small&width=67&height=20&appId" width="67" height="20" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true" allow="encrypted-media"></iframe>'
											+ '</div>'
											+ '<div id="comments-'+posts[i].id+'" class="comments py-2" style="display: none">';
									for ( let j in posts[i].comments) {
										output += '<div class="row my-2">'
												+ '<div class="comment-avatar-container col-2 col-lg-1">'
												+ '<img class="comment-avatar rounded-circle" src="'+posts[i].comments[j].author.avatar+'" alt="">'
												+ '</div>'
												+ '<div class="col-10 col-lg-11">'
												+ '<div class="p-2 bg-light border rounded">'
												+ '<h6 class="comment-author">'
												+ posts[i].comments[j].author.firstName
												+ ' '
												+ posts[i].comments[j].author.lastName
												+ '</h6>'
												+ '<p class="comment-text">'
												+ posts[i].comments[j].text
												+ '</p>' + '</div>';
										if (posts[i].comments[j]['url']) {
											console.log('PICTURE');
											output += '<img src="'
													+ posts[i].comments[j].url
													+ '" alt="" width="100%">';
										}
										output += '</div>' + '</div>';

									}
									output += '</div>';

									output += '<div id="comment-container-'+posts[i].id+'" class="new-comment-container row align-items-center" style="display: none">'
											+ '<div class="p-1 col-2">'
											+ '<img class="rounded-circle comment-avatar" src="'+ posts[i].owner.avatar +'">'
											+ '</div>'
											+ '<div class="p-1 col-10">'
											+ '<form id="form-'+ posts[i].id +'" action="http://localhost:8080/dangers-main/NewComment" method="POST" enctype="multipart/form-data">'
											+ '<div class="comment-form row">'
											+ '<input id="comment-input-'+ posts[i].id +'" class="col-9" type="text" name="text" placeholder="Write a comment..."/>'
											+ '<button id="new-comment-btn-'+ posts[i].id +'" class="btn col-2" type="button"><i class="fas fa-image"></i></button>'
											+ '</div>'
											+ '<input id="comment-img-input-'+ posts[i].id +'" type="file" name="image" accept="image/*" style="display: none"/>'
											+ '<input type="text" name="postId" value="' + posts[i].id +'" style="display: none"/>'
											+ '<button id="btn-'+ posts[i].id +'" type="submit" style="display: none"></button>'
											+ '</form>'
											+ '</div>'
											+ '<div>'
											+ '<div class="row">'
											+ '<img id="comment-img-preview-'
											+ posts[i].id
											+ '" src="" width="100%">'
											+ '</div>'
											+ '</div>'
											+ '</div>'
											+ '</div>';

									$('.posts').prepend(output);

									$('#comments-btn-' + posts[i].id).click(
											function() {
												$('#comments-' + posts[i].id)
														.toggle();
											});

									$('#comment-btn-' + posts[i].id).click(
											function() {
												$(
														'#comment-container-'
																+ posts[i].id)
														.toggle();
											});
									$('#new-comment-btn-' + posts[i].id).click(
											function() {
												$(
														'#comment-img-input-'
																+ posts[i].id)
														.trigger('click');
											});
									$('#comment-img-input-' + posts[i].id)
											.change(
													function() {
														let file = this.files[0];
														if (file) {
															let src = URL
																	.createObjectURL(file);
															console.log(src);
															$(
																	'#comment-img-preview-'
																			+ posts[i].id)
																	.attr(
																			'src',
																			src);
														} else {
															$(
																	'#comment-img-preview-'
																			+ posts[i].id)
																	.attr(
																			'src',
																			'');
														}
													});
									$('#comment-input-' + posts[i].id)
											.keypress(
													function(e) {
														if (e.which == 13) {
															e.preventDefault();
															if ($(
																	'#comment-input-'
																			+ posts[i].id)
																	.val()) {
																let form = $('#form-'
																		+ posts[i].id);
																console
																		.log(form);
																form.submit();
															}
														}
													});
									$('#form-' + posts[i].id)
											.submit(
													function(e) {
														e.preventDefault();
														$
																.ajax(
																		{
																			url : $(
																					this)
																					.attr(
																							'action'),
																			type : $(
																					this)
																					.attr(
																							'method'),
																			data : new FormData(
																					this),
																			contentType : false,
																			cache : false,
																			processData : false,
																		})
																.done(
																		function(
																				response) {
																			$(
																					'#form-'
																							+ posts[i].id)
																					.each(
																							function() {
																								this
																										.reset();
																							});
																			$(
																					'#comment-img-preview-'
																							+ posts[i].id)
																					.attr(
																							'src',
																							'');
																		});
													});
									$('#share-btn-' + posts[i].id).click(
											function() {
												$(
														'#share-buttons-'
																+ posts[i].id)
														.toggle();
											});
								} else if ($("#post-" + posts[i].id).length !== 0
										&& posts[i].type !== "rss") {
									$('#comments-' + posts[i].id).empty();
									let output = '';
									for ( let j in posts[i].comments) {
										output += '<div class="row my-2">'
												+ '<div class="comment-avatar-container col-2 col-lg-1">'
												+ '<img class="comment-avatar rounded-circle" src="'+posts[i].comments[j].author.avatar+'" alt="">'
												+ '</div>'
												+ '<div class="col-10 col-lg-11">'
												+ '<div class="p-2 bg-light border rounded">'
												+ '<h6 class="comment-author">'
												+ posts[i].comments[j].author.firstName
												+ ' '
												+ posts[i].comments[j].author.lastName
												+ '</h6>'
												+ '<p class="comment-text">'
												+ posts[i].comments[j].text
												+ '</p>' + '</div>';
										if (posts[i].comments[j]['url']) {
											output += '<img src="'
													+ posts[i].comments[j].url
													+ '" alt="" width="100%">';
										}
										output += '</div>' + '</div>';
									}
									output += '</div>';
									$('#comments-' + posts[i].id)
											.append(output);

								} else if ($("#post" + posts[i].guid).length == 0
										&& posts[i].type == "rss") {
									$('.posts')
											.prepend(
													'<div id="post'+posts[i].guid+'" class="post border rounded my-1">'
															+ '<div class="row">'
															+ '<h5 class="pl-2">'
															+ posts[i].title
															+ '</h5>'
															+ '</div>'
															+ '<div class="row text-muted">'
															+ posts[i].createdAt
															+ '</div>'
															+ '<div class="row">'
															+ '<p class="my-1">'
															+ posts[i].text
															+ '<a target="_blank" href="' + posts[i].url +'"> Read More</a>'
															+ '</p>' + '</div>'
															+ '</div>');
								}
							}
						});
	}


	//TOGGLE POST FORM
	$('#yt-btn').click(function() {
		$('#youtube-input').toggle();
		$('#link-input').hide();
		$('#img-preview').hide();
		$('#video').hide();
		$('#post-type').attr('value', 'youtube');
	});

	$('#link-btn').click(function() {
		$('#link-input').toggle();
		$('#youtube-input').hide();
		$('#img-preview').hide();
		$('#video').hide();
		$('#post-type').attr('value', 'link');
	});

	$('#img-btn').click(function() {
		$('#img-input').trigger('click');
		$('#post-type').attr('value', 'image');
	});

	$('#video-btn').click(function() {
		$('#video-input').trigger('click');
		$('#post-type').attr('value', 'video');
	});

	//TOGGLE POST
	$('#share-btn').click(function() {
		$('#share-buttons').toggle();
	});

	//SUBMIT POST FORM
	$('#new-post-form').submit(function(e) {
		e.preventDefault();

		$.ajax({
			url : $(this).attr('action'),
			type : $(this).attr('method'),
			data : new FormData(this),
			contentType : false,
			cache : false,
			processData : false,
		}).done(function(response) {
			if (response == 200) {
				$('#img-preview').hide();
				$('#video').hide();
				$('#link-input').hide();
				$('#youtube-input').hide();
				$('#post-text').val('');
			} else {
				alert('Post not submitted...');
			}
		});
	});
</script>
</body>

</html>