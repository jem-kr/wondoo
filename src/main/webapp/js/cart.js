

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
	
	
	/* ===============================
		배송지 입력 유효성
   	===============================
	*/
	var adr02_reg = /^[a-z|A-Z|가-힣|0-9]+$/; // 상세주소 정규 표현식
	
	// 상세 주소
	$("#fake_orders_adr02").blur(function() {
		var fake_orders_adr02 = $('#fake_orders_adr02').val();
		
		if (fake_orders_adr02.length <= 0) {
			$("#err_address2").text('상세주소를 입력하세요!');
			$("#err_address2").css("color", font_color);
		} else if(fake_orders_adr02.length > 0){
			if(adr02_reg.test(fake_orders_adr02) == false){
				$("#err_address2").text('올바른 주소로 입력하세요!');
				$("#err_address2").css("color", font_color);
			}else{
				$("#err_address2").text('');
			}
		}

	});
	
	$("#orders_adr02").blur(function() {
		var orders_adr02 = $('#orders_adr02').val();
				
		if (orders_adr02.length <= 0) {
			$("#err_address2").text('상세주소를 입력하세요!');
			$("#err_address2").css("color", font_color);
		} else if(orders_adr02.length > 0){
			if(adr02_reg.test(orders_adr02) == false){
				$("#err_address2").text('올바른 주소로 입력하세요!');
				$("#err_address2").css("color", font_color);
			}else{
				$("#err_address2").text('');
			}
		}
	});
	
	var phone_reg = /^01([0|1|6|7|8|9?]-?([0-9]{3,4})-?([0-9]{4}))$/; // 휴대폰 번호 정규 표현식
	
	// 휴대폰 번호
	$("#fake_orders_phone").blur(function() {
		var fake_orders_phone = $('#fake_orders_phone').val();
		
		if (fake_orders_phone.length <= 0) {
			$("#err_phone").text('휴대폰 번호를 입력하세요!');
			$("#err_phone").css("color", font_color);
		} else if(fake_orders_phone.length > 0){
			if(phone_reg.test(fake_orders_phone) == false){
				$("#err_phone").text('올바른 휴대폰 번호로 입력하세요!');
				$("#err_phone").css("color", font_color);
			}else{
				$("#err_phone").text('');
			}
		}

	});
	
	$("#orders_phone").blur(function() {
		var orders_phone = $('#orders_phone').val();
				
		if (orders_phone.length <= 0) {
			$("#err_phone").text('휴대폰 번호를 입력하세요!');
			$("#err_phone").css("color", font_color);
		} else if(orders_phone.length > 0){
			if(phone_reg.test(orders_phone) == false){
				$("#err_phone").text('올바른 휴대폰 번호로 입력하세요!');
				$("#err_phone").css("color", font_color);
			}else{
				$("#err_phone").text('');
			}
		}
	});
	
	// 요청 사항
	$("#orders_request").blur(function() {
		var orders_request = $('#orders_request').val();
				
		if (orders_request.length > 100) {
			$("#err_request").text('100자 이상 입력 할 수 없습니다!');
			$("#err_request").css("color", font_color);
		} else{
			$("#err_request").text('');
		}
		
	});
});
/* ==================================
	장바구니에서 쇼핑계속하기 버튼을 눌렀을때 이동
   ==================================
*/
function cart_back(){ // 쇼핑 계속 하기 버튼을 누르면 이전 페이지로 이동
	window.history.back();
}

/* ===============================
	수량 부분 + , - 버튼
   ===============================
*/


