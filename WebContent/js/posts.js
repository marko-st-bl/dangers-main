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