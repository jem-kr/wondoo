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
<script type="text/javascript" src="${contextPath}/js/sellUpdate.js"></script>
<script type="text/javascript">
/*탈퇴 부분*/
function getContextPath(){
    var offset=location.href.indexOf(location.host)+location.host.length;
    var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
    return ctxPath;
}


function del_check(){
	var sell_Email=$('#sell_Email').val();
	location.href ="/sellDel.se?sell_Email="+sell_Email;
}


/* ===============================
휴대폰번호 정규표현식
===============================
*/
$(function(){
$("#sell_Contact").blur(function() {
	var regexp = /^[0-9]*$/;
	var sell_Contact = $('#sell_Contact').val();
	if( !regexp.test(sell_Contact) ) {
		$("#check_sellContact").text("숫자만 입력해주세요 :p");
		$("#check_sellContact").css('color', 'red');
		$("#sell-submit").attr("disabled", true);
		$('#sell_Contact').val('');
      	$('#sell_Contact').focus();
} else { 
       	$("#check_sellContact").text("올바른 연락처 형태입니다 :)");
		$("#check_sellContact").css('color', '#5080BF');
		$("#sell-submit").attr("disabled", false);
}
});
});	

/* ===============================
비밀번호 정규표현식
===============================
*/
$(function(){
$("#sell_PW").blur(function() {
var regexp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
var sell_PW = $('#sell_PW').val();
if( !regexp.test(sell_PW) ) {
	$("#check_sellPW").text("숫자, 문자, 특수문자 포함 8~15자리 이내로 입력해주세요 :p");
	$("#check_sellPW").css('color', 'red');
	$("#sell-submit").attr("disabled", true);
	$('#check_sellPW').val('');
  	$('#check_sellPW').focus();
}else if(sell_PW == ""){
$("#check_sellPW").text("비밀번호를 입력해주세요 :)");
$("#check_sellPW").css('color', 'red');
$("#sell-submit").attr("disabled", true);

}else { 
   	$("#check_sellPW").text("올바른 비밀번호 형태입니다 :)");
	$("#check_sellPW").css('color', '#5080BF');
	$("#sell-submit").attr("disabled", false);
}
});
});	

/* ===============================
이름 정규표현식(사업자는 한글, 영어, 숫자만)
===============================
*/
$(function(){
$("#sell_Name").blur(function() {
	var regExp = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|]+$/;
var sell_Name = $('#sell_Name').val();
if(regExp.test(sell_Name) == false) {
	$("#check_sellName").text("한글 또는 영어로 입력해주세요 :p");
	$("#check_sellName").css('color', 'red');
	$("#sell-submit").attr("disabled", true);
	$('#sell_Name').val('');
  	$('#sell_Name').focus();
} else { 
   	$("#check_sellName").text("올바른 상호명 형태입니다 :)");
	$("#check_sellName").css('color', '#5080BF');
	$("#sell-submit").attr("disabled", false);
}
});
});	

</script>

