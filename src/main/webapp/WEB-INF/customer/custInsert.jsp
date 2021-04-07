<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./../common/common.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
int myoffset = 2;
int mywidth = twelve - 2 * myoffset;
int formleft = 3;
int formright = twelve - formleft;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath}/css/custInsert-style.css">
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="${contextPath}/js/custInsert.js"></script>
<script type="text/javascript">
/* ===============================
[ajax] 이메일 중복검사
===============================
*/
$(document).ready(function(){
	$("#cust_Email").blur(function() {
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var cust_Email = $('#cust_Email').val();
		var isCheck = $('#isCheck').val();
		console.log(cust_Email);
		$.ajax({
			url : './idCheck.cu',
			type : 'get',
			data: {'cust_Email':cust_Email},
			contentType: "applictaion/json; charset=utf-8",
			success : function(data) {
			console.log("1 = 중복o / 0 = 중복x : "+ data);							
			if (data == '1') {
						// 1 : 이메일이 중복되는 문구
					$("#check_custEmail").text("사용중인 이메일입니다 :p");
					$("#check_custEmail").css("color", "red");
					$("#cust-submit").attr("disabled", true);
			} else {
						
				if(cust_Email == ""){
						$("#check_custEmail").text("이메일을 입력해주세요 :)");
						$("#check_custEmail").css('color', 'red');
						$("#cust-submit").attr("disabled", true);
				} else if(regExp.test(cust_Email) == false) {
						$("#check_custEmail").text("올바른 이메일 형태가 아닙니다 :p");
						$("#check_custEmail").css('color', 'red');
						$("#cust-submit").attr("disabled", true);
				} else {
					$("#check_custEmail").text("사용 가능한 이메일입니다 :)");
	                $("#check_custEmail").css('color', '#5080BF');
	                $("#sell-submit").attr("disabled", false);
				}
			}
				}, error : function(error) {
						console.dir(error)
				}
			});
		});
	});	

/* ===============================
	휴대폰번호 정규표현식
===============================
*/
$(function(){
	$("#cust_Contact").blur(function() {
		var regexp = /^[0-9]*$/;
		var cust_Contact = $('#cust_Contact').val();
		if( !regexp.test(cust_Contact) ) {
			$("#check_custContact").text("숫자만 입력해주세요 :p");
			$("#check_custContact").css('color', 'red');
			$("#cust-submit").attr("disabled", true);
			$('#cust_Contact').val('');
          	$('#cust_Contact').focus();
	} else if(cust_Contact == ""){
		$("#check_custContact").text("휴대폰번호를 입력해주세요 :p");
		$("#check_custContact").css('color', 'red');
		$("#cust-submit").attr("disabled", true);
	} else { 
           	$("#check_custContact").text("올바른 휴대폰번호 형태입니다 :)");
			$("#check_custContact").css('color', '#5080BF');
			$("#cust-submit").attr("disabled", false);
	}
});
});	

/* ===============================
	비밀번호 정규표현식
===============================
*/
$(function(){
$("#cust_PW").blur(function() {
	var regexp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	var cust_PW = $('#cust_PW').val();
	if( !regexp.test(cust_PW) ) {
		$("#check_custPW").text("숫자, 문자, 특수문자 포함 8~15자리 이내로 입력해주세요 :p");
		$("#check_custPW").css('color', 'red');
		$("#cust-submit").attr("disabled", true);
		$('#check_custPW').val('');
      	$('#check_custPW').focus();
}else if(cust_PW == ""){
	$("#check_custPW").text("비밀번호를 입력해주세요 :)");
	$("#check_custPW").css('color', 'red');
	$("#cust-submit").attr("disabled", true);
	
}else { 
       	$("#check_custPW").text("올바른 비밀번호 형태입니다 :)");
		$("#check_custPW").css('color', '#5080BF');
		$("#cust-submit").attr("disabled", false);
}
});
});	


/* ===============================
	비밀번호 확인 일치 검사
===============================
*/
	$(function(){
	$('#cust_PW2').blur(function(){
		var cust_PW = $('#cust_PW').val();
		var cust_PW2 = $('#cust_PW2').val();
	   if($('#cust_PW').val() != $('#cust_PW2').val()){
	    	if($('#cust_PW2').val()!=''){//비밀번호가 일치하지 않고 공백도 아닐 경우
	    		$("#check_custPW2").text("비밀번호가 일치하지 않습니다 :p");
				$("#check_custPW2").css('color', 'red');
				$("#cust-submit").attr("disabled", true);	
	    		$('#cust_PW2').val('');
	          	$('#cust_PW2').focus();
	          	//경고text를 화면에 출력하고 submit버튼을 비활성화시킴 
	    		}
	    } else if(cust_PW == ""){ //비밀번호 값이 없는 경우
	    	$('#cust_PW').focus();
	    	$("#check_custPW").text("비밀번호를 입력해주세요 :)");
	    	$("#check_custPW").css('color', 'red');
	    	$("#cust-submit").attr("disabled", true);
	    } else {//비밀번호가 일치하는 경우,
				$("#check_custPW2").text("비밀번호가 일치합니다 :)");
	 			$("#check_custPW2").css('color', '#5080BF');
		    	$("#cust-submit").attr("disabled", false);
		    	//경고text를 화면에서 숨기고 submit버튼을 활성화시킴	  
	    }
	})  	   
});


