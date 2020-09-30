const POSTS_URL = 'http://localhost:8080/dangers-main/Posts';
/*
function loadPosts() {
	$.ajax({
				url : POSTS_URL,
				type : 'get'
			}).done(
					function(posts) {
						
						console.log(posts);
						
						for ( let i in posts) {
							let output = '';
							if ($('#post-' + posts[i].id).length == 0
									&& posts[i].type != "rss") {
								showUserPost(posts[i]);
								output += '<div id="post-'
										+ posts[i].id
										+ '" class="post border rounded my-1">'
										+ '<div class="row align-items-center">'
										+ '<img class="avatar rounded-circle" src="'
										+ posts[i].author.avatar + '" alt="">'
										+ '<h5 class="p-2">'
										+ posts[i].author.firstName
										+ posts[i].author.lastName + '</h5>'
										+ '</div>'
										+ '<div class="row text-muted">'
										+ posts[i].createdAt + '</div>'
										+ '<div class="row">'
										+ '<p class="my-1">' + posts[i].description
										+ '</p>' + '</div>';
								if (posts[i].type == "image") {
									output += '<div class="row">'
											+ '<img class="my-2 post-image" src="'
											+ posts[i].url + '">' + '</div>';
								} else if (posts[i].type == "video") {
									output += '<div class="row">'
											+ '<video class="my-2" width="100%" controls>'
											+ '<source src="' + posts[i].url
											+ '" type="video/mp4"/>'
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
											+ '<a class="my-2" target="_blank" href="'
											+ posts[i].url + '">LINK</a>'
											+ '</div>';
								} else if (posts[i].type == "warning"){
									output += '<div class="row">';
										for(let j in posts[i].categories){
											output += '<span class="badge badge-pill badge-danger text-lowercase">'
												+ posts[i].categories[j].name
												+ '</span>';
										}
										output+= '</div>';
										if(posts[i].lat != 0 && posts[i].lng != 0){
											output+= '<div class="row">'
												+ '<div id="map-'+posts[i].id+'" class="map">'
												+ '</div>'
												+ '</div>';
											//drawMap(map, posts[i].lat, posts[i].lng);
											
										}
								}
								output += '<div class="row">'
										+ '<button id="comment-btn-'
										+ posts[i].id
										+ '" class="post-button btn col-6" type="button"><i class="far fa-comment"></i> Comment</button>'
										+ '<button id="comments-btn-'
										+ posts[i].id
										+ '" class="post-button btn col-6" type="button"><i class="far fa-comments"></i> Comments</button>'
										+ '</div>'
										+ '<div class="share-buttons-container row justify-content-end">'
										+ '<iframe id="tweet-button" allowtransparency="true" frameborder="0" scrolling="no" src="http://platform.twitter.com/widgets/tweet_button.html?via=&amp;text='
										+ posts[i].url
										+ '&amp;count=horizontal" style="width:110px; height:20px;"></iframe>'
										+ '<iframe id="share-button" src="https://www.facebook.com/plugins/share_button.php?href='
										+ posts[i].url
										+ '&layout=button&size=small&width=67&height=20&appId" width="67" height="20" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true" allow="encrypted-media"></iframe>'
										+ '</div>'
										+ '<div id="comments-'
										+ posts[i].id
										+ '" class="comments py-2" style="display: none">';
								for ( let j in posts[i].comments) {
									output += '<div class="row my-2">'
											+ '<div class="comment-avatar-container col-2 col-lg-1">'
											+ '<img class="comment-avatar rounded-circle" src="'
											+ posts[i].comments[j].author.avatar
											+ '" alt="">'
											+ '</div>'
											+ '<div class="col-10 col-lg-11">'
											+ '<div class="p-2 bg-light border rounded">'
											+ '<h6 class="comment-author">'
											+ posts[i].comments[j].author.firstName
											+ ' '
											+ posts[i].comments[j].author.lastName
											+ '</h6>'
											+ '<p class="comment-text">'
											+ posts[i].comments[j].description
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

								output += '<div id="comment-container-'
										+ posts[i].id
										+ '" class="new-comment-container row align-items-center" style="display: none">'
										+ '<div class="p-1 col-2">'
										+ '<img class="rounded-circle comment-avatar" src="'
										+ posts[i].author.avatar
										+ '">'
										+ '</div>'
										+ '<div class="p-1 col-10">'
										+ '<form id="form-'
										+ posts[i].id
										+ '" action="http://localhost:8080/dangers-main/NewComment" method="POST" enctype="multipart/form-data">'
										+ '<div class="comment-form row">'
										+ '<input id="comment-input-'
										+ posts[i].id
										+ '" class="col-9" type="text" name="text" placeholder="Write a comment..."/>'
										+ '<button id="new-comment-btn-'
										+ posts[i].id
										+ '" class="btn col-2" type="button"><i class="fas fa-image"></i></button>'
										+ '</div>'
										+ '<input id="comment-img-input-'
										+ posts[i].id
										+ '" type="file" name="image" accept="image/*" style="display: none"/>'
										+ '<input type="text" name="postId" value="'
										+ posts[i].id
										+ '" style="display: none"/>'
										+ '<button id="btn-'
										+ posts[i].id
										+ '" type="submit" style="display: none"></button>'
										+ '</form>' + '</div>' + '<div>'
										+ '<div class="row">'
										+ '<img id="comment-img-preview-'
										+ posts[i].id
										+ '" src="" width="100%">' + '</div>'
										+ '</div>' + '</div>' + '</div>';

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
								$('#comment-img-input-' + posts[i].id).change(
										function() {
											let file = this.files[0];
											if (file) {
												let src = URL
														.createObjectURL(file);
												console.log(src);
												$(
														'#comment-img-preview-'
																+ posts[i].id)
														.attr('src', src);
											} else {
												$(
														'#comment-img-preview-'
																+ posts[i].id)
														.attr('src', '');
											}
										});
								$('#comment-input-' + posts[i].id).keypress(
										function(e) {
											if (e.which == 13) {
												e.preventDefault();
												if ($(
														'#comment-input-'
																+ posts[i].id)
														.val()) {
													let form = $('#form-'
															+ posts[i].id);
													console.log(form);
													form.submit();
												}
											}
										});
								$('#form-' + posts[i].id)
										.submit(
												function(e) {
													e.preventDefault();
													$.ajax({
																url : $(this).attr('action'),
																		type : $(this).attr('method'),
																		data : new FormData(this),
																		contentType : false,
																		cache : false,
																		processData : false,
																	}).done(function(response) {
																		$('#form-'+ posts[i].id)
																				.each(function() {
																							this.reset();
																						});
																		$('#comment-img-preview-'+ posts[i].id).attr('src','');
																	});
												});
								$('#share-btn-' + posts[i].id).click(
										function() {
											$('#share-buttons-' + posts[i].id)
													.toggle();
										});
								/*
								if(posts[i].lat != 0 && posts[i].lng != 0){
									drawMap('map-' + posts[i].id, posts[i].lat, posts[i].lng);
								}
								
								
							} else if ($("#post-" + posts[i].id).length !== 0
									&& posts[i].type !== "rss") {
								$('#comments-' + posts[i].id).empty();
								let output = '';
								for ( let j in posts[i].comments) {
									output += '<div class="row my-2">'
											+ '<div class="comment-avatar-container col-2 col-lg-1">'
											+ '<img class="comment-avatar rounded-circle" src="'
											+ posts[i].comments[j].author.avatar
											+ '" alt="">'
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
								$('#comments-' + posts[i].id).append(output);
								
							} else if ($("#post" + posts[i].guid).length == 0
									&& posts[i].type == "rss") {
								$('.posts')
										.prepend(
												'<div id="post'
														+ posts[i].guid
														+ '" class="post border rounded my-1">'
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
														+ posts[i].description
														+ '<a target="_blank" href="'
														+ posts[i].url
														+ '"> Read More</a>'
														+ '</p>' + '</div>'
														+ '</div>');
							}
						}
					});
}
*/