function plusqty(count){
	var cart_seq = $('#cart_seq' + count).val(); // 장바구니 번호
	
	var orders_pro_no = $('#orders_pro_no' + count).val(); // 상품 번호
	
	var orders_qty = parseInt($('#orders_qty' + count).val()); // 회원이 장바구니에 담을 때 선택한 수량
	
	var new_qty = orders_qty + 1; // 회원이 변경한 수량
	
	var pro_price = parseInt($('#pro_price' + count).val()); // 단가
	
	var new_price = new_qty * pro_price; // 회원이 변경한 수량에 맞는 상품 하나의 금액
	
	var sum_price = parseInt($('#sum_price').text()); // 장바구니 상품 총 금액
	
	var new_sum_price = sum_price + pro_price; // + 버튼을 눌렀을 때 상품 총 금액
	
	// 배송비 기준 30,000원 미만 2500원 30,000원 이상 0원
	var delivery_price;
	
	if(new_sum_price >= 30000){ 
		delivery_price = 0;
	}else{
		delivery_price = 2500;
	}
	
	var total_amount = new_sum_price + delivery_price; // 총 상품 금액 + 배송비
	
	// + 수량 ajax 
	$.ajax({
		url: '/caUpdate.ca',
		type: 'get',
		dataType: "text",
		contentType: "application/json; charset=UTF-8",
		data: { 'cart_seq' : cart_seq , 'orders_pro_no': orders_pro_no ,'new_qty' : new_qty}, // 1. {code : code } code=code 형식 , 2. String 으로 받을 수 있음..  
		success: function(data) { 
			if(data == 'over'){ // 재고의 max 값을 초과했을 때 
				$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
				$('#err_modal-body').html('더 이상 상품을 담을 수 없습니다!');
				$('#err_myModal').modal();
			}else if(data == 'success'){
				$('#orders_qty' + count).val(new_qty);
				$('#cart_price' + count).text(new_price);
				$('#sum_price').text(new_sum_price);
				$('#delivery_price').text(delivery_price);
				$('#total_amount').text(total_amount);
				$('#orders_total_amount').val(total_amount);
			}else if(data == 'fail'){
				$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
				$('#err_modal-body').html('상품 수량 수정이 불가능 합니다!');
				$('#err_myModal').modal();
			}else if(data == 'login'){
				location.href = getContextPath() + "/custLog.cu";
			}
		}, error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		   }


	});
	
}

function minusqty(count){
	
	var cart_seq = $('#cart_seq' + count).val(); // 장바구니 번호
	
	var orders_pro_no = $('#orders_pro_no' + count).val(); // 상품 번호
	
	var orders_qty = parseInt($('#orders_qty' + count).val()); // 회원이 장바구니에 담을 때 선택한 수량
	
	var new_qty = orders_qty - 1; // 회원이 변경한 수량
	
	var pro_price = parseInt($('#pro_price' + count).val()); // 단가
	
	var new_price = new_qty * pro_price; // 회원이 변경한 수량에 맞는 상품 하나의 금액
	
	var sum_price = parseInt($('#sum_price').text()); // 장바구니 상품 총 금액
	
	var new_sum_price = sum_price - pro_price; // + 버튼을 눌렀을 때 상품 총 금액
	
	// 배송비 기준 30,000원 미만 2500원 30,000원 이상 0원
	var delivery_price;
	
	if(new_sum_price >= 30000){ 
		delivery_price = 0;
	}else{
		delivery_price = 2500;
	}
	
	var total_amount = new_sum_price + delivery_price; // 총 상품 금액 + 배송비
	
	// + 수량 ajax 
	$.ajax({
		url: '/caUpdate.ca',
		type: 'get',
		dataType: "text",
		contentType: "application/json; charset=UTF-8",
		data: { 'cart_seq' : cart_seq , 'orders_pro_no': orders_pro_no ,'new_qty' : new_qty}, // 1. {code : code } code=code 형식 , 2. String 으로 받을 수 있음..  
		success: function(data) { 
			if(data == 'over'){ // 재고의 max 값을 초과했을 때 
				$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
				$('#err_modal-body').html('더 이상 상품을 담을 수 없습니다!');
				$('#err_myModal').modal();
			}else if(data == 'zero'){
				$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
				$('#err_modal-body').html('수량은 1개 이상이어야 합니다!');
				$('#err_myModal').modal();
			}else if(data == 'success'){
				$('#orders_qty' + count).val(new_qty);
				$('#cart_price' + count).text(new_price);
				$('#sum_price').text(new_sum_price);
				$('#delivery_price').text(delivery_price);
				$('#total_amount').text(total_amount);
				$('#orders_total_amount').val(total_amount);
			}else if(data == 'fail'){
				$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
				$('#err_modal-body').html('상품 수량 수정이 불가능 합니다!');
				$('#err_myModal').modal();
			}
		}, error:function(request,status,error){
		    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		   }


	});
}


