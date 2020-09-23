/**
 * 
 */

//TOGGLE POST FORM
function addToggleListeners(){
	
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
}

	//SUBMIT POST FORM
function addPostFormSubmitListener(){	
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
}
	
function addPreviewListener(){
	
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
}