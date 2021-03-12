/*====================
 	장바구니 자바스크립트
 ====================*/

$(document).ready(function() {
	var font_color = "#5080BF";
	var font_size = "15px";
	var font_weight = "bold";
	
	$('#font_step1').css('color', font_color);
	$('#font_step1').css('font-size', font_size);
	$('#font_step1').css('font-weight', font_weight);
	$('.step2').hide(); // 배송지 입력 숨기기
	$('.footer_step2').hide(); 
	$('.step3').hide(); // 최종 확인 부분 숨기기
	$('.footer_step3').hide(); 
	
	
	// 전체 상품 주문을 클릭하면
	$("#all_procedto").click(function(){
		// 첫번째 li 태그 css 효과 제거
		$('#font_step1').css('color', '');
		$('#font_step1').css('font-size', '');
		$('#font_step1').css('font-weight', '');
		
		// 두번째 li 태그 css 효과 적용
		$('#font_step2').css('color', font_color);
		$('#font_step2').css('font-size', font_size);
		$('#font_step2').css('font-weight', font_weight);
	    $('.step1').hide(); // 장바구니 부분 숨기기
		$('.footer_step1').hide(); // 장바구니 부분 숨기기

		$('.step2').show(); // 배송지 입력 보이기
		$('.footer_step2').show(); // 배송지 입력 보이기
		
	    $("#subject").text("배송 정보");
 	 });
	
	// 이전 단계를 클릭하면 [배송지 입력 부분]
	$(".prev").click(function(){
		// 첫번째 li 태그 css 효과 추가
		$('#font_step1').css('color', font_color);
		$('#font_step1').css('font-size', font_size);
		$('#font_step1').css('font-weight', font_weight);
		
		// 두번째 li 태그 css 효과 제거
		$('#font_step2').css('color', '');
		$('#font_step2').css('font-size', '');
		$('#font_step2').css('font-weight', '');
	    $('.step2').hide(); // 배송지 부분 숨기기
		$('.footer_step2').hide(); // 배송지 부분 숨기기

		$('.step1').show(); // 장바구니 부분 보이기
		$('.footer_step1').show(); // 장바구니 부분 보이기
		
	    $("#subject").text("장바구니");
	});
	
	// 다음 단계를 클릭하면 [최종 확인 부분]
	$(".next").click(function(){
		// 첫번째 li 태그 css 효과 추가
		$('#font_step1').css('color', font_color);
		$('#font_step1').css('font-size', font_size);
		$('#font_step1').css('font-weight', font_weight);
		
		// 두번째 li 태그 css 효과 제거
		$('#font_step2').css('color', '');
		$('#font_step2').css('font-size', '');
		$('#font_step2').css('font-weight', '');
	    $('.step2').hide(); // 배송지 부분 숨기기
		$('.footer_step2').hide(); // 배송지 부분 숨기기

		$('.step1').show(); // 장바구니 부분 보이기
		$('.footer_step1').show(); // 장바구니 부분 보이기
		
	    $("#subject").text("장바구니");
	});
	
});

/* ===============================
	우편번호 찾기
   ===============================
*/

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
			document.getElementById('zipcode').value = data.zonecode;
			document.getElementById('fakezipcode').value = data.zonecode;
			document.getElementById("address1").value = addr;
			document.getElementById("fakeaddress1").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("address2").focus();
		}
	}).open({
		left: (window.screen.width / 2) - (width / 2),
		top: (window.screen.height / 2) - (height / 2)
	});
}


