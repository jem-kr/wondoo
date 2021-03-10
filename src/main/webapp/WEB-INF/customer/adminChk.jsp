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
<link rel="stylesheet" href="${contextPath}/css/sellApp-style.css">
<script type="text/javascript" src="${contextPath}/js/sellApp.js"></script>

</head>
<body style="padding-bottom: 150px;">
	<div class="panel" align="center">
		<h2 class="subtitle wow fadeInDown" data-wow-duration="500ms"
			data-wow-delay="0.3s">사업자 승인 신청</h2>
		<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
			data-wow-delay="0.3s">승인 신청이 완료되면 상품 판매와 수업 예약을 진행할 수 있어요!</p>
	</div>
	<div class="panel panel-body">
		<c:set var="apppath" value="<%=contextPath%>" />
		<%-- form태그 시작 ------------------------------------------------- --%>
		<form enctype="multipart/form-data" method="post"
			action="${apppath}/adminChk.cu" class="form-horizontal" role="form"
			name="myform" onsubmit="return chk_submit();">
			
			<input type="hidden" name="sell_Email" value="${bean.sell_Email}">
			<div class="form-group">
				<div class="file-upload">
					<!-- 사업자 상태 --------------------------------------------------- -->
					<!-- 관리자만 선택할 수 있음 ------------------------------------------ -->
					<c:if test="${whologin == 1}">
						<select class="form-control" name="sell_Status" id="sell_Status">
							<c:if test="${bean.sell_Status == '신청전'}">
								<option class="form-control" value="신청전" selected="selected">신청전</option>
								<option class="form-control" value="대기중">대기중</option>
								<option class="form-control" value="승인">승인</option>
							</c:if>
							<c:if test="${bean.sell_Status == '대기중' || bean.sell_Status == ''}">
								<option class="form-control" value="신청전">신청전</option>
								<option class="form-control" value="대기중" selected="selected">대기중</option>
								<option class="form-control" value="승인">승인</option>
							</c:if>
							<c:if test="${bean.sell_Status == '승인'}">
								<option class="form-control" value="신청전">신청전</option>
								<option class="form-control" value="대기중">대기중</option>
								<option class="form-control" value="승인" selected="selected">승인</option>
							</c:if>
						</select>
					</c:if>
					<br /> <br />
					<!-- 파일 업로드 시작 --------------------------------------------------- -->
					
					<div class="image-upload-wrap">
						<img src="./upload/${bean.sell_Pic}" class="img-responsive"
										width="100"alt="${bean.sell_Pic}">
						
					</div>
					
					<!-- 파일 업로드 끝 --------------------------------------------------- -->
					<br /> <br /> <br /> <br /> <br />
					<button class="file-upload-btn" type="button">*사업자번호 입력</button>
					<br /> <br /> <input type="text"
						placeholder="----- License Number -----"
						style="padding: 10px; text-align: center; margin: 0px; font-size: 20pt; height: 100px;"
						class="form-control" name="fakesell_License" id="fakesell_License" disabled="disabled"
						value="${bean.sell_License}"> 
				</div>
			</div>
			<%-- 하단 버튼------------------------------------------------- --%>
			<div class="submit_btn col-sm-offset-3 col-sm-6">
				<p class="fas_text">
					<i class="fas fa-check-circle"></i>&nbsp;타인에게 사업자 명의를 빌려주거나 타인 명의로
					사업 영위할 경우, <br />국세 및 부가가치세법 등에 대한 불이익이 있을 수 있습니다.
				</p>
				<button class="appsubmit" type="submit" id="submit" name="submit" onclick="statusbtn()">사업자 승인 상태 수정</button>
			</div>
		</form>
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