/* ===============================
	장바구니 삭제
   ===============================
*/
function getContextPath() {
	var offset = location.href.indexOf(location.host) + location.host.length;
	var ctxPath = location.href.substring(offset, location.href.indexOf('/', offset + 1));
	return ctxPath;
}

function click_count(count){
	$('#myModal').modal();
	$('#count').val(count);
}


function del_check(count) {
	var count = $('#count').val();
	
	var cart_seq = $('#cart_seq' + count).val();
	location.href = getContextPath() + "/caDelete.ca?cart_seq=" + cart_seq;
}


/* ===============================
	step2. 배송지 입력 
   ===============================
*/

// 기본 배송지 → disabled
// 기본 배송지 변경 → disabled 해제
// 신규 배송지 → 배송지 주소 부분 reset


function delivery_restore(){
	$('button#zipcodebtn').attr('disabled', 'disabled');
	$('input#fake_orders_adr02').attr('disabled', 'disabled');
	$('input#fake_orders_phone').attr('disabled', 'disabled');
}


function delivery_change(){
	$('button#zipcodebtn').removeAttr('disabled');
	$('[data-toggle="tooltip"]').tooltip(); 
	
	$('input#fake_orders_adr02').removeAttr('disabled');
	$('input#fake_orders_phone').removeAttr('disabled');
}

// 가짜 input 태그에 입력 시 진짜 input 태그에 똑같은 값 셋팅
function input_adr2(){
	var x = document.getElementById("fake_orders_adr02").value;
    $('#orders_adr02').val(x);
}

function input_phone(){
	var x = document.getElementById("fake_orders_phone").value;
    $('#orders_phone').val(x);
}

/* ===============================
	우편번호 찾기
   ===============================
*/
// 회원 정보에 배송지가 등록 O
function zipCheck1() {
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
		}
	}).open({
		left: (window.screen.width / 2) - (width / 2),
		top: (window.screen.height / 2) - (height / 2)
	});
}


// 회원 정보에 배송지가 등록 X
function zipCheck2() {
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
			document.getElementById("orders_adr02").focus();
		}
	}).open({
		left: (window.screen.width / 2) - (width / 2),
		top: (window.screen.height / 2) - (height / 2)
	});
}


/*=======================================
   최종 결제 전 유효성 체크
=========================================*/

function pay_check(){
	// 우편 번호
	var fake_orders_zipcode = $('#fake_orders_zipcode').val();
	var orders_zipcode = $('#orders_zipcode').val();
	
	// 주소
	var fake_orders_adr01 = $('#fake_orders_adr01').val();
	var orders_adr01 = $('#orders_adr01').val();
	
	// 상세 주소
	var fake_orders_adr02 = $('#fake_orders_adr02').val();
	var orders_adr02 = $('#orders_adr02').val();
	
	// 휴대폰 번호
	var fake_orders_phone = $('#fake_orders_phone').val();
	var orders_phone = $('#orders_phone').val();
	
	// 유효성 에러 부분
	var valid_check = $('.valid_check').text();
	
		
	// 우편 주소를 입력하지 않은 경우
	if(fake_orders_zipcode == '' || 
	   orders_zipcode == '' ||
	   fake_orders_adr01 == '' ||
	   orders_adr01 == ''){
		$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#err_modal-body').html('우편번호 찾기 버튼을 클릭하여 <br>주소를 입력하세요!');
		$('#err_myModal').modal();
		
		return false;
	
	// 사용자가 직접 입력하는 부분
	}else if(
		fake_orders_adr02 == '' ||
		orders_adr02 == '' ||
		fake_orders_phone == '' ||
		orders_phone == ''){
	
		$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#err_modal-body').html('입력한 값을 확인하세요!');
		$('#err_myModal').modal();
	
		return false;

	}else if (valid_check != '') {// 유효성 에러가 담기는 <p> 태그에 값이 들어 있어도 modal 팝업 기능 추가 
		$('#err_modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#err_modal-body').html('입력한 값을 확인하세요!');
		$('#err_myModal').modal();
		
		return false;
		
	} else{
		payment(); // 지은 - payment() 호출은 했으나 정상 처리 되는지 확인 필요
		return true;
	}
}


