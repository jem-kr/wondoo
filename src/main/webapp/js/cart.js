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
	
	
	$('#all_procedto').click(function (){
		$('#font_step2').css('color', font_color);
		$('#font_step2').css('font-size', font_size);
		$('#font_step2').css('font-weight', font_weight);
		$('.step2').show(); // 전체 상품 주문 버튼을 클릭하면 배송지 입력 보이기 
		$('.step1').hide(); // 전체 상품 주문 버튼을 클릭하면 장바구니 부분 숨기기
	});
});

