var font_color = '#5080BF';
var sellLicenseCheck = false;
var sellPicCheck = false;


$(document).ready(function() {
	$("#sell_License").keyup(function() {
		if ($(this).val().length < 1) {
			$("#err_sellLicense").text('사업자번호는 1글자 이상 입력하세요!');
			$("#err_sellLicense").css("color", font_color);
		} else {
			$("#err_sellLicense").text('');
			sellLicenseCheck = true;
		}
	});
	$("#sell_License").blur(function() {
		var sell_License = $('#sell_License').val();
		if (sell_License.length == 0) {
			$("#err_sellLicense").text('필수 입력 항목입니다.');
			$("#err_sellLicense").css("color", font_color);
		} else {
			$("#err_sellLicense").text('');
		}
	});
	
		$("#img").keyup(function() {
		if ($(this).val().length < 1) {
			$("#err_img").text('파일명을 확인하세요!');
			$("#err_img").css("color", font_color);
		} else {
			$("#err_img").text('');
			sellPicCheck = true;
		}
	});
	
	$("#img").blur(function() {
		var img = $('#img').val();
		if (img.length == 0) {
			$("#err_img").text('필수 입력 항목입니다.');
			$("#err_img").css("color", font_color);
		} else {
			$("#err_img").text('');
		}
	});

});

		function chk_submit() {
			if (sellPicCheck == false || sellLicenseCheck == false) {
				$('#submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('입력한 값을 확인하세요!');
				return false;
			} 				

			return true;
		};


function readURL(input) {
	if (input.files && input.files[0]) {

		var reader = new FileReader();

		reader.onload = function(e) {
			$('.image-upload-wrap').hide();

			$('.file-upload-image').attr('src', e.target.result);
			$('.file-upload-content').show();

			$('.image-title').html(input.files[0].name);
		};

		reader.readAsDataURL(input.files[0]);

	} else {
		removeUpload();
	}
}

function removeUpload() {
	$('.file-upload-input').replaceWith($('.file-upload-input').clone());
	$('.file-upload-content').hide();
	$('.image-upload-wrap').show();
}
$('.image-upload-wrap').bind('dragover', function() {
	$('.image-upload-wrap').addClass('image-dropping');
});
$('.image-upload-wrap').bind('dragleave', function() {
	$('.image-upload-wrap').removeClass('image-dropping');
});
