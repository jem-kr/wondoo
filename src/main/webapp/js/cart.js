

/* ===============================
	장바구니 삭제
   ===============================
*/
function getContextPath() {
	var offset = location.href.indexOf(location.host) + location.host.length;
	var ctxPath = location.href.substring(offset, location.href.indexOf('/', offset + 1));
	return ctxPath;
}

function del_check() {
	var cart_seq = $('#cart_seq').val();
	//alert(cart_seq);
	location.href = getContextPath() + "/caDelete.ca?cart_seq=" + cart_seq;
}

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
	$("#all_procedto").click(function() {
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
	$(".prev").click(function() {
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
	$(".next").click(function() {
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


	// 배송지 입력 부분 
	// 기존 회원의 주소값이 있는 경우 기본 배송지로 셋팅 
	// 기존 회원의 주소값이 없는 경우 직접 입력으로 셋팅 

});


/* ===============================
	수량 부분 + , - 버튼
   ===============================
*/


function plusqty(){
	var pro_stock = parseInt($("#pro_stock").val()); // 사업자가 설정한 최대 상품수
	
	var pro_price = parseInt($("#pro_price").val()); // 제품 단가
	
	var orders_qty = parseInt($('#orders_qty').val()); // 사용자가 지정한 상품수
	
	if(orders_qty >= pro_stock) { // 재고를 초과한 경우
		$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#err_modal-body').html('더 이상 상품을 담을 수 없습니다!');
		$('#err_myModal').modal();
		
		orders_qty += 0;
		
		$('#orders_qty').val(orders_qty);
		$('#cart_price').text(orders_qty * pro_price);
		$('#orders_amount').val(orders_qty * pro_price);
	}else{ // 재고를 초과하지 않은 경우
		orders_qty += 1;
	
		$('#orders_qty').val(orders_qty);
		$('#cart_price').text(orders_qty * pro_price);
		$('#orders_amount').val(orders_qty * pro_price);
	}
	
	return false;
}

function minusqty(){
	
	var pro_price = parseInt($("#pro_price").val()); // 제품 단가
	
	var orders_qty = parseInt($('#orders_qty').val()); // 사용자가 지정한 상품수
	

	if(orders_qty <= 1) { // 사용자가 지정한 재고가 1인 경우
		orders_qty -= 0;
		
		$('#orders_qty').val(orders_qty);
		$('#cart_price').text(orders_qty * pro_price);
		$('#orders_amount').val(orders_qty * pro_price);
		
		$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#err_modal-body').html('수량은 1개 이상이어야 합니다!');
		$('#err_myModal').modal();
	}else{ // 사용자가 지정한 재고가 1보다 큰 경우 
		orders_qty -= 1;
	
		$('#orders_qty').val(orders_qty);
		$('#cart_price').text(orders_qty * pro_price);
		$('#orders_amount').val(orders_qty * pro_price);
	}
	
	return false;
}

/* ===============================
	수량을 직접 입력하는 경우 조건 체크
   ===============================
*/
function qty_check() {
	// 조건 1. 수량은 1이상 입력되어야함
	var pro_stock = parseInt($("#pro_stock").val()); // 사업자가 설정한 최대 상품수
	var pro_price = parseInt($("#pro_price").val()); // 제품 단가
	var cart_cust_qty = parseInt($('#cart_cust_qty').val()); // 사용자가 지정한 상품수
	
	if(cart_cust_qty < 1){
		$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#err_modal-body').html('수량은 1개 이상이어야 합니다!');
		$('#err_myModal').modal();
		
		$('#cart_cust_qty').val(1);
		$('#cart_total_price').text(pro_price);
	}
	
	// 조건 2. 사업자가 지정한 초기 제품수보다 작거나 같아야함
	if(cart_cust_qty > pro_stock){
		$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#err_modal-body').html('재고가 부족합니다!');
		$('#err_myModal').modal();
		
		$('#cart_cust_qty').val(pro_stock);
		$('#cart_total_price').text(pro_stock * pro_price);
	}
	
}


/* ===============================
	step2. 배송지 입력 
   ===============================
*/

// 기본 배송지 → disabled
// 기본 배송지 변경 → disabled 해제
// 신규 배송지 → 배송지 주소 부분 reset

// 기본 배송지
function delivery_restore() {
	$("input:not(.delivery input)").attr("disabled", "disabled");
	$("button#zipcodebtn").attr("disabled", "disabled");
}


// 기본 배송지 변경
function delivery_change() {
	$("input").removeAttr("disabled");
	$("button#zipcodebtn").removeAttr("disabled");
}

// 신규 배송지
function delivery_new() {
	$("input.new_data").attr("value", "");
	$("input.new_data").removeAttr("disabled");
	$("button#zipcodebtn").removeAttr("disabled");
}


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
			document.getElementById('orders_zipcode').value = data.zonecode;
			document.getElementById('fake_orders_zipcode').value = data.zonecode;
			document.getElementById("orders_adr01").value = addr;
			document.getElementById("fake_orders_adr01").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("fake_orders_adr02").focus();
			document.getElementById("orders_adr02").focus();
		}
	}).open({
		left: (window.screen.width / 2) - (width / 2),
		top: (window.screen.height / 2) - (height / 2)
	});
}


/* ===============================
	배송지 입력 유효성
   ===============================
*/

