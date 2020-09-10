<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="marko.ip.beans.UserBean"
	scope="session" />
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
					<li class="nav-item"><a href="#" class="nav-link">Home</a></li>
					<li class="nav-item"><a href="#" class="nav-link">Profile</a>
					</li>
					<li class="nav-item"><a href="?action=logout" class="nav-link">Logout</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div id="main-page" class="container">
		<div class="row">
			<!--SIDEBAR-->
			<div class="profile-sidebar col-sm-3 col-md-2 bg-light">
				<div class="avatar row justify-content-center">
					<img class="rounded-circle"
						src="<%=userBean.getUser().getAvatar()%>" />
				</div>
				<div id="firstName" class="row justify-content-center"><%=userBean.getUser().getFirstName()%></div>
				<div id="lastName" class="row justify-content-center"><%=userBean.getUser().getLastName()%></div>
				<div class="row justify-content-center text-muted" id="numOfLogin"><%=userBean.getUser().getNumOfLogin()%></div>
			</div>
			<!--MAIN-->
			<div class="posts-container col-sm-9 col-md-8">
				<!--POST-FORM-->
				<div class="post-form-container">
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
			<div class=" col-sm-12 col-md-2">
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
        document.body.onload = loadForecast();
        let country = "<%=userBean.getUser().getCountry()%>";
	let countries;
	let lon;
	let lat;

	function loadForecast() {
		let xhr = new XMLHttpRequest();
		xhr.open('GET', 'https://restcountries.eu/rest/v2/region/europe',
				'true');
		xhr.onload = function() {
			if (this.status == 200) {
				countries = JSON.parse(this.responseText);
				let output = '';
				for ( let i in countries) { 
					if (countries[i].name == country) {
						lat = countries[i].latlng[0];
						lon = countries[i].latlng[1];
						console.log(lat + " " + lon);

						xhr1 = new XMLHttpRequest();
						url = 'http://api.openweathermap.org/data/2.5/find?lat='
								+ lat
								+ '&lon='
								+ lon
								+ '&cnt=30&units=metric&&APPID=529b81310379224f19501c0caf39800b';
						xhr1.open('GET', url, 'true');
						xhr1.onload = function() {
							if (this.status == 200) {
								let forecasts = JSON.parse(this.responseText);
								console.log(forecasts);
								let forecast1 = Math.floor(Math.random() * 30);
								let forecast2 = Math.floor(Math.random() * 30);
								let forecast3 = Math.floor(Math.random() * 30);
								document.getElementById('cityName1').innerHTML = forecasts.list[forecast1].name;
								document.getElementById('icon1').src = 'http://openweathermap.org/img/wn/'
										+ forecasts.list[forecast1].weather[0].icon
										+ '@2x.png';
								document.getElementById('temp1').innerHTML = Math
										.round(forecasts.list[forecast3].main.temp)
										+ '&#8451;';
								document.getElementById('cityName2').innerHTML = forecasts.list[forecast2].name;
								document.getElementById('icon2').src = 'http://openweathermap.org/img/wn/'
										+ forecasts.list[forecast2].weather[0].icon
										+ '@2x.png';
								document.getElementById('temp2').innerHTML = Math
										.round(forecasts.list[forecast3].main.temp)
										+ '&#8451;';
								document.getElementById('cityName3').innerHTML = forecasts.list[forecast3].name;
								document.getElementById('icon3').src = 'http://openweathermap.org/img/wn/'
										+ forecasts.list[forecast3].weather[0].icon
										+ '@2x.png';
								document.getElementById('temp3').innerHTML = Math
										.round(forecasts.list[forecast3].main.temp)
										+ '&#8451;';
							}
						}
						xhr1.send();
					}
				}
			}
		}
		xhr.send();
	}

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

	// LOAD POSTS
	$(document).ready(function() {
		loadPosts();
		setInterval(loadPosts, 30000);
	});

	function loadPosts() {
		$
				.ajax({
					url : 'http://localhost:8080/dangers-main/Posts',
					type : 'get'
				})
				.done(
						function(posts) {
							console.log(posts);
							//$('.posts').empty();
							for ( let i in posts) {
								let output = '';
								if ($('#post-' + posts[i].id).length == 0
										&& posts[i].type !== "rss") {
									output += '<div id="post-'+posts[i].id+'" class="post my-1">'
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
											+ '<button id="comment-btn-'+ posts[i].id +'" class="post-button btn col-4" type="button"><i class="far fa-comment"></i> Comment</button>'
											+ '<button class="post-button btn col-4" type="button"><i class="far fa-comments"></i> Comments</button>'
											+ '<button id="share-btn-'+posts[i].id+'" class="post-button btn col-4" type="button"><i class="far fa-share-square"></i> Share</button>'
											+ '</div>'
											+ '<div id="share-buttons-'+posts[i].id+'" class="row justify-content-end" style="display: none">'
											+ '<a class="post-button btn col-4" href="#"><i class="fab fa-facebook"></i> Facebook</a>'
											+ '<a class="post-button btn col-4" href="#"><i class="fab fa-twitter"></i> Twitter</a>'
											+ '</div>'
											+ '<div id="comment-container-'+posts[i].id+'" class="new-comment-container row align-items-center" style="display: none">'
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
											+ '</form>' + '</div>' + '<div>'
											+ '<div class="row">'
											+ '<img id="comment-img-preview-'
											+ posts[i].id
											+ '" src="" width="100%">'
											+ '</div>' + '</div>' + '</div>'
											+ '</div>';

									$('.posts').prepend(output);

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
																			$('#form-' + posts[i].id).each(function(){
																				this.reset();
																			});
																			$('#comment-img-preview-'+posts[i].id).attr('src', '');
																		});
													});
									$('#share-btn-'+posts[i].id).click(function(){
										$('#share-buttons-'+posts[i].id).toggle();
									});
								} else if ($("#post" + posts[i].guid).length == 0
										&& posts[i].type == "rss") {
									$('.posts')
											.prepend(
													'<div id="post'+posts[i].guid+'" class="post my-1">'
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

	/*         //GET POSTS
	 /document.body.onload = getPosts();
	 function getPosts(){
	 let xhr = new XMLHttpRequest();
	 xhr.open('GET', 'http://localhost:8080/dangers-main/Posts', 'true');
	 xhr.onload = function(){
	 if(this.status == 200){
	 let posts = JSON.parse(this.responseText);
	 console.log(posts);
	 }
	 }
	 xhr.send();
	 } */
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