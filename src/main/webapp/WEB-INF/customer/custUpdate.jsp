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
<script type="text/javascript" src="${contextPath}/js/custUpdate.js"></script>
<script type="text/javascript">
/*탈퇴 부분*/
function getContextPath(){
    var offset=location.href.indexOf(location.host)+location.host.length;
    var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
    return ctxPath;
}


function del_check(){
	var cust_Email=$('#cust_Email').val();
	location.href ="/custDel.cu?cust_Email="+cust_Email;
}
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
				data-wow-delay="0.3s">회원 정보 수정</h2>
			<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">회원 정보 수정 페이지입니다.</p>
			<!-- 회원탈퇴 ----------------------------------------------------- -->
			<div class="delete">
				<a id="delbtn" data-toggle="modal" data-target=".modal">
					회원탈퇴</a>
			</div>
		</div>
		<div class="panel panel-body">
			<c:set var="apppath" value="<%=contextPath%>" />
			<%-- form태그 시작 ------------------------------------------------- --%>
			<form method="post" enctype="multipart/form-data"
				action="${apppath}/custUpdate.cu" class="form-horizontal"
				role="form" name="myform" onsubmit="return chk_submit();">
				<!-- hidden으로 넘길 데이터 ------------------------------------------------- -->
				<input type="hidden" name="isCheck" value="false"> <input
					type="hidden" name="cust_Join" value="Y">

				<%-- 프로필사진, cust_Pic ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<div class="avatar-upload">
						<div id="imagePreview">
							<c:if test="${empty bean.cust_Pic}">
								<img src="https://2runcoffee.com/common/img/default_profile.png"
									class="avatar-preview" alt="no image">
							</c:if>
							<c:if test="${not empty bean.cust_Pic}">
								<img src="${contextPath}/upload/${bean.cust_Pic}"
									class="avatar-preview" width="200" height="200"
									alt="${cust_Pic}">
							</c:if>
						</div>

						<div class="avatar-edit">
							<input name="cust_Pic" type="hidden" value="${bean.cust_Pic}">
							기존 이미지 : <input type="text" name="oldimg"
								value="${bean.cust_Pic}"> <input type="file"
								class="imageUpload" name="img" id="img"
								placeholder="파일을 선택하지 않으면 기존 이미지가 유지됩니다."> <label
								for="imageUpload"></label>
						</div>
					</div>
				</div>
				<%-- cust_Email ------------------------------------------------- --%>
				<%-- 중복 체크 기능이 필요없습니다. --%>
				<%-- 이메일은 읽기 전용으로 설정하고, 숨겨서 넘기도록 합니다. --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_Email" class="col-sm-3" style="text-align: right">
						<spring:message code="customer.cust_Email" />*
					</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" name="fakecust_Email"
							id="fakecust_Email" value="${bean.cust_Email}"
							disabled="disabled" /> <input type="hidden" name="cust_Email"
							id="cust_Email" value="${bean.cust_Email}">
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
							class="form-control" name="cust_PW" id="cust_PW"
							value="${bean.cust_PW}"> 
						<div class="valid_check" id="check_custPW"></div>	
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
							name="cust_Name" id="cust_Name" value="${bean.cust_Name}">
						<div class="valid_check" id="check_custName"></div>
					</div>
				</div>
				<%-- cust_Contact ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_Contact" class="col-sm-3"
						style="text-align: right"> <spring:message
							code="customer.cust_Contact" />*
					</label>
					<div class="col-sm-6">
						<input type="text" placeholder="Your Contact" class="form-control"
							name="cust_Contact" id="cust_Contact"
							value="${bean.cust_Contact}">
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
							name="cust_Birth" id="cust_Birth" value="${bean.cust_Birth}">
						<div class="valid_check" id="check_custBirth"></div>
					</div>
				</div>
				<%-- cust_Zipcode & cust_ADR01------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="cust_Zipcode" class="col-sm-3"
						style="text-align: right"> <spring:message
							code="customer.cust_ADR01" />
					</label>
					<div class="col-sm-2">
						<input type="text" placeholder="Zipcode" class="form-control"
							name="fakecust_Zipcode" id="fakecust_Zipcode"
							value="${bean.cust_Zipcode}" disabled="disabled"> <input
							type="hidden" name="cust_Zipcode" id="cust_Zipcode"
							value="${bean.cust_Zipcode}">
					</div>
					<div class="col-sm-4">
						<input type="text" placeholder="Your Address" class="form-control"
							name="fakecust_ADR01" id="fakecust_ADR01"
							value="${bean.cust_ADR01}" disabled="disabled"> <input
							type="hidden" id="cust_ADR01" value="${bean.cust_ADR01}" name="cust_ADR01"
							style="text-align: left">
					</div>
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
							value="${bean.cust_ADR02}">
					</div>
				</div>
				<%-- 하단 버튼------------------------------------------------- --%>
				<div class="submit_btn col-sm-offset-3 col-sm-6">
					<button type="submit" class="submit" id="cust-submit"
						data-toggle="modal" data-target="#myModal">수정 완료</button>
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