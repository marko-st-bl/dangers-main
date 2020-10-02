//IMAGE FILE TYPES

const imgFileTypes = [
  "image/apng",
  "image/bmp",
  "image/gif",
  "image/jpeg",
  "image/pjpeg",
  "image/png",
  "image/svg+xml",
  "image/tiff",
];

//TOGGLE POST FORM

function addToggleListeners(){
	
	$('#yt-btn').click(function() {
		$('#link-input-div').removeClass('show');
		$('#img-preview').hide();
		$('#video').hide();
		$('#post-type').attr('value', 'youtube');
	});
	
	$('#link-btn').click(function() {
		$('#youtube-input-div').removeClass('show');
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
	const form = document.getElementById('new-post-form');
	form.addEventListener("submit", function(e){
		e.preventDefault();
		
		if(validateForm(form)){
			console.log("valid form");
			const xhr = new XMLHttpRequest();
			xhr.open(form.method, form.action, "true");
			xhr.onload = function(){
				if(this.response == 200){
					console.log("Post form submited.");
					form.reset();
					$('#link-input-div').removeClass('show');
					$('#youtube-input-div').removeClass('show');
					
				} else {
					alert("ERROR!");
				}
			};
			xhr.send(new FormData(form));
		} else {
			console.log("invalid form");
		}
	});
	/*
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
	*/
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

	// VALIDATE POST FORM
function validateForm(form){
	let message = document.getElementById("validation-result");
	let type = form.elements.type;
	let text = form.elements.text;
	let image = form.elements.img;
	let video = form.elements.video;
	let yt = form.elements.youtube;
	let link = form.elements.link;
	
	// accepted youtube patern
	const ytPattern = /^http[s]?:\/\/www\.youtube.com\/watch\?v=[a-zA-z0-9]+$/;
	const urlPattern = /[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi;
	
	switch (type.value){
		case "text":
			if(text.value == ""){
				message.innerHTML = "You must enter some text.";
				return false;
			}
			break;
		case "image":
			let imgFile = image.files[0];
			if(!imgFile){
				message.innerHTML = "No image file selected.";
				return false;
			} else if (!validImgFileType){
				message.innerHTML = "Invalid image file type.";
				return false;
			}
			break;
		case "video":
			let videoFile = video.files[0];
			if(!videoFile){
				message.innerHTML = "No video file selected.";
				return false;
			}
			break;
		case "youtube":
			if(!ytPattern.test(yt.value)){
				message.innerHTML = "You must enter valid youtube link.";
				return false;
			}
			break;
		case "link":
			if(!urlPattern.test(link.value)){
				message.innerHTML = "You must enter valid link.";
				return false;
			}
			break;
		default:
			message.innerHTML = "Invalid post type.";
			return false;			
	}
	
	return true;
}

function validImgFileType(file){
	return imgFileType.includes(file.type);
}