function getContextPath(){
    var offset=location.href.indexOf(location.host)+location.host.length;
    var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
    return ctxPath;
};


function del_check(){
	var products_seq=$('#products_seq').val();
	if(confirm("상품을 삭제하시겠습니까?")){
		location.href = getContextPath()+"/prDelete.pr?products_seq="+products_seq;
	} else{
		return false;	
	}

};




/* =========================
	상품 상세 및 결제[시작]
   =========================
*/


$(document).ready(function() {
	// 가격 콤마 찍기
	var pro_price = $('#pro_price').val();
	pro_price = addcomma(pro_price);
	// 가짜 결제 가격 콤마 찍기
	var fake_totalprice = $('#fake_totalprice').val();
	fake_totalprice = addcomma(fake_totalprice);

	// 진짜 결제 가격 콤마 찍기
	var totalprice = $('#totalprice').val();
	totalprice = addcomma(totalprice);

	function addcomma(str) {
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}

	// 최종 가격 문장
	var result_pro_price = pro_price;
	var result_fake_totalprice = fake_totalprice;
	var result_totalprice = totalprice;
	$('#pro_price').val(result_pro_price);
	$('#fake_totalprice').val(result_fake_totalprice);
	$('#totalprice').val(result_totalprice);


	/* ===============================  
		버튼 클릭 시 수량, 가격 변동 
	 ==================================*/


	// + 버튼을 누르면 수량 증가 , 결제 금액 증가
	$('#plusbtn').click(function() {
		// 사업자가 설정한 최대 인원수
		var _pro_stock = $('#pro_stock').val();
		var pro_stock = parseInt(_pro_stock);

		// 사용자가 선택하는 수량
		var _qty = $('#fake_qty').val();
		var qty = parseInt(_qty);

		// 사업자가 설정한 개 당 가격 
		var pro_price = $('#pro_price').val();

		pro_price = removecomma(pro_price); // 페이징 로딩 될때 설정했던 콤마 제거

		function removecomma(pStr) {
			var strCheck = /\,/g;
			pStr = pStr.replace(strCheck, '');
			return pStr;
		}

		var qty_result; // 사용자가 선택한 총 수량
		var totalprice; // 사용자가 선택한 총 가격
		var fake_totalprice; // 사용자가 선택한 총 가격

		if (qty < pro_stock) {// 사용자가 선택하는 수량이 사업자가 설정한 재고수량 미만이면 + 1 처리 
			// 인원수 증가
			qty_result = qty + 1;

			// 파라미터로 넘어갈 총 금액
			totalprice = pro_price * qty_result; // 실제 DB로 넘어갈 결제 총 금액
			totalprice = addcomma(totalprice);

			// 사용자에게 보여줄 가짜 총 금액
			fake_totalprice = pro_price * qty_result; // 가짜 총 금액(사용자에게 보여줄 용도)
			fake_totalprice = addcomma(fake_totalprice);

			$('button#plusbtn').removeAttr('data-toggle', 'modal');
		} else {//사용자가 선택하는 수량이 사업자가 설정한 재고 초과이면 + 0 처리 
			qty_result = qty;

			// 파라미터로 넘어갈 총 금액
			totalprice = pro_price * qty_result; // 실제 DB로 넘어갈 결제 총 금액
			totalprice = addcomma(totalprice);

			// 사용자에게 보여줄 가짜 총 금액
			fake_totalprice = pro_price * qty_result; // 가짜 총 금액(사용자에게 보여줄 용도)
			fake_totalprice = addcomma(fake_totalprice);


			$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
			$('#modal-body').text('재고가 부족합니다!');
			$('#myModal').modal();

		}

		$('#fake_qty').val(qty_result);
		$('#qty').val(qty_result);
		$('#totalprice').val(totalprice);
		$('#fake_totalprice').val(fake_totalprice);
	});

	// - 버튼을 누르면 수량 감소 , 결제 금액 감소
	$('#minusbtn').click(function() {
		var _qty = $('#fake_qty').val();
		var qty = parseInt(_qty);
		var qty_result;

		// 사업자가 설정한 개당 가격 
		var pro_price = $('#pro_price').val();

		pro_price = removecomma(pro_price); // 페이징 로딩 될때 설정했던 콤마 제거

		function removecomma(pStr) {
			var strCheck = /\,/g;
			pStr = pStr.replace(strCheck, '');
			return pStr;
		}

		var totalprice; // 사용자가 선택한 총 가격
		var fake_totalprice; // 사용자가 선택한 총 가격

		if (qty >= 2) { // 최소값은 1로 남겨놔야함

			qty_result = qty - 1;


			totalprice = qty_result * pro_price;
			totalprice = addcomma(totalprice);

			fake_totalprice = qty_result * pro_price;
			fake_totalprice = addcomma(fake_totalprice);
		} else {
			qty_result = 1


			totalprice = qty_result * pro_price;
			totalprice = addcomma(totalprice);

			fake_totalprice = qty_result * pro_price;
			fake_totalprice = addcomma(fake_totalprice);
		}
		$('#fake_qty').val(qty_result);
		$('#qty').val(qty_result);

		$('#totalprice').val(totalprice);
		$('#fake_totalprice').val(fake_totalprice);
	});
});