function drawMap(id, lat, lng){

		    var myLatLng = {
		      lat: lat,
		      lng: lng
		    };

		    var map = new google.maps.Map(document.getElementById(id), {
		      zoom: 11,
		      center: myLatLng
		    });

		    var marker = new google.maps.Marker({
		      position: myLatLng,
		      map: map
		    });
		    
}

function getPosts(){
	let xhr = new XMLHttpRequest();
	xhr.open('get', POSTS_URL, 'true');
	xhr.onload = function(){
		if(this.status == 200){
			let posts = JSON.parse(this.responseText);
			for(post of posts){
				if(post.type != "rss"){
					showUserPost(post);
				} else if(post.type == "rss"){
					showRSSPost(post);
				}
			}
		}
	}
	xhr.send();
}

function showUserPost(post){
	if(!document.getElementById(`post-${post.id}`)){
		let postDiv = document.createElement("div");
		postDiv.id = `post-${post.id}`;
		postDiv.classList.add("post", "border", "rounded", "my-1");
		
		let row1 = document.createElement("div");
		row1.classList.add("row", "align-items-center");
		let imgAuthor = document.createElement('img');
		imgAuthor.src = post.author.avatar;
		imgAuthor.classList.add("avatar", "rounded-circle");
		let author = document.createElement('h5');
		author.classList.add("p-2");
		author.innerHTML = `${post.author.firstName} ${post.author.lastName}`;
		
		row1.append(imgAuthor);
		row1.append(author);
		postDiv.append(row1);
		
		let row2 = document.createElement("div");
		row2.classList.add("row", "text-muted");
		row2.innerHTML = post.createdAt;
		postDiv.append(row2);
		
		let desc = document.createElement('p');
		desc.innerHTML = post.description;
		postDiv.append(desc);
		
		switch(post.type){
		
		case "youtube":
			let row3 = document.createElement("div");
			row3.classList.add("row");
			let embedDiv = document.createElement("div");
			embedDiv.classList.add("embed-responsive", "embed-responsive-16by9");
			let iframe = document.createElement('iframe');
			iframe.classList.add("embed-responsive-item");
			iframe.src=`https://www.youtube.com/embed/${post.url.split("?v=")[1]}`;
			embedDiv.append(iframe);
			row3.append(embedDiv);
			postDiv.append(row3);
			break;
			
		case "link":
			let linkDiv = document.createElement("div");
			linkDiv.classList.add("row");
			let link = document.createElement("a");
			link.classList.add("py-2");
			link.href = post.url;
			link.target = "_blank";
			link.innerHTML = '&lt;&ltLINK&gt;&gt;'
			
			linkDiv.append(link);
			postDiv.append(linkDiv);
			break;
			
		case "image":
			let imageDiv = document.createElement("div");
			imageDiv.classList.add("row");
			let image = document.createElement("img");
			image.classList.add("post-image py-2");
			image.src = post.url;
			
			imageDiv.append(image);
			postDiv.append(imageDiv);
			break;
			
		case "video":
			let videoDiv = document.createElement("div");
			videoDiv.classList.add("row");
			let video = document.createElement("video");
			video.classList.add("my-2");
			video.style.width = "100%";
			video.controls = "controls";
			let source = document.createElement("source");
			source.src = post.url;
			source.type = "video/mp4";
			video.append(source);
			videoDiv.append(video);
			postDiv.append(videoDiv);
			break;
			
		case "warning":
			let warningDiv = document.createElement("div");
			warningDiv.classList.add("row");
			for(category of post.categories){				
				let categorySpan = document.createElement("span");
				categorySpan.classList.add("badge", "badge-pill", "badge-danger", "text-lowercase", "mx-1");
				categorySpan.innerHTML = category.name;
				warningDiv.append(categorySpan);	
			}
			postDiv.append(warningDiv);
			
			if(post.lat && post.lng){
				let mapDiv =document.createElement("div");
				mapDiv.classList.add("row", "my-2");
				let map = document.createElement("div");
				map.id = `map-${post.id}`;
				map.classList.add("map");
				mapDiv.append(map);
				postDiv.append(mapDiv);
			}
			break;
			default:
				break;}
		
		document.querySelector('.posts').prepend(postDiv);
		if(post.type == "warning"){
			drawMap(`map-${post.id}`, post.lat, post.lng);
		}
		
		let commentButtonsDiv = document.createElement("div");
		commentButtonsDiv.classList.add("row");
		let commentButton = document.createElement("button");
		commentButton.id = `comment-btn-${post.id}`;
		commentButton.classList.add("post-button", "btn", "col-6");
		commentButton.type = "button";
		commentButton.setAttribute("data-toggle", "collapse");
		commentButton.setAttribute("data-target", `#comment-container-${post.id}`);
		commentButton.setAttribute("aria-expanded", "false");
		commentButton.setAttribute("aria-controls", `comment-container-${post.id}`);
		commentButton.innerHTML = '<i class="far fa-comment"></i> Comment';
		let commentsButton = document.createElement("button");
		commentsButton.id = `comments-btn-${post.id}`;
		commentsButton.classList.add("post-button", "btn", "col-6");
		commentsButton.type = "button";
		commentsButton.setAttribute("data-toggle", "collapse");
		commentsButton.setAttribute("data-target", `#comments-${post.id}`);
		commentsButton.setAttribute("aria-expanded", "false");
		commentsButton.setAttribute("aria-controls", `comments-${post.id}`);
		commentsButton.innerHTML = '<i class="far fa-comments"></i> Comments';
		
		commentButtonsDiv.append(commentButton);
		commentButtonsDiv.append(commentsButton);
		document.querySelector(`#post-${post.id}`).append(commentButtonsDiv);
		
		let shareButtonsDiv = document.createElement("div");
		shareButtonsDiv.classList.add("share-buttons-container", "row", "justify-content-end");
		let tweeterButton = document.createElement("iframe");
		tweeterButton.src =`http://platform.twitter.com/widgets/tweet_button.html?via=&amp;text=${post.url ? post.url:post.description}&amp;count=horizontal`;
		tweeterButton.scrolling = "no";
		tweeterButton.frameBorder = "0";
		tweeterButton.allowtransparency= "true";
		tweeterButton.style = "width: 80px; height: 20px;";
		let fbButton = document.createElement("iframe");
		fbButton.src = `https://www.facebook.com/plugins/share_button.php?href=${post.url ? post.url : 'http://localhost:8080/dangers-main/?action=home/'}&layout=button&size=small&width=67&height=20&appId`;
		fbButton.width = "67";
		fbButton.height = "20";
		fbButton.style = "border:none;overflow:hidden";
		fbButton.scrolling = "no";
		fbButton.frameborder = "0";
		fbButton.allowTransparency = "true";
		fbButton.allow = "encrypted-media";
		shareButtonsDiv.append(tweeterButton);
		shareButtonsDiv.append(fbButton);
		document.querySelector(`#post-${post.id}`).append(shareButtonsDiv);
		let commentsDiv = document.createElement("div");
		commentsDiv.classList.add("collapse", "comments", "py-2");
		commentsDiv.id = `comments-${post.id}`;
		document.querySelector(`#post-${post.id}`).append(commentsDiv);
		
		showComments(post);
		
		let newCommentContainer = document.createElement("div");
		newCommentContainer.classList.add("collapse", "new-comment-container", "row", "align-items-center", "border-top", "mt-2");
		newCommentContainer.id = `comment-container-${post.id}`;
		newCommentContainer.innerHTML = `<div class="col-12 p-0">
											<form id="form-${post.id}"
											action="http://localhost:8080/dangers-main/NewComment" method="POST" enctype="multipart/form-data">
												<div class="comment-form row justify-content-between my-2">
													<input id="comment-input-${post.id}"
													class="col-9 form-control pl-1" type="text" name="text" placeholder="Write a comment..."/>
													<button class="btn btn-outline-primary col-2" type="submit">Post</button>
													<button id="new-comment-btn-${post.id}"
													class="btn col-1" type="button"><i class="fas fa-image"></i></button>
												</div>
												<input id="comment-img-input-${post.id}"
												type="file" name="image" accept="image/*" style="display: none"/>
												<input type="text" name="postId" value="${post.id}" style="display: none"/>
												<button id="btn-${post.id}" type="submit" style="display: none"></button>
											</form>
											<div class="row mx-0">
												<img id="comment-img-preview-${post.id}" src="" width="100%">
											</div>
										</div>`;
		document.querySelector(`#post-${post.id}`).append(newCommentContainer);
		
		let imgBtn = document.getElementById(`new-comment-btn-${post.id}`);
		imgBtn.addEventListener("click", function(){
			document.getElementById(`comment-img-input-${post.id}`).click();
		});
		
		let imgInput = document.getElementById(`comment-img-input-${post.id}`);
		imgInput.addEventListener("change", function(){
			let file = this.files[0];
			if (file) {
				let src = URL.createObjectURL(file);
				console.log(src);
				document.getElementById(`comment-img-preview-${post.id}`).src = src;
			} else {
				document.getElementById(`comment-img-preview-${post.id}`).src = "";
			}
		});
		
		let form = document.getElementById(`form-${post.id}`).addEventListener("submit", function(e){
			let form = this;
			e.preventDefault();
			const xhr = new XMLHttpRequest();
			let formData = new FormData(this);
			xhr.open(this.method, this.action, "true");
			
			xhr.addEventListener("load", function(){
				if(this.status == 200){
					console.log('Comment posted...');
					form.reset();
					document.getElementById(`comment-img-preview-${post.id}`).src = "";
				}
			});
			xhr.send(formData);
		});
		
	} else if(document.getElementById(`post-${post.id}`)){
		showComments(post);
	}
}

