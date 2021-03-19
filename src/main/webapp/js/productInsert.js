/* ===================================
	상품 등록 및 수정[시작] 
   ====================================
*/

/* ===================
	상단 step process bar
   ===================
*/

$(document).ready(function() {
	//Initialize tooltips
	$('.nav-tabs > li a[title]').tooltip();

	//Wizard
	$('a[data-toggle="tab"]').on('show.bs.tab', function(e) {

		var $target = $(e.target);

		if ($target.parent().hasClass('disabled')) {
			return false;
		}
	});

	$(".next-step").click(function(e) {

		var $active = $('.wizard .nav-tabs li.active');
		$active.next().removeClass('disabled');
		nextTab($active);

	});
	$(".prev-step").click(function(e) {

		var $active = $('.wizard .nav-tabs li.active');
		prevTab($active);

	});
});

/* ===============================
	페이지가 로딩되었을 때 실행되는 함수
   ===============================
*/


function setprice() {
	/* ===============================  
		상품 수정
	 ==================================*/
	// 사업자가 설정한 가격 
	var pro_price = $('#pro_price').val();

	pro_price = removecomma(pro_price); // 페이징 로딩 될때 설정했던 콤마 제거

	function removecomma(pStr) {
		var strCheck = /\,/g;
		pStr = pStr.replace(strCheck, '');
		return pStr;
	}

	$('#pro_price').val(pro_price);

};






/* ===============================
	 유효성 검사
   ===============================
*/

var font_color = '#5080BF';
var number_check = /^[0-9]*$/; // 숫자만 가능
var string_check = /^[ㄱ-ㅎㅏ-ㅣ가-힣]$/; // 자음 , 모음으로 들어왔을 경우

/*=====================
	유효성 검사 - STEP1
=======================*/

$(document).ready(function() {
	// 대분류
	$("#pro_category").click(function() {
		var pro_category = $('#pro_category option:selected').val();

			if (pro_category == '-') {
				$('#code').val('');
				$("#err_pro_category").text('대분류를 선택하세요!');
				$("#err_pro_category").css("color", font_color);
			} else {
				$("#err_pro_category").text('');
			}
	});

	
	
	// 주제
	$("#pro_type").click(function() {
		var pro_type = $('#pro_type option:selected').val();

			if (pro_type == '-') {
				$('#code').val('');
				$("#err_pro_type").text('소분류를 선택하세요!');
				$("#err_pro_type").css("color", font_color);
			} else {
				$("#err_pro_type").text('');
			}
	});



	// 상품명
	$("#pro_name").keyup(function() {
		if ($(this).val().length < 4) {
			$("#err_pro_name").text('4글자 이상 입력하세요!');
			$("#err_pro_name").css("color", font_color);
		} else {
			$("#err_pro_name").text('');
		}

	});


	$("#pro_name").blur(function() {
		var pro_name = $('#pro_name').val();

		if (pro_name.length == 0) {
			$("#err_pro_name").text('상품명을 입력하세요!');
			$("#err_pro_name").css("color", font_color);
		} else if (pro_name.length < 4) {
			$("#err_pro_name").text('4글자 이상 입력하세요!');
			$("#err_pro_name").css("color", font_color);
		} else {
			$("#err_pro_name").text('');
		}


	});

	// 원산지
	$("#pro_origin").keyup(function() {
		if ($(this).val().length < 2) {
			$("#err_pro_origin").text('2글자 이상 입력하세요!');
			$("#err_pro_origin").css("color", font_color);
		} else {
			$("#err_pro_origin").text('');
		}

	});


	$("#pro_origin").blur(function() {
		var pro_origin = $('#pro_origin').val();

		if (pro_origin.length == 0) {
			$("#err_pro_origin").text('원산지를 입력하세요!');
			$("#err_pro_origin").css("color", font_color);
		} else if (pro_origin.length < 2) {
			$("#err_pro_origin").text('2글자 이상 입력하세요!');
			$("#err_pro_origin").css("color", font_color);
		} else {
			$("#err_pro_origin").text('');
		}


	});

	// 재고	
	$("#pro_stock").blur(function() {
		var pro_stock = $('#pro_stock').val();


		if (pro_stock.length >= 2) {
			if (pro_stock.charAt(0) == '0') {
				$("#err_pro_stock").text('재고 수량을 확인해주세요!');
				$("#err_pro_stock").css("color", font_color);
			} else {
				$("#err_pro_stock").text('');
			}
		} else if (pro_stock.length == 1) {
			if (pro_stock.charAt(0) == '0') {
				$("#err_pro_stock").text('1개 이상만 입력 가능합니다!');
				$("#err_pro_stock").css("color", font_color);
			} else {
				$("#err_pro_stock").text('');
			}
		} else if (pro_stock.length == 0) {
			$("#err_pro_stock").text('충분한 재고 수량을 입력하세요!');
			$("#err_pro_stock").css("color", font_color);
		} else {
			$("#err_person").text('');
		}

		if (!number_check.test($(this).val())) {
			$("#err_pro_stock").text('숫자만 입력하세요!');
			$("#err_pro_stock").css("color", font_color);
		}

	});

	// 가격	
	$("#pro_price").keyup(function() {
		if ($(this).val().length < 4) {
			$("#err_pro_price").text('1000원 단위부터 입력 가능합니다!');
			$("#err_pro_price").css("color", font_color);
		} else {
			$("#err_pro_price").text('');
		}

		if (!number_check.test($(this).val())) {
			$("#err_pro_price").text('숫자만 입력하세요!');
			$("#err_pro_price").css("color", font_color);
		}

	});


	$("#pro_price").blur(function() {
		var pro_price = $('#pro_price').val();

		if (pro_price.length < 4) {
			$("#err_pro_price").text('1000원 단위부터 입력 가능합니다!');
			$("#err_pro_price").css("color", font_color);

			if (pro_price.charAt(0) == '0') {
				$("#err_pro_price").text('가격을 확인해주세요!');
				$("#err_pro_price").css("color", font_color);
			}
			if (pro_price.length == 0) {
				$("#err_pro_price").text('가격을 입력하세요!');
				$("#err_pro_price").css("color", font_color);
			}
		} else if (pro_price.length >= 4) {
			if (pro_price.charAt(0) == '0') {
				$("#err_pro_price").text('가격을 확인해주세요!');
				$("#err_pro_price").css("color", font_color);
			}
		} else {
			$("#err_pro_price").text('');
		}


		if (!number_check.test($(this).val())) {
			$("#err_pro_price").text('숫자만 입력하세요!');
			$("#err_pro_price").css("color", font_color);
		}

	});


	// 상품 설명
	$("#pro_detail").keyup(function() {
		if ($(this).val().length > 0) {
			$("#err_pro_detail").text('해당 내용은 상품 설명에 기재됩니다.');
			$("#err_pro_detail").css("color", font_color);
		} else {
			$("#err_pro_detail").text('');
		}

	});

	$("#pro_detail").blur(function() {
		var pro_detail = $('#pro_detail').val();

		if (pro_detail.length > 0) {
			$("#err_pro_detail").text('');
		}
	});



});


/*=======================================
		다음 단계 및 최종 등록 버튼을 눌렀을 때
	======================================*/

//STEP 1 단계 다음 부분
function next_check1() {
	var valid_check = $('.valid_check').text();

	var pro_category = $('#pro_category option:selected').val();
	var pro_type = $('#pro_type option:selected').val();
	var pro_name = $('#pro_name').val();
	var pro_stock = $('#pro_stock').val();
	var pro_price = $('#pro_price').val();
	var pro_detail = $('#pro_detail').val();

	// step1 단계에서 필수 입력 항목이 null 이면 modal 팝업 처리 
	if (pro_category == '-' || pro_type == '-' || pro_name == '' || pro_origin ==''|| pro_stock == '' || pro_price == '' ||
		pro_detail == '' ) {
		$('#isCheck').val('false');
		$('button#modalbtn1').attr('data-toggle', 'modal');
		$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#modal-body').text('입력한 값을 확인하세요!');

	} else if (valid_check != '') {// 유효성 에러가 담기는 <span> 태그에 값이 들어 있어도 modal 팝업 기능 추가 
		$('#isCheck').val('false');
		$('button#modalbtn1').attr('data-toggle', 'modal');
		$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#modal-body').text('입력한 값을 확인하세요!');
	} else {
		$('#isCheck').val('true');
		$('button#modalbtn1').removeAttr('data-toggle');
		var result = nextTab(elem);
		return result;
	}
}


function nextTab(elem) {
	var isCheck = $('#isCheck').val();
	if (isCheck == 'true') {
		$(elem).next().find('a[data-toggle="tab"]').click();
	} else {
		$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#modal-body').text('입력한 값을 확인하세요!');
	}
}

function prevTab(elem) {
	$(elem).prev().find('a[data-toggle="tab"]').click();
}


/*================================
	유효성 검사 - STEP2 / 사진 및 최종 등록 단계
  ================================*/
function submitCheck() {

	// 사진이 등록되지 않았을때 , 
	var main_image = $('#p_img').val();
	if (main_image == '') {
		$('#isCheck').val('false');
		$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#modal-body').html('상품 사진을 등록하세요!');
		$('#myModal').modal();

		return false;
	} else {
		$('button#modalbtn2').removeAttr('data-toggle');

		return true;
	}


}

function updateCheck() {

	// 기존 사진을 이용할 때 등록되지 않았을때 , 
	var main_image = $('#p_img').val();
	var oldimg = $('#oldimg').val();
	if (main_image == '') {
		main_image = oldimg;
	} 

}


/* ===================
	메인 파일 업로드
   ===================
*/

function readURL_main(input) {
	if (input.files && input.files[0]) {

		var reader = new FileReader();

		reader.onload = function(e) {
			$('#main_wrap').hide();

			$('#p_image').attr('src', e.target.result);
			$('#main_content').show();

			$('#main_title').html(input.files[0].name);
		};

		reader.readAsDataURL(input.files[0]);

	} else {
		removeUpload();
	}
}

function removeUpload_main() {
	$('#p_image').replaceWith($('#p_image').clone());
	$('#p_img').val('');
	$('#main_content').hide();
	$('#main_wrap').show();
}
$('#main_wrap').bind('dragover', function() {
	$('#main_wrap').addClass('image-dropping');
});
$('#main_wrap').bind('dragleave', function() {
	$('#main_wrap').removeClass('image-dropping');
});


/* ===================
	상품 등록[끝]
   ===================
*/
