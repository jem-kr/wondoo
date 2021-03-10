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
<script type="text/javascript" src="${contextPath}/js/sellSearch.js"></script>
</head>
<body style="padding-top: 100px;">
	<div align="center" class="container col-sm-offset-2 col-sm-8">
		<div class="panel">
			<div class="panel" align="center">
				<h2 class="subtitle wow fadeInDown" data-wow-delay="0.3s">비밀번호
					찾기</h2>
				<p class="subtitle-des wow fadeInDown">
					<b>${bean.sell_Name}</b>님의 비밀번호는 아래와 같습니다.
				</p>
			</div>
			<!-- sell_Email 이메일 주소 결과 출력 -->
			<div class="form-result">
				<span>${bean.sell_Email}</span> <span>${bean.sell_PW}</span>
			</div>
			<!-- 하단 버튼 -->
			<button type="button" id="loginGo_btn"
				class="loginGo_btn btn-primary btn-lg"
				onclick="location.href='<%=contextPath%>/custLog.cu'">로그인하러
				가기</button>
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