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
<script type="text/javascript" src="${contextPath}/js/sellInsert.js"></script>
<script type="text/javascript">
/* [ajax] 이메일 중복검사 */
$(document).ready(function(){
	$("#sell_Email").blur(function() {
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var sell_Email = $('#sell_Email').val();
		var isCheck = $('#isCheck').val();
		console.log(sell_Email)
		$.ajax({
			url : './idCheck.se',
			type : 'get',
			data: {'sell_Email':sell_Email},
			contentType: "applictaion/json; charset=utf-8",
			success : function(data) {
			console.log("1 = 중복o / 0 = 중복x : "+ data);							
			if (data == '1') {
						// 1 : 이메일이 중복되는 문구
					$("#check_sellEmail").text("사용중인 이메일입니다 :p");
					$("#check_sellEmail").css("color", "red");
					$("#sell-submit").attr("disabled", true);
			} else {
						
				if(sell_Email == ""){
						$("#check_sellEmail").text("이메일을 입력해주세요 :)");
						$("#check_sellEmail").css('color', 'red');
						$("#sell-submit").attr("disabled", true);
				} else if(regExp.test(sell_Email) == false) {
						$("#check_sellEmail").text("올바른 이메일 형태가 아닙니다 :p");
						$("#check_sellEmail").css('color', 'red');
						$("#sell-submit").attr("disabled", true);
				} else {
					$("#check_sellEmail").text("사용 가능한 이메일입니다 :)");
	                $("#check_sellEmail").css('color', '#5080BF');
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
	비밀번호 확인 일치 검사
	===============================
	*/
	$(function(){
	$('#sell_PW2').blur(function(){
		var sell_PW = $('#sell_PW').val();
		var sell_PW2 = $('#sell_PW2').val();
	   if($('#sell_PW').val() != $('#sell_PW2').val()){
	    	if($('#sell_PW2').val()!=''){//비밀번호가 일치하지 않고 공백도 아닐 경우
	    		$("#check_sellPW2").text("비밀번호가 일치하지 않습니다 :p");
				$("#check_sellPW2").css('color', 'red');
				$("#sell-submit").attr("disabled", true);	
	    		$('#sell_PW2').val('');
	          	$('#sell_PW2').focus();
	          	//경고text를 화면에 출력하고 submit버튼을 비활성화시킴 
	    		}
	    } else if(sell_PW == ""){ //비밀번호 값이 없는 경우
	    	$('#sell_PW').focus();
	    	$("#check_sellPW").text("비밀번호를 입력해주세요 :)");
	    	$("#check_sellPW").css('color', 'red');
	    	$("#sell-submit").attr("disabled", true);
	    } else {//비밀번호가 일치하는 경우,
				$("#check_sellPW2").text("비밀번호가 일치합니다 :)");
	 			$("#check_sellPW2").css('color', '#5080BF');
		    	$("#sell-submit").attr("disabled", false);
		    	//경고text를 화면에서 숨기고 submit버튼을 활성화시킴	  
	    }
	})  	   
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
		$("#check_sellName").text("올바른 상호명 형태가 아닙니다 :p");
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
				data-wow-delay="0.3s">사업자 회원가입</h2>
			<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">필수 항목들을 반드시 작성해주세요!</p>
		</div>
		<div class="panel panel-body">
			<c:set var="apppath" value="<%=contextPath%>" />
			<%-- form태그 시작 ------------------------------------------------- --%>
			<form method="post" action="${apppath}/sellInsert.se"
				class="form-horizontal" role="form" name="myform"
				onsubmit="return chk_submit();">

				<!-- hidden으로 변경할 데이터 -->
				<input type="hidden" name="sell_Status" value="신청전">
				<input type="hidden" name="sell_Join" value="Y">

				<%-- [ajax] sell_Email ---------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="sell_Email" class="col-sm-3" style="text-align: right">
						<spring:message code="seller.sell_Email" />*
					</label>
					<div class="col-sm-6">
						<input type="text" placeholder="Your Business Email" class="form-control"
							name="sell_Email" id="sell_Email"
							/> 
							<div class="valid_check" id="check_sellEmail"></div>
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
							class="form-control" name="sell_PW" id="sell_PW"> 
							<div class="valid_check" id="check_sellPW"></div>
					</div>
				</div>

				<%-- sell_PW2 비밀번호 확인 ------------------------------------------ --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="sell_PW2" class="col-sm-3" style="text-align: right">
						비밀번호 확인*
					</label>
					<div class="col-sm-6">
						<input type="password" placeholder="Check Your Password"
							class="form-control" name="sell_PW2" id="sell_PW2"> 
							<div class="valid_check" id="check_sellPW2"></div>
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
							name="sell_Name" id="sell_Name" value="${sell_Name}"> 
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
							name="sell_Contact" id="sell_Contact" value="${sell_Contact}">
						<div class="valid_check" id="check_sellContact"></div>
					</div>
				</div>
				<%-- sell_Zipcode ------------------------------------------------- --%>
				<div class="form-group wow fadeInDown animated"
					data-wow-duration="500ms" data-wow-delay=".6s">
					<label for="sell_Zipcode" class="col-sm-3" style="text-align: right"> 
						<spring:message code="seller.sell_ADR01" />
					</label>
					
					<div class="col-sm-2">
						<input type="text" placeholder="Zipcode" class="form-control"
							name="fakesell_Zipcode" id="fakesell_Zipcode"
							value="${sell_Zipcode}" disabled="disabled"> 
							<input type="hidden" name="sell_Zipcode" id="sell_Zipcode" value="${sell_Zipcode}">
					</div>
					<%-- sell_ADR01 ------------------------------------------------- --%>
					<div class="col-sm-4">
						<input type="text" placeholder="Your Address" class="form-control"
							name="fakesell_ADR01" id="fakesell_ADR01" value="${sell_ADR01}"
							disabled="disabled"> 
							<input type="hidden" id="sell_ADR01" name="sell_ADR01" style="text-align: left">
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
							value="${sell_ADR02}">
					</div>
				</div>
				<br /><br />
				<%-- 하단 버튼------------------------------------------------- --%>
				<div class="col-sm-offset-3 col-sm-6">
					<p style="font-size: 10px; line-height: 12px;">
						<i class="fas fa-check-circle"></i>&nbsp;가입 시, 판매 이용약관, 원두 전자금융거래
						이용약관, <br />판매자 개인정보 수집 및 이용 동의에 대해 동의합니다.
					</p>
					<button type="submit" id="sell-submit" class="submit"
						data-toggle="modal" data-target="#myModal"
						>동의하고 가입하기</button>
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