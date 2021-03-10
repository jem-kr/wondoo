/* ===============================
	우편번호 찾기
   ===============================
*/

var cust_Zipcode = $('#cust_Zipcode').val();

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
			document.getElementById('cust_Zipcode').value = data.zonecode;
			document.getElementById('fakecust_Zipcode').value = data.zonecode;
			document.getElementById("cust_ADR01").value = addr;
			document.getElementById("fakecust_ADR01").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("cust_ADR02").focus();
		}
	}).open({
		left: (window.screen.width / 2) - (width / 2),
		top: (window.screen.height / 2) - (height / 2)
	});
}

/* ===============================
	개인회원 정보 수정 시 유효성
   ===============================
*/
		var font_color = '#5080BF';
		var custPWCheck = false;
		var custNameCheck = false;
		var custContactCheck = false;
		var custBirthCheck = false;
		
		$(document).ready(function() {
			$("#cust_PW").keyup(function() {
				if ($(this).val().length < 8) {
					$("#err_custPW").text('비밀번호는 8글자 이상 입력하세요!');
					$("#err_custPW").css("color", font_color);
				} else {
					$("#err_custPW").text('');
					custPWCheck = true;
				}
			});
			$("#cust_PW").blur(function() {
				var cust_PW = $('#cust_PW').val();
				if (cust_PW.length == 0) {
					$("#err_custPW").text('필수 입력 항목입니다.');
					$("#err_custPW").css("color", font_color);
				} else {
					$("#err_custPW").text('');
				}
			});
			
			$("#cust_Name").keyup(function() {
				if ($(this).val().length < 1) {
					$("#err_custName").text('이름은 1글자 이상 입력하세요!');
					$("#err_custName").css("color", font_color);
				} else {
					$("#err_custName").text('');
					custNameCheck = true;
				}
			});
			$("#cust_Name").blur(function() {
				var cust_Name = $('#cust_Name').val();
				if (cust_Name.length == 0) {
					$("#err_custName").text('필수 입력 항목입니다.');
					$("#err_custName").css("color", font_color);
				} else {
					$("#err_custName").text('');
				}
			});
						
			$("#cust_Contact").keyup(function() {
				if ($(this).val().length < 6) {
					$("#err_custContact").text('연락처는 6글자 이상 입력하세요!');
					$("#err_custContact").css("color", font_color);
				} else {
					$("#err_custContact").text('');
					custContactCheck = true;
				}
			});
			$("#cust_Contact").blur(function() {
				var cust_Contact = $('#cust_Contact').val();

				if (cust_Contact.length == 0) {
					$("#err_custContact").text('필수 입력 항목입니다.');
					$("#err_custContact").css("color", font_color);
				} else {
					$("#err_custContact").text('');
				}
			});

			$("#cust_Birth").keyup(function() {
				if ($(this).val().length > 5 ) {
					$("#err_custBirth").text('생년월일은 주민등록번호 앞 6자리를 입력해주세요!');
					$("#err_custBirth").css("color", font_color);
				} else {
					$("#err_custBirth").text('');
					custBirthCheck = true;
				}

			});
			$("#cust_Birth").blur(function() {
				var cust_Birth = $('#cust_Birth').val();
				if (cust_Birth.length == 0) {
					$("#err_custBirth").text('필수 입력 항목입니다.');
					$("#err_custBirth").css("color", font_color);
				} else {
					$("#err_custBirth").text('');
				}
			});						
		});
		
/* ===============================
	개인회원 수정 시 수정완료 버튼
   ===============================
*/
		function chk_submit() {
			if (custPWCheck == false || custNameCheck == false || custContactCheck == false || custBirthCheck == false) {
				$('#cust-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('입력한 값을 확인하세요!');
				return false;
			} 

			if($('#cust_PW').val().length < 8){
				$('#cust-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('비밀번호를 다시 확인해주세요!');
				return false;
			} 
			if($('#cust_Name').val().length < 1){
				$('#cust-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('이름을 다시 확인해주세요!');
				return false;
			} 			
			if($('#cust_Contact').val().length < 6){
				$('#cust-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('연락처를 다시 확인해주세요!');
				return false;
			} 					
			if($('#cust_Birth').val().length < 6){
				$('#cust-submit').effect("shake");
				$('button#modalbtn1').attr('data-toggle', 'modal');
				$('#modal-title').html(
						'<i class="fas fa-exclamation-circle"></i>');
				$('#modal-body').text('생년월일을 다시 확인해주세요!');
				return false;
			} 		
			return true;
		};

/* ===============================  
	   회원 탈퇴
==================================*/
function getContextPath() {
	var offset = location.href.indexOf(location.host) + location.host.length;
	var ctxPath = location.href.substring(offset, location.href.indexOf('/', offset + 1));
	return ctxPath;
}


function del_check() {
	var cust_Email = $('#cust_Email').val();
	location.href = getContextPath() + "/custDel.cu?cust_Email=" + cust_Email;
}