/*=======================================
   상품 실 결제 처리 => 아임포트 API
=========================================*/

function payment() {
   // 결제 테이블에 넣을 파라미터
   var orders_pro_no = $('#orders_pro_no').val(); // 주문 클래스
   var orders_cust_email = $('#orders_cust_email').val(); // 회원 이메일
   var orders_realtime = $('#orders_realtime').val(); // 결제 일자
   var orders_zipcode = $('#orders_zipcode').val(); // 우편 번호
   var orders_qty = $('#orders_qty').val(); // 구매 수량
   var orders_adr01 = $('#orders_adr01').val(); // 우편 번호
   var orders_adr02 = $('#orders_adr02').val(); // 주소
   var orders_phone = $('#orders_phone').val(); // 상세 주소
   var orders_request = $('#orders_request').val(); // 요청사항
   var orders_total_amount = $('#orders_total_amount').val(); // 결제 총 가격
   
   orders_total_amount = removecomma(orders_total_amount); // 페이징 로딩 될때 설정했던 콤마 제거

   function removecomma(pStr) {
      var strCheck = /\,/g;
      pStr = pStr.replace(strCheck, '');
      return pStr;
   }
   
   // API 용 파라미터 
   var cust_name = $('#cust_name').val(); // 회원 이름
   
   IMP.init('imp63433419'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
   IMP.request_pay({
       pg : 'inicis', // version 1.1.0부터 지원.
       pay_method : 'card',
       merchant_uid : 'merchant_' + new Date().getTime(),
       name : '주문명: ' + orders_pro_no + " | 결제 테스트",
       amount : orders_total_amount, // 결제 금액
       buyer_email : orders_cust_email,// 결제자 이메일
       buyer_name : cust_name, // 결제자 이름
       buyer_tel : orders_phone// 결제자 휴대폰 번호
   }, function(rsp) {
       if ( rsp.success ) {
       //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
            
       jQuery.ajax({
          url: "/prOrderPayment.po", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
          type: 'get',
          dataType: 'json',
         contentType: "application/json; charset=UTF-8",
          data: {
             imp_uid : rsp.imp_uid,
            merchant_uid : rsp.merchant_uid,
            
             //기타 필요한 데이터가 있으면 추가 전달
            orders_cust_email : orders_cust_email,
            orders_phone : orders_phone,
            orders_zipcode : orders_zipcode,
            orders_adr01 : orders_adr01,
            orders_adr02 : orders_adr02,
            orders_request : orders_request,
            orders_total_amount : orders_total_amount
          },
         success : function(data){
         console.log(data)
             var msg = '결제가 완료되었습니다.';
             msg += '\n고유ID : ' + rsp.imp_uid;
             msg += '\n상점 거래ID : ' + rsp.merchant_uid;
             msg += '\결제 금액 : ' + rsp.paid_amount;
             msg += '카드 승인번호 : ' + rsp.apply_num;

             alert(msg);
         }
       });
        
    } else{
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;

        alert(msg);
      
      }
        window.location.replace("/prList.pr");
   });
}
