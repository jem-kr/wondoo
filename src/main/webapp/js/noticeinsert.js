var font_color = '#5080BF';
		var titlecheck = false;
		var contentcheck = false;
		var fixcheck = false;
		$(document).ready(function() {

			$("#title").keyup(function() {
				if ($(this).val().length < 3) {
					$("#err_title").text('3글자 이상 입력하세요!');
					$("#err_title").css("color", font_color);
				} else {
					$("#err_title").text('');
					titlecheck = true;
				}

			});
			$("#title").blur(function() {
				var title = $('#title').val();

				if (title.length == 0) {
					$("#err_title").text('제목을 입력하세요!');
					$("#err_title").css("color", font_color);
				} else {
					$("#err_title").text('');
				}
			});

			$("#content").keyup(function() {
				if ($(this).val().length < 10) {
					$("#err_content").text('내용은 10글자 이상 입력하세요!');
					$("#err_content").css("color", font_color);
					
				} else {
					$("#err_content").text('');
					contentcheck = true;

				}

			});
			$("#content").blur(function() {
				var content = $('#content').val();

				if (content.length == 0) {
					$("#err_content").text('내용을 입력하세요!');
					$("#err_content").css("color", font_color);
					
				} else {
					$("#err_content").text('');
					
				}
			});

			$("select#fix").click(function() {
				var fix = $('#fix option:selected').val();
				console.log(fix)
				if (fix == ''||fix ==null) {
					$("#err_fix").text('중요도를 선택하세요!');
					$("#err_fix").css("color", font_color);
				} else {
					$("#err_fix").text('');
					fixcheck = true;
				}
			});

		});
		function chk_submit() {
			if (titlecheck == false || contentcheck == false
					|| fixcheck == false) {
				$('#noti-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('입력한 값을 확인하세요!');
				return false;
			} 
			if($('#title').val().length < 3){
				$('#noti-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('입력한 값을 확인하세요!');
				return false;
			} 
			if($('#content').val().length < 10){
				$('#noti-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('입력한 값을 확인하세요!');
				return false;
			} 
			if($('#fix option:selected').val() == null || $('#fix option:selected').val() == ''){
				$('#noti-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('입력한 값을 확인하세요!');
				return false;
			}
			return true
		};