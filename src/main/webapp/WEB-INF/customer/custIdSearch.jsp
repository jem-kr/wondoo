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
<link rel="stylesheet" href="${contextPath}/css/custLog-style.css">
<script type="text/javascript" src="${contextPath}/js/custSearch.js"></script>
<script type="text/javascript">
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
		$("#searchbtn").attr("disabled", true);
		$('#cust_Name').val('');
      	$('#cust_Name').focus();
} else { 
       	$("#check_custName").text("올바른 이름 형태입니다 :)");
		$("#check_custName").css('color', '#5080BF');
		$("#searchbtn").attr("disabled", false);
}
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
		$("#searchbtn").attr("disabled", true);
		$('#cust_Contact').val('');
      	$('#cust_Contact').focus();
} else if(cust_Contact == ""){
	$("#check_custContact").text("휴대폰번호를 입력해주세요 :p");
	$("#check_custContact").css('color', 'red');
	$("#searchbtn").attr("disabled", true);
} else { 
       	$("#check_custContact").text("올바른 휴대폰번호 형태입니다 :)");
		$("#check_custContact").css('color', '#5080BF');
		$("#searchbtn").attr("disabled", false);
}
});
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
			$("#searchbtn").attr("disabled", true);
			$('#cust_Birth').val('');
          	$('#cust_Birth').focus();
	} else { //값이 존재하고 올바른 생년월일 형태인 경우(YYMMDD)
           	$("#check_custBirth").text("올바른 생년월일 형태입니다 :)");
			$("#check_custBirth").css('color', '#5080BF');
			$("#searchbtn").attr("disabled", false);
	}
});
});	
</script>
</head>
<body style="padding-top: 100px;">
	<div align="center" class="container col-sm-offset-2 col-sm-8">
		<div class="panel">
			<div class="panel" align="center">
				<h1 class="subtitle wow fadeInDown" data-wow-delay="0.3s">이메일
					찾기</h1>
				<p class="subtitle-des wow fadeInDown">
					<strong>이메일 주소가 기억나지 않아 답답하셨나요?</strong><br>아래 정보를 입력하시면, 이메일
					주소를 알려드려요.
				</p>
			</div>
			<form name="login-form" action="<%=contextPath%>/custIdSearch.cu"
				method="post" onsubmit="return id_search();">
				<!-- cust_Name 이름 입력 -->
				<div class="form-fild">
					<input type="text" placeholder="Name" class="input"
						name="cust_Name" id="cust_Name" data-toggle="tooltip"
						data-placement="top">
					<div class="valid_check" id="check_custName"></div>
				</div>
				<!-- cust_Contact 휴대폰번호 입력 -->
				<div class="form-fild">
					<input type="text" placeholder="Contact" class="input"
						name="cust_Contact" id="cust_Contact" data-toggle="tooltip"
						data-placement="top">
					<div class="valid_check" id="check_custContact"></div>	
				</div>
				<!-- cust_Birth 생년월일 입력 -->
				<div class="form-fild">
					<input type="text" placeholder="Birth (ex. 950101)" class="input"
						name="cust_Birth" id="cust_Birth" data-toggle="tooltip"
						data-placement="top">
					<div class="valid_check" id="check_custBirth"></div>	
				</div>
				<!-- 하단 버튼 -->
				<button type="button" id="searchbtn" onclick="history.back();"
					class="btn btn-default">뒤로가기</button>
				<button type="submit" id="searchbtn" class="btn btn-primary"
					data-toggle="modal" data-target="#myModal"
					onclick="return idcheck();">찾기</button>
			</form>
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
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
