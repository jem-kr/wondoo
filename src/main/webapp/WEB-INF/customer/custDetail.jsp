<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp"%>
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
</head>
<body>
	<div align="center" class="container col-sm-offset-2 col-sm-8">
		<div class="panel" align="center">
			<h2 class="subtitle wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">마이페이지</h2>
			<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">${sessionScope.loginfo.cust_Name}&nbsp;님의
				가입 정보입니다.</p>
		</div>
		<div class="panel panel-body">
			<%-- cust_Email ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="cust_Email" class="col-sm-3" style="text-align: right">
					<spring:message code="customer.cust_Email" />
				</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="fakecust_Email"
						id="fakecust_Email" value="${sessionScope.loginfo.cust_Email}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- cust_PW ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="cust_PW" class="col-sm-3" style="text-align: right">
					<spring:message code="customer.cust_PW" />
				</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" name="fakecust_PW"
						id="fakecust_PW" value="${sessionScope.loginfo.cust_PW}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- cust_Name ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="cust_Name" class="col-sm-3" style="text-align: right">
					<spring:message code="customer.cust_Name" />
				</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="fakecust_Name"
						id="fakecust_Name" value="${sessionScope.loginfo.cust_Name}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- cust_Contact ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="cust_Contact" class="col-sm-3" style="text-align: right">
					<spring:message code="customer.cust_Contact" />
				</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="fakecust_Contact"
						id="fakecust_Contact" value="${sessionScope.loginfo.cust_Contact}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- cust_Birth ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="cust_Birth" class="col-sm-3" style="text-align: right">
					<spring:message code="customer.cust_Birth" />
				</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="fakecust_Contact"
						id="fakecust_Contact" value="${sessionScope.loginfo.cust_Birth}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- cust_Zipcode & cust_ADR01------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="cust_Zipcode" class="col-sm-3" style="text-align: right">
					<spring:message code="customer.cust_ADR01" />
				</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" name="fakecust_Zipcode"
						id="fakecust_Zipcode" value="${sessionScope.loginfo.cust_Zipcode}"
						disabled="disabled" />
				</div>
				<div class="col-sm-4">
					<input type="text" class="form-control" name="fakecust_ADR01"
						id="fakecust_ADR01" value="${sessionScope.loginfo.cust_ADR01}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- cust_ADR02 ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="cust_ADR02" class="col-sm-3" style="text-align: right">
					<spring:message code="customer.cust_ADR02" />
				</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="fakecust_ADR02"
						id="fakecust_ADR02" value="${sessionScope.loginfo.cust_ADR02}"
						disabled="disabled" />
				</div>
			</div>
		</div>
		<%-- 하단 버튼------------------------------------------------- --%>
		<div class="submit_btn col-sm-offset-3 col-sm-6">
			<button class="submit"
				onclick="location.href='${contextPath}/custUpdate.cu?cust_Email=${sessionScope.loginfo.cust_Email}' ">회원정보
				수정하기</button>
		</div>
	</div>
</body>
</html>