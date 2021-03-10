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
</head>
<body style="padding-top: 100px;">
	<div align="center" class="container col-sm-offset-2 col-sm-8">
		<div class="panel">
			<div class="panel" align="center">
				<h1 class="subtitle wow fadeInDown" data-wow-delay="0.3s">비밀번호
					찾기</h1>
				<p class="subtitle-des wow fadeInDown">
					<strong>비밀번호가 기억나지 않아 답답하셨나요?</strong><br>아래 정보를 입력하시면, 비밀번호를
					알려드려요.
				</p>
			</div>
			<form name="login-form" action="<%=contextPath%>/sellPWSearch.se"
				method="post">
				<!-- sell_Email 이메일 입력 -->
				<div class="form-fild">
					<input type="text" placeholder="Business Email Address"
						class="input" name="sell_Email" id="sell_Email"
						data-toggle="tooltip" data-placement="top">
				</div>
				<!-- sell_Name 이름 입력 -->
				<div class="form-fild">
					<input type="text" placeholder="Brand Name" class="input"
						name="sell_Name" id="sell_Name" data-toggle="tooltip"
						data-placement="top">
				</div>
				<!-- sell_Contact 휴대폰번호 입력 -->
				<div class="form-fild">
					<input type="text" placeholder="Contact" class="input"
						name="sell_Contact" id="sell_Contact" data-toggle="tooltip"
						data-placement="top">
				</div>
				<!-- 하단 버튼 -->
				<button type="button" id="searchbtn" onclick="history.back();"
					class="btn btn-default">뒤로가기</button>
				<button type="submit" id="searchbtn" class="btn btn-primary"
					data-toggle="modal" data-target="#myModal"
					onclick="return pwcheck();">찾기</button>
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
