/* ===================================
	원데이 클래스 등록 및 수정[시작] 
   ====================================
*/

/* ===================
	상단 step process bar
   ===================
*/

$(document).ready(function() {
	$('[data-toggle="tooltip"]').tooltip();
	
	
	// 당일 날짜를 구해서 startdate 파라미터 값으로 넣어줌 
	var today = new Date();
	var year = today.getFullYear(); //년도 
	var _month = today.getMonth() + 1;
	var _date = today.getDate();
	var month; // 월 
	var date; // 날짜 

	if (_month < 10) { // 1의 자리 일때 
		month = "0" + _month;
	} else {
		month = _month;
	}

	if (_date < 10) { // 1의 자리 일때 
		date = "0" + _date;
	} else {
		date = _date;
	}

	var startdate = String(year) + String(month) + String(date);
	//alert(startdate);
	$('#fake-startdate').val(startdate);
	$('#startdate').val(startdate);



	// 로드 되었을 때 , 시간 추가 부분은 안보이게함
	$('#add1').hide(); // 추가시간
	
});


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


function today() {
	/* ===============================  
		원데이 클래스 수정
	 ==================================*/
	// 사업자가 설정한 1인 기준 가격 
	var oneprice = $('#oneprice').val();

	oneprice = removecomma(oneprice); // 페이징 로딩 될때 설정했던 콤마 제거

	function removecomma(pStr) {
		var strCheck = /\,/g;
		pStr = pStr.replace(strCheck, '');
		return pStr;
	}

	$('#oneprice').val(oneprice);

	

}



/* ===============================
	코드 중복 검사 ajax 활용
   ===============================
*/

function code_ajax() {
	
	// 유효성 검사
	var code = $('#code').val();
	var font_color = '#5080BF';

	if (code.length == 0) {
		$("#err_code").text('클래스 코드를 입력하세요!');
		$("#err_code").css("color", font_color);
	}  else {
		$("#err_code").text('');
	}

	//alert(code);

	// 중복 ajax 
	$.ajax({
		url: '/onedayCodeCheck.odc',
		type: 'post',
		dataType: "json",
		contentType: "application/json; charset=UTF-8",
		data: code, // 1. {code : code } code=code 형식 , 2. String 으로 받을 수 있음..  
		success: function(data) { // OnedayClassCodeCheckController 컨트롤러 cnt 값
			console.log("1 = 중복o / 0 = 중복x : "+ data);         
			if (data == '1') {
				$('#err_code').text('이미 존재하는 클래스 코드입니다. 다른 코드로 지정하세요!' );
				$('#err_code').css('color', font_color);
			}else {
				if (code.length > 0) {
					if (code.indexOf('coffee_') == 0 || code.indexOf('pottery_') == 0) {
						if(code == 'coffee_' || code=='pottery_'){
							$("#err_code").text('기본 설정 값 다음부터 입력이 가능합니다!');
							$('#err_code').css('color', font_color);
						}else{
							$("#err_code").text('');
						}
					} else {
						$("#err_code").text('기본 설정 값 다음부터 입력이 가능합니다! 주제를 다시 선택하세요.');
					}
				}
			}
		}, error: function() {
			console.log("통신 실패-값이 안넘어감");   
		}

	});
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
	// 주제
	$("#type").click(function() {
		var type = $('#type option:selected').val();

		if (type == 'coffee') {
			$('#code').val(type + '_');
			$("#err_type").text('');
		} else if (type == 'pottery') {
			$('#code').val(type + '_');
			$("#err_type").text('');
		} else {
			if (type == '-') {
				$('#code').val('');
				$("#err_type").text('주제를 선택하세요!');
				$("#err_type").css("color", font_color);
			} else {
				$("#err_type").text('');
			}
		}
	});


	// 클래스 코드 
	// 상단 code_ajax() 함수에서 유효성 검사 진행

	$("#code").keyup(function() {
		var code = $('#code').val();
		if (code.length > 0) {
			$("#err_code").text('반드시 클래스 코드를 기억해주세요! 코드는 중복 불가합니다.');
			$("#err_code").css("color", font_color);
		}

	});


	// 클래스명
	$("#classname").keyup(function() {
		if ($(this).val().length < 4) {
			$("#err_classname").text('4글자 이상 입력하세요!');
			$("#err_classname").css("color", font_color);
		} else {
			$("#err_classname").text('');
		}

	});


	$("#classname").blur(function() {
		var classname = $('#classname').val();

		if (classname.length == 0) {
			$("#err_classname").text('클래스 명을 입력하세요!');
			$("#err_classname").css("color", font_color);
		} else if (classname.length < 4) {
			$("#err_classname").text('4글자 이상 입력하세요!');
			$("#err_classname").css("color", font_color);
		} else {
			$("#err_classname").text('');
		}


	});



	// 수강 인원	
	$("#person").blur(function() {
		var person = $('#person').val();


		if (person.length >= 2) {
			if (person.charAt(0) == '0') {
				$("#err_person").text('인원수를 확인해주세요!');
				$("#err_person").css("color", font_color);
			} else {
				$("#err_person").text('');
			}
		} else if (person.length == 1) {
			if (person.charAt(0) == '0') {
				$("#err_person").text('1명 이상만 입력 가능합니다!');
				$("#err_person").css("color", font_color);
			} else {
				$("#err_person").text('');
			}
		} else if (person.length == 0) {
			$("#err_person").text('수업에 참여 가능한 최대 인원수를 입력하세요!');
			$("#err_person").css("color", font_color);
		} else {
			$("#err_person").text('');
		}

		if (!number_check.test(person)) {
			$("#err_person").text('숫자만 입력하세요!');
			$("#err_person").css("color", font_color);
		}

	});

	// 가격	
	$("#oneprice").keyup(function() {
		if ($(this).val().length < 4) {
			$("#err_oneprice").text('1000원 단위부터 입력 가능합니다!');
			$("#err_oneprice").css("color", font_color);
		} else {
			$("#err_oneprice").text('');
		}

		if (!number_check.test($(this).val())) {
			$("#err_oneprice").text('숫자만 입력하세요!');
			$("#err_oneprice").css("color", font_color);
		}

	});


	$("#oneprice").blur(function() {
		var oneprice = $('#oneprice').val();

		if (oneprice.length < 4) {
			$("#err_oneprice").text('1000원 단위부터 입력 가능합니다!');
			$("#err_oneprice").css("color", font_color);

			if (oneprice.charAt(0) == '0') {
				$("#err_oneprice").text('가격을 확인해주세요!');
				$("#err_oneprice").css("color", font_color);
			}
			if (oneprice.length == 0) {
				$("#err_oneprice").text('1인 기준 가격을 입력하세요!');
				$("#err_oneprice").css("color", font_color);
			}
		} else if (oneprice.length >= 4) {
			if (oneprice.charAt(0) == '0') {
				$("#err_oneprice").text('가격을 확인해주세요!');
				$("#err_oneprice").css("color", font_color);
			}
		} else {
			$("#err_oneprice").text('');
		}


		if (!number_check.test($(this).val())) {
			$("#err_oneprice").text('숫자만 입력하세요!');
			$("#err_oneprice").css("color", font_color);
		}

	});

	// 상세 주소
	$("#address2").blur(function() {
		var address2 = $('#address2').val();

		if (address2.length == 0) {
			$("#err_address2").text('상세 주소를 입력하세요!');
			$("#err_address2").css("color", font_color);
		} else {
			$("#err_address2").text('');
		}


	});

	// 상품 설명
	$("#content").keyup(function() {
		if ($(this).val().length > 0) {
			$("#err_content").text('해당 내용은 원데이 클래스 세부 목록에 기재됩니다.');
			$("#err_content").css("color", font_color);
		} else {
			$("#err_content").text('');
		}

	});

	$("#content").blur(function() {
		var content = $('#content').val();

		if (content.length > 0) {
			$("#err_content").text('');
		}
	});

	/*=====================
		유효성 검사 - STEP2
	=======================*/

	// 수업 마감 일자
	$("#enddate").mouseleave(function() {
		var enddate = $('#enddate').val();

		if (enddate == '') {
			$("#err_enddate").text('클래스 개설 마감 일자를 선택하세요!');
			$("#err_enddate").css('color', font_color);
		} else {
			$("#err_enddate").text('');
		}
	});

	// 수업 오픈 시간 
	$("#opentime").mouseleave(function() {
		var opentime = $('#opentime').val();

		if (opentime == '') {
			$("#err_opentime").text('클래스 개설 오픈 시간을 선택하세요!');
			$("#err_opentime").css('color', font_color);
		} else {
			$("#err_opentime").text('');
		}
	});

	// 수업 마감 시간 
	$("#closetime").mouseleave(function() {
		var opentime = $('#opentime').val();
		var closetime = $('#closetime').val();

		if (closetime == '') {
			$("#err_closetime").text('클래스 개설 마감 시간을 선택하세요!');
			$("#err_closetime").css('color', font_color);
		} else if (opentime == closetime) {
			$("#err_closetime").text('오픈시간보다 크게 선택하세요!');
			$("#err_closetime").css('color', font_color);
		} else {
			$("#err_closetime").text('');
		}
	});

	// 추가 오픈 시간 1
	$("#add_opentime1").mouseleave(function() {
		var add_opentime1 = $('#add_opentime1').val();
		var add_closetime1 = $('#add_closetime1').val();

		if (add_opentime1 == '' && add_closetime1 != '') {
			$("#err_add_opentime1").text('추가 클래스 개설 오픈 시간을 확인하세요!');
			$("#err_add_opentime1").css('color', font_color);
		} else if (add_opentime1 != '' && add_closetime1 == '') {
			$("#err_add_closetime1").text('추가 클래스 개설 마감 시간을 확인하세요!');
			$("#err_add_closetime1").css('color', font_color);
		} else {
			$("#err_add_opentime1").text('');
			$("#err_add_closetime1").text('');
		}
	});

	// 추가 마감 시간 1
	$("#add_closetime1").mouseleave(function() {
		var add_opentime1 = $('#add_opentime1').val();
		var add_closetime1 = $('#add_closetime1').val();

		if (add_opentime1 == '' && add_closetime1 != '') {
			$("#err_add_opentime1").text('추가 클래스 개설 오픈 시간을 확인하세요!');
			$("#err_add_opentime1").css('color', font_color);
		} else if (add_opentime1 != '' && add_closetime1 == '') {
			$("#err_add_closetime1").text('추가 클래스 개설 마감 시간을 확인하세요!');
			$("#err_add_closetime1").css('color', font_color);
		} else {
			$("#err_add_opentime1").text('');
			$("#err_add_closetime1").text('');
		}
	});

	// 추가 오픈 시간 2
	$("#add_opentime2").mouseleave(function() {
		var add_opentime2 = $('#add_opentime2').val();
		var add_closetime2 = $('#add_closetime2').val();

		if (add_opentime2 == '' && add_closetime2 != '') {
			$("#err_add_opentime2").text('추가 클래스 개설 오픈 시간을 확인하세요!');
			$("#err_add_opentime2").css('color', font_color);
		} else if (add_opentime2 != '' && add_closetime2 == '') {
			$("#err_add_closetime2").text('추가 클래스 개설 마감 시간을 확인하세요!');
			$("#err_add_closetime2").css('color', font_color);
		} else {
			$("#err_add_opentime2").text('');
			$("#err_add_closetime2").text('');
		}
	});

	// 추가 마감 시간 2
	$("#add_closetime2").mouseleave(function() {
		var add_opentime2 = $('#add_opentime2').val();
		var add_closetime2 = $('#add_closetime2').val();

		if (add_opentime2 == '' && add_closetime2 != '') {
			$("#err_add_opentime2").text('추가 클래스 개설 오픈 시간을 확인하세요!');
			$("#err_add_opentime2").css('color', font_color);
		} else if (add_opentime2 != '' && add_closetime2 == '') {
			$("#err_add_closetime2").text('추가 클래스 개설 마감 시간을 확인하세요!');
			$("#err_add_closetime2").css('color', font_color);
		} else {
			$("#err_add_opentime2").text('');
			$("#err_add_closetime2").text('');
		}
	});


});


/*=======================================
		다음 단계 및 최종 등록 버튼을 눌렀을 때
	======================================*/

//STEP 1 단계 다음 부분
function next_check1() {
	var valid_check = $('.valid_check').text();

	var type = $('#type option:selected').val();
	var code = $('#code').val();
	var classname = $('#classname').val();
	var person = $('#person').val();
	var oneprice = $('#oneprice').val();
	var zipcode = $('#zipcode').val();
	var address1 = $('#address1').val();
	var address2 = $('#address2').val();

	// step1 단계에서 필수 입력 항목이 null 이면 modal 팝업 처리 
	if (type == '-' || code == '' || code == 'coffee_' || code == 'pottery_' || classname == '' ||
		person == '' || oneprice == '' || zipcode == '' ||
		address1 == '' || address2 == '') {
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

//STEP 2 단계 다음 부분
function next_check2() {
	var valid_check = $('.valid_check').text();

	var enddate = $('#enddate').val();
	var opentime = $('#opentime').val();
	var closetime = $('#closetime').val();


	// step2 단계에서 필수 입력 항목이 null 이면 modal 팝업 처리 
	if (enddate == '' || opentime == '' || closetime == '') {
		$('#isCheck').val('false');
		$('button#modalbtn2').attr('data-toggle', 'modal');
		$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#modal-body').text('입력한 값을 확인하세요!');
	} else if (valid_check != '') {// 유효성 에러가 담기는 <span> 태그에 값이 들어 있어도 modal 팝업 기능 추가 
		$('#isCheck').val('false');
		$('button#modalbtn2').attr('data-toggle', 'modal');
		$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#modal-body').text('입력한 값을 확인하세요!');
	} else {
		$('#isCheck').val('true');
		$('button#modalbtn2').removeAttr('data-toggle');
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
	유효성 검사 - STEP3 / 최종 등록 단계
  ================================*/
function submitCheck() {

	// 사진이 등록되지 않았을때 , 
	var main_image = $('#m_img').val();
	var detail_image1 = $('#d_img1').val();
	var detail_image2 = $('#d_img2').val();
	if (main_image == '' || detail_image1 == '' || detail_image2 == '') {
		$('#isCheck').val('false');
		$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
		$('#modal-body').html('원데이 클래스 상세보기에 <br> 쓰일 사진을 등록하세요!');
		$('#myModal').modal();

		return false;
	} else {
		$('button#modalbtn2').removeAttr('data-toggle');

		return true;
	}


}


/* ===================
	+ 버튼을 눌러야지 추가  
	section 이 보이게 처리
   ===================
*/
$(document).ready(function() {
	$('.time_add').click(function() {

		// step 2 
		var enddate = $('#enddate').val();
		var opentime = $('#opentime').val();
		var closetime = $('#closetime').val();


		if (enddate != '' && opentime != '' && closetime != '') {
			$('section#add1').toggle();
			$('p.time_add').removeAttr('data-toggle');
		} else {
			$('p.time_add').attr('data-toggle', 'modal');
			$('#modal-title').html('<i class="fas fa-exclamation-circle"></i>');
			$('#modal-body').text('기본 수업 정보를 먼저 입력하세요!');
		}
	});

});




/*===========================
		pickadate 날짜 지정 
		pickatime 시간 지정
   ==========================*/
function date() {
	$('.datepicker').pickadate({
		monthsShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		weekdaysShort: ['일', '월', '화', '수', '목', '금', '토'],
		format: 'yyyymmdd', // 데이터 형식
		min: 1, // 당일 이후 부터 선택 가능
		max: false, // 값 선택은 최대로 지정
		showMonthsShort: true
	});
}

function time() {
	var from_$input = $('.input_from').pickatime(),
		from_picker = from_$input.pickatime('picker')

	var to_$input = $('.input_to').pickatime({
		formatLabel: function(timeObject) {
			var minObject = this.get('min'),
				hours = timeObject.hour - minObject.hour,
				mins = (timeObject.mins - minObject.mins) / 60,
				pluralize = function(number, word) {
					return number + ' ' + (number === 1 ? word : word + 's')
				}
			return '<b>HH</b>:i <!i>A</!i> '
		}
	}),
		to_picker = to_$input.pickatime('picker')

	// Check if there’s a “from” or “to” time to start with.
	if (from_picker.get('value')) {
		to_picker.set('min', from_picker.get('select'))
	}
	if (to_picker.get('value')) {
		from_picker.set('max', to_picker.get('select'))
	}

	// When something is selected, update the “from” and “to” limits.
	from_picker.on('set', function(event) {
		if (event.select) {
			to_picker.set('min', from_picker.get('select'))
		}
	})
	to_picker.on('set', function(event) {
		if (event.select) {
			from_picker.set('max', to_picker.get('select'))
		}
	})

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

			$('#M_image').attr('src', e.target.result);
			$('#main_content').show();

			$('#main_title').html(input.files[0].name);
		};

		reader.readAsDataURL(input.files[0]);

	} else {
		removeUpload();
	}
}

function removeUpload_main() {
	$('#M_image').replaceWith($('#M_image').clone());
	$('#m_img').val('');
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
	세부 파일 업로드 1
   ===================
*/


function readURL_detail1(input) {
	if (input.files && input.files[0]) {

		var reader = new FileReader();

		reader.onload = function(e) {
			$('#detail1_wrap').hide();

			$('#D1_image').attr('src', e.target.result);
			$('#detail1_content').show();

			$('#detail1_title').html(input.files[0].name);
		};

		reader.readAsDataURL(input.files[0]);

	} else {
		removeUpload();
	}
}

function removeUpload_detail1() {
	$('#D1_image').replaceWith($('#D1_image').clone());
	$('#d_img1').val('');
	$('#detail1_content').hide();
	$('#detail1_wrap').show();
}

$('#detail1_wrap').bind('dragover', function() {
	$('#detail1_wrap').addClass('image-dropping');
});
$('#detail1_wrap').bind('dragleave', function() {
	$('#detail1_wrap').removeClass('image-dropping');
});

/* ===================
	세부 파일 업로드 2
   ===================
*/


function readURL_detail2(input) {
	if (input.files && input.files[0]) {

		var reader = new FileReader();

		reader.onload = function(e) {
			$('#detail2_wrap').hide();

			$('#D2_image').attr('src', e.target.result);
			$('#detail2_content').show();

			$('#detail2_title').html(input.files[0].name);
		};

		reader.readAsDataURL(input.files[0]);

	} else {
		removeUpload();
	}
}

function removeUpload_detail2() {
	$('#D2_image').replaceWith($('#D2_image').clone());
	$('#d_img2').val('');
	$('#detail2_content').hide();
	$('#detail2_wrap').show();
}
$('#detail2_wrap').bind('dragover', function() {
	$('#detail2_wrap').addClass('image-dropping');
});
$('#detail2_wrap').bind('dragleave', function() {
	$('#detail2_wrap').removeClass('image-dropping');
});

/* ===================
	원데이 클래스 등록[끝]
   ===================
*/