</head>
<body style="padding-bottom: 150px;">
	<div align="center" class="container col-sm-offset-2 col-sm-8">
		<div class="panel" align="center">
			<h2 class="subtitle wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">사업자 정보 수정</h2>
			<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">사업자 정보 수정 페이지입니다.</p>
			<!-- 회원탈퇴 ----------------------------------------------------- -->
			<div class="delete">
				<a id="delbtn" data-toggle="modal" data-target=".modal">
					회원탈퇴</a>
			</div>
		</div>
		<div class="panel panel-body">
			<c:set var="apppath" value="<%=contextPath%>" />
			<%-- form태그 시작 ------------------------------------------------- --%>
			<form method="post" action="${apppath}/sellUpdate.se"
				class="form-horizontal" role="form" name="myform"
				onsubmit="return chk_submit();">
				<%-- sell_Email ------------------------------------------------- --%>
				<%-- 중복 체크 기능이 필요없습니다. --%>
				<%-- 이메일은 읽기 전용으로 설정하고, 숨겨서 넘기도록 합니다. --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="sell_Email" class="col-sm-3" style="text-align: right">
						<spring:message code="seller.sell_Email" />*
					</label>
					<div class="col-sm-6">
						<input type="text" placeholder="Your Email" class="form-control"
							name="fakesell_Email" id="fakesell_Email"
							value="${bean.sell_Email}" disabled="disabled" /> <input
							type="hidden" name="sell_Email" id="sell_Email"
							value="${bean.sell_Email}">
					</div>
				</div>
				<%-- sell_PW ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="sell_PW" class="col-sm-3" style="text-align: right">
						<spring:message code="seller.sell_PW" />*
					</label>
					<div class="col-sm-6">
						<input type="password" placeholder="Your Password"
							class="form-control" name="sell_PW" id="sell_PW"
							value="${bean.sell_PW}">
						<div class="valid_check" id="check_sellPW"></div>	
					</div>
				</div>
				
								
				<%-- sell_Name ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="sell_Name" class="col-sm-3" style="text-align: right">
						<spring:message code="seller.sell_Name" />*
					</label>
					<div class="col-sm-6">
						<input type="text" placeholder="Your Name" class="form-control"
							name="sell_Name" id="sell_Name" value="${bean.sell_Name}">
						<div class="valid_check" id="check_sellName"></div>
					</div>
				</div>
				<%-- sell_Contact ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="sell_Contact" class="col-sm-3"
						style="text-align: right"> <spring:message
							code="seller.sell_Contact" />*
					</label>
					<div class="col-sm-6">
						<input type="text" placeholder="Your Contact" class="form-control"
							name="sell_Contact" id="sell_Contact"
							value="${bean.sell_Contact}"> 
							<div class="valid_check" id="check_sellContact"></div>
					</div>
				</div>
				<%-- sell_Zipcode ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="sell_Zipcode" class="col-sm-3"
						style="text-align: right"> <spring:message
							code="seller.sell_ADR01" />
					</label>
					<div class="col-sm-2">
						<input type="text" placeholder="Zipcode" class="form-control"
							name="fakesell_Zipcode" id="fakesell_Zipcode"
							value="${bean.sell_Zipcode}" disabled="disabled"> <input
							type="hidden" name="sell_Zipcode" id="sell_Zipcode"
							value="${bean.sell_Zipcode}">
					</div>
					<%-- sell_ADR01 ------------------------------------------------- --%>
					<div class="col-sm-4">
						<input type="text" placeholder="Your Address" class="form-control"
							name="fakesell_ADR01" id="fakesell_ADR01"
							value="${bean.sell_ADR01}" disabled="disabled"> <input
							type="hidden" id="sell_ADR01" name="sell_ADR01" value="${bean.sell_ADR01}"
							style="text-align: left">
					</div>
					<!-- 우편번호 찿기 버튼 -->
					<div class="col-sm-3" align="left">
						<input type="button" class="btn"
							value="<spring:message code="seller.findZipcode"/>"
							onclick='zipCheck();'>
					</div>
				</div>
				<%-- sell_ADR02 ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="sell_ADR02" class="col-sm-3" style="text-align: right">
						<spring:message code="seller.sell_ADR02" />
					</label>
					<div class="col-sm-6">
						<input type="text" placeholder="Your Detail Address"
							class="form-control" name="sell_ADR02" id="sell_ADR02"
							value="${bean.sell_ADR02}">
					</div>
				</div>
				<%-- 하단 버튼------------------------------------------------- --%>
				<div class="submit_btn col-sm-offset-3 col-sm-6">
					<button type="submit" class="submit" id="sellup-submit">수정
						완료</button>
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
						<h4 id="modal-title" class="modal-title" style="font-size: 35px">
							<i class="fas fa-exclamation-circle"></i>
						</h4>
					</div>
					<div class="modal-body">
						<p id="modal-body" style="font-size: 13px">정말 삭제하시겠습니까?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px" id="modal-btn-del" onclick="del_check();">삭제</button>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px" id="modal-btn-no">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>