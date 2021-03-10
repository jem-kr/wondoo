/* ===============================
	우편번호 찾기
   ===============================
*/

var sell_Zipcode = $('#sell_Zipcode').val();

function zipCheck() {
	var width = 500; //팝업의 너비
	var height = 600; //팝업의 높이
	new daum.Postcode({
		width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
		height: height,
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('sell_Zipcode').value = data.zonecode;
			document.getElementById('fakesell_Zipcode').value = data.zonecode;
			document.getElementById("sell_ADR01").value = addr;
			document.getElementById("fakesell_ADR01").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("sell_ADR02").focus();
		}
	}).open({
		left: (window.screen.width / 2) - (width / 2),
		top: (window.screen.height / 2) - (height / 2)
	});
}

/* ===============================
	사업자회원 정보 수정 시 유효성
   ===============================
*/
		var font_color = '#5080BF';
		var sellPWCheck = false;
		var sellNameCheck = false;
		var sellContactCheck = false;
		
		$(document).ready(function() {
			$("#sell_PW").keyup(function() {
				if ($(this).val().length < 8) {
					$("#err_sellPW").text('비밀번호는 8글자 이상 입력하세요!');
					$("#err_sellPW").css("color", font_color);
				} else {
					$("#err_sellPW").text('');
					sellPWCheck = true;
				}
			});
			$("#sell_PW").blur(function() {
				var sell_PW = $('#sell_PW').val();
				if (sell_PW.length == 0) {
					$("#err_sellPW").text('필수 입력 항목입니다.');
					$("#err_sellPW").css("color", font_color);
				} else {
					$("#err_sellPW").text('');
				}
			});
			
			$("#sell_Name").keyup(function() {
				if ($(this).val().length < 1) {
					$("#err_sellName").text('이름은 1글자 이상 입력하세요!');
					$("#err_sellName").css("color", font_color);
				} else {
					$("#err_sellName").text('');
					sellNameCheck = true;
				}
			});
			$("#sell_Name").blur(function() {
				var sell_Name = $('#sell_Name').val();
				if (sell_Name.length == 0) {
					$("#err_sellName").text('필수 입력 항목입니다.');
					$("#err_sellName").css("color", font_color);
				} else {
					$("#err_sellName").text('');
				}
			});
						
			$("#sell_Contact").keyup(function() {
				if ($(this).val().length < 6) {
					$("#err_sellContact").text('연락처는 6글자 이상 입력하세요!');
					$("#err_sellContact").css("color", font_color);
				} else {
					$("#err_sellContact").text('');
					sellContactCheck = true;
				}
			});
			$("#sell_Contact").blur(function() {
				var sell_Contact = $('#sell_Contact').val();

				if (sell_Contact.length == 0) {
					$("#err_sellContact").text('필수 입력 항목입니다.');
					$("#err_sellContact").css("color", font_color);
				} else {
					$("#err_sellContact").text('');
				}
			});					
		});
		
/* ===============================
	사업자회원 수정 시 수정완료 버튼
   ===============================
*/
		function chk_submit() {
			if (sellPWCheck == false || sellNameCheck == false || sellContactCheck == false) {
				$('#sellup-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('입력한 값을 확인하세요!');
				return false;
			} 

			if($('#sell_PW').val().length < 8){
				$('#sellup-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('비밀번호를 다시 확인해주세요!');
				return false;
			} 
			if($('#sell_Name').val().length < 1){
				$('#sellup-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('이름을 다시 확인해주세요!');
				return false;
			} 			
			if($('#sell_Contact').val().length < 6){
				$('#sellup-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('연락처를 다시 확인해주세요!');
				return false;
			} 					

			return true;
		};