function showComments(post){
	let commentsDiv = document.getElementById(`comments-${post.id}`);
	if(commentsDiv){
		commentsDiv.innerHTML = "";				
	
	for(comment of post.comments){
		let commentDiv = document.createElement("div");
		commentDiv.classList.add("row", "my-2");
		let commentAvatar = document.createElement("div");
		commentAvatar.classList.add("comment-avatar-container", "col-2", "col-lg-1");
		commentAvatar.innerHTML = `<img class="comment-avatar rounded-circle" src="${comment.author.avatar}" alt="">`;
		let commentContainer = document.createElement("div");
		commentContainer.classList.add("col-10", "col-lg-11");
		commentContainer.innerHTML = `<div class="p-2 bg-light border rounded">
										 <h6 class="comment-author">${comment.author.firstName} ${comment.author.lastName}</h6>
										 <p class="comment-text">${comment.text}</p></div>`;
		if(comment.url){
			commentContainer.innerHTML += `<img src="${comment.url}" alt="" width="100%">`;
		}
		commentDiv.append(commentAvatar);
		commentDiv.append(commentContainer);
		commentsDiv.append(commentDiv);
	}
	}
}

function showRSSPost(post){
	if(!document.getElementById(`post-${post.guid}`)){
		let postDiv = document.createElement("div");
		postDiv.id = `post-${post.guid}`;
		postDiv.classList.add("post", "border", "rounded", "my-1");
		postDiv.innerHTML = `<div class="row">
								<h5 class="pl-2">${post.title}</h5>
							 </div>
							 <div class="row text-muted">
							 	${post.createdAt}
							 </div>
							 <p class="my-1">${post.description}
							 <a target="_blank" href="${post.url}"> Read More</a></p>`;
		document.querySelector(".posts").prepend(postDiv);
	}
}