/* ===============================
	생년월일 정규표현식
===============================
*/
	$(function(){
		$("#cust_Birth").blur(function() {
			var regExp = /([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))/;
			var cust_Birth = $('#cust_Birth').val();
		if(regExp.test(cust_Birth) == false) { //값이 올바른 생년월일 형태가 아닌 경우
				$("#check_custBirth").text("올바른 생년월일 형태가 아닙니다 :p");
				$("#check_custBirth").css('color', 'red');
				$("#cust-submit").attr("disabled", true);
				$('#cust_Birth').val('');
	          	$('#cust_Birth').focus();
		} else { //값이 존재하고 올바른 생년월일 형태인 경우(YYMMDD)
	           	$("#check_custBirth").text("올바른 생년월일 형태입니다 :)");
				$("#check_custBirth").css('color', '#5080BF');
				$("#cust-submit").attr("disabled", false);
		}
	});
});	

/* ===============================
	이름 정규표현식(한글, 영어만)
===============================
*/
$(function(){
	$("#cust_Name").blur(function() {
		var regExp = /^[ㄱ-ㅎ|가-힣|a-z|A-Z]+$/;
		var cust_Name = $('#cust_Name').val();
	if(regExp.test(cust_Name) == false) {
			$("#check_custName").text("한글 또는 영어로 입력해주세요 :p");
			$("#check_custName").css('color', 'red');
			$("#cust-submit").attr("disabled", true);
			$('#cust_Name').val('');
          	$('#cust_Name').focus();
	} else { 
           	$("#check_custName").text("올바른 이름 형태입니다 :)");
			$("#check_custName").css('color', '#5080BF');
			$("#cust-submit").attr("disabled", false);
	}
});
});	

</script>
</head>
<body style="padding-bottom: 150px;">
	<div align="center" class="container col-sm-offset-2 col-sm-8">
		<div class="panel" align="center">
			<h2 class="subtitle wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">회원가입</h2>
			<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">필수 항목들을 반드시 작성해주세요!</p>
		</div>
		<div class="panel panel-body">
			<c:set var="apppath" value="<%=contextPath%>" />
			<%--  
				파일 업로드를 위한 설정
				1. 전송하고자 하는 입력 폼을 <form>태그 사이에 위치해놓습니다.
				2. method를 post로 설정해줍니다.(get으로 설정 시 파라미터값들이 url에 따라들어가기 떄문)
			 	3. enctype을 multipart/form-data로 설정합니다.
			 	4. input type submit 버튼을 <form>태그 사이에 위치시킵니다.
				* multipart/form-data는 서버에서 MultipartHttpServletRequest로 받아야 합니다.			 
			 --%>
			
			<%-- form태그 시작 ------------------------------------------------- --%>
			<form enctype="multipart/form-data" method="post"
				action="${apppath}/custInsert.cu" class="form-horizontal"
				role="form" name="myform" onsubmit="return chk_submit();">

				<%-- 프로필사진, cust_Pic ------------------------------------------------- --%>
				<div class="form-group">
					<div class="file-upload">
						<%-- 파일 UPLOAD : button 또는 h3 클릭 --%>
						<button class="file-upload-btn" type="button"
							onclick="$('.file-upload-input').trigger( 'click' )">Add Image</button>
						<div class="image-upload-wrap">
							<input type="file" class="file-upload-input" name="img" id="img"
								onchange="readURL(this);" accept="image/*" />
							<div class="drag-text">
								<h3>
									<span>Upload Profile</span>
								</h3>
							</div>
						</div>
						<%-- 기존 파일 REMOVE --%>
						<div class="file-upload-content">
							<img class="file-upload-image" src="#" alt="your image" />
							<div class="image-title-wrap">
								<button type="button" onclick="removeUpload()"
									class="remove-image"> Remove <span class="image-title">Uploaded Image</span>
								</button>
							</div>
						</div>
					</div>
				</div>
				
				<%-- cust_Email ---------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_Email" class="col-sm-3" style="text-align: right">
						<spring:message code="customer.cust_Email" />*
					</label>
					<div class="col-sm-6">
					<%-- 
						카카오 회원가입 시 sessionScope.k_email로 카카오계정의 이메일 주소를 받아옵니다.
					 --%>
						<input type="text" placeholder="Your Email" class="form-control"
							name="cust_Email" id="cust_Email" value="${sessionScope.k_email != null ? sessionScope.k_email : ''}"/> 
							<div class="valid_check" id="check_custEmail"></div>
					</div>
				</div>
				
				<%-- cust_PW ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_PW" class="col-sm-3" style="text-align: right">
						<spring:message code="customer.cust_PW" />*
					</label>
					<div class="col-sm-6">
						<input type="password" placeholder="Your Password"
							class="form-control" name="cust_PW" id="cust_PW"> 
							<div class="valid_check" id="check_custPW"></div>
					</div>
				</div>
				
				<%-- cust_PW2 확인 --------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_PW2" class="col-sm-3" style="text-align: right">
						비밀번호 확인*
					</label>
					<div class="col-sm-6">
						<input type="password" placeholder="Check Your Password"
							class="form-control" name="cust_PW2" id="cust_PW2"> 
							<div class="valid_check" id="check_custPW2"></div>
					</div>
				</div>				
				
				<%-- cust_Name ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_Name" class="col-sm-3" style="text-align: right">
						<spring:message code="customer.cust_Name" />*
					</label>
					<div class="col-sm-6">
						<input type="text" placeholder="Your Name" class="form-control"
							name="cust_Name" id="cust_Name" value="${sessionScope.k_name != null ? sessionScope.k_name : ''}">
							<div class="valid_check" id="check_custName"></div>
					</div>
				</div>
				<%-- cust_Contact ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_Contact" class="col-sm-3"
						style="text-align: right"> 
						<spring:message code="customer.cust_Contact" />*
					</label>
					<div class="col-sm-6">
						<input type="text" placeholder="Your Contact" class="form-control"
							name="cust_Contact" id="cust_Contact">
						<div class="valid_check" id="check_custContact"></div>
					</div>
				</div>
				<%-- cust_Birth ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_Birth" class="col-sm-3" style="text-align: right">
						<spring:message code="customer.cust_Birth" />*
					</label>
					<div class="col-sm-6">
						<input type="number" placeholder="YYMMDD" class="form-control"
							name="cust_Birth" id="cust_Birth" value="${cust_Birth}">
						<div class="valid_check" id="check_custBirth"></div>
					</div>
				</div>
				<%-- cust_Zipcode ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_Zipcode" class="col-sm-3" style="text-align: right"> 
						<spring:message code="customer.cust_ADR01" />
					</label>
					<div class="col-sm-2">
						<input type="text" placeholder="Zipcode" class="form-control"
							name="fakecust_Zipcode" id="fakecust_Zipcode"
							value="${cust_Zipcode}" disabled="disabled"> 
							<input type="hidden" name="cust_Zipcode" id="cust_Zipcode"
							value="${cust_Zipcode}">
					</div>
					<%-- cust_ADR01 ------------------------------------------------- --%>
					<div class="col-sm-4">
						<input type="text" placeholder="Your Address" class="form-control"
							name="fakecust_ADR01" id="fakecust_ADR01" value="${cust_ADR01}"
							disabled="disabled"> 
							<input type="hidden" id="cust_ADR01" name="cust_ADR01" style="text-align: left">
					</div>
					<!-- 우편번호 찿기 버튼 -->
					<div class="col-sm-3" align="left">
						<input type="button" class="btn"
							value="<spring:message code="customer.findZipcode"/>"
							onclick='zipCheck();'>
					</div>
				</div>
				<%-- cust_ADR02 ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_ADR02" class="col-sm-3" style="text-align: right">
						<spring:message code="customer.cust_ADR02" />
					</label>
					<div class="col-sm-6">
						<input type="text" placeholder="Your Detail Address"
							class="form-control" name="cust_ADR02" id="cust_ADR02"
							value="${cust_ADR02}">
					</div>
				</div>
				
				<%-- 개인정보동의 여부 기본값인 "Y"를 hidden으로 넘겨줍니다. --%>
				<input type="hidden" name="cust_Join" value="Y">
				
				<br /><br />
				<%-- 하단 버튼------------------------------------------------- --%>
				<div class="submit_btn col-sm-offset-3 col-sm-6">
					<p style="font-size: 10px; line-height: 12px;">
						<i class="fas fa-check-circle"></i>&nbsp;
						가입 시, 구매 이용약관, 원두 전자금융거래 이용약관, <br />
						구매자 개인정보 수집 및 이용 동의에 대해 동의합니다.
					</p>
					<button type="submit" id="cust-submit" class="submit"
						data-toggle="modal" data-target="#myModal">동의하고 가입하기</button>
				</div>
			</form>
			<%-- form태그 끝 ------------------------------------------------- --%>
		</div>
	</div>
	<!-- ------------------------------------- [모달 section]--------------------------------------- -->
	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 id="modal-title" class="modal-title" style="font-size: 35px"></h4>
					</div>
					<div class="modal-body">
						<p id="modal-body" style="font-size: 13px"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="loginGo_btn btn-default"
							data-dismiss="modal" style="font-size: 13px">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>