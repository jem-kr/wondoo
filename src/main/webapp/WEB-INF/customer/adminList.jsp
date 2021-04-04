<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./../common/common.jsp"%>
<!-- spring:message 및 properties 파일 사용을 위함  -->
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
<title>전체 개인 회원 목록</title>
<!-- AdminList Style CSS -->
<link rel="stylesheet" href="${contextPath}/css/adminList-style.css">
<style type="text/css">
th{
	background-color: #5080bf;
	color:white;
}
</style>
</head>
<body>
	<%-- 관리자 권한, 회원 목록 보기 -------------------------------------------------------%>
	<div align="center" class="container col-sm-offset-2 col-sm-8">
		<div class="panel" align="center">
			<h2 class="subtitle wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">개인회원 전체 목록</h2>
			<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">개인회원 전체 목록 페이지입니다.</p>
		</div>
			
		<div class="row">
					<%-- [검색 모드] ==== 시작 ==== --%>
				<span class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
					data-wow-delay="0.1s" id="search_btn" data-toggle="tooltip"
					title="클릭하세요!" onclick="search();"> <i class="fas fa-search"></i>
					검색
				</span> <br>
			<form id="contact-form search" method="get"
				action="${contextPath}/adminList.cu" role="form">
				<div id="search">
					<select class="form-control" name="mode" id="mode"
						data-toggle="tooltip" title="검색할 조건을 선택하세요!">
						<option class="form-control" value="all">전체</option>
						<option class="form-control" value="cust_Contact">연락처</option>
						<option class="form-control" value="cust_Email">이메일</option>
					</select> <input type="text" class="form-control"
						placeholder="검색할 내용을 입력하세요" id="keyword" name="keyword">
					<button type="submit">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</form>
			<%-- ==== 끝 ==== --%>

			<table class="table table-bordered table-hover dt-responsive">

				<%-- 회원 목록의 header 부분 -------------------------------------------------------%>
				<thead>
					<tr>
						<th width="20%"><spring:message code="customer.cust_Email" /></th>
						<th width="10%"><spring:message code="customer.cust_Name" /></th>
						<th width="10%"><spring:message code="customer.cust_Birth" /></th>
						<th width="20%"><spring:message code="customer.cust_Contact" /></th>
						<th width="10%"><spring:message code="customer.cust_Join" /></th>
						<th width="10%"><spring:message code="customer.cust_RegDate" /></th>
					</tr>
				</thead>

				<%-- 회원 목록의 내용 부분 -------------------------------------------------------%>
				<tbody>
					<c:forEach var="bean" items="${requestScope.lists}">
						<tr>
							<td><a href="${contextPath}/custUpdate.cu?cust_Email=${bean.cust_Email}">${bean.cust_Email}</a></td>
							<td>${bean.cust_Name}</td>
							<td>${bean.cust_Birth}</td>
							<td>${bean.cust_Contact}</td>
							<td>${bean.cust_Join}</td>
							<td>${bean.cust_RegDate}</td>
						</tr>
					</c:forEach>
				</tbody>

				<%-- 회원 목록의 하단 부분 -------------------------------------------------------%>
				<tfoot>
					<tr>
						<td colspan="6" align="center">${requestScope.pagingHtml}</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</body>
</html>