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
<style type="text/css">
#status a{
  color: white;
}

#status {
  width: 65px;
  height: 20px;
  font-size:11px;
  font-weight: bold;
  font-family: 'Nanum Gothic';
  color: white;
  line-height: 21px;
  text-align: center;
  background: #84C1D9;
  border: solid 1px grey;
  border-radius: 90px;
}
</style>
</head>
<body>
	<div align="center" class="container col-sm-offset-2 col-sm-8">
		<div class="panel" align="center">
			<h2 class="subtitle wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">마이페이지</h2>
			<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
				data-wow-delay="0.3s">
				${sessionScope.loginfo_seller.sell_Name}&nbsp;사업자님의 가입 정보입니다.</p>
				
				<div id="status"><a href="${contextPath}/sellApp.se?sell_Email=${sessionScope.loginfo_seller.sell_Email}">${sessionScope.loginfo_seller.sell_Status}</a></div>
		</div>
		<div class="panel panel-body">
			<%-- sell_Email ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="sell_Email" class="col-sm-3" style="text-align: right">
					<spring:message code="seller.sell_Email" />
				</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="fakesell_Email"
						id="fakesell_Email"
						value="${sessionScope.loginfo_seller.sell_Email}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- sell_PW ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="sell_PW" class="col-sm-3" style="text-align: right">
					<spring:message code="seller.sell_PW" />
				</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" name="fakesell_PW"
						id="fakesell_PW" value="${sessionScope.loginfo_seller.sell_PW}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- sell_Name ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="sell_Name" class="col-sm-3" style="text-align: right">
					<spring:message code="seller.sell_Name" />
				</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="fakesell_Name"
						id="fakesell_Name"
						value="${sessionScope.loginfo_seller.sell_Name}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- sell_Contact ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="sell_Contact" class="col-sm-3" style="text-align: right">
					<spring:message code="seller.sell_Contact" />
				</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="fakesell_Contact"
						id="fakesell_Contact"
						value="${sessionScope.loginfo_seller.sell_Contact}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- sell_Zipcode & sell_ADR01------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="sell_Zipcode" class="col-sm-3" style="text-align: right">
					<spring:message code="seller.sell_ADR01" />
				</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" name="fakesell_Zipcode"
						id="fakesell_Zipcode"
						value="${sessionScope.loginfo_seller.sell_Zipcode}"
						disabled="disabled" />
				</div>
				<div class="col-sm-4">
					<input type="text" class="form-control" name="fakesell_ADR01"
						id="fakesell_ADR01"
						value="${sessionScope.loginfo_seller.sell_ADR01}"
						disabled="disabled" />
				</div>
			</div>
			<br> <br>
			<%-- sell_ADR02 ------------------------------------------------- --%>
			<div class="form-group wow fadeInDown animated"
				data-wow-duration="500ms" data-wow-delay=".6s">
				<label for="sell_ADR02" class="col-sm-3" style="text-align: right">
					<spring:message code="seller.sell_ADR02" />
				</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" name="fakesell_ADR02"
						id="fakesell_ADR02"
						value="${sessionScope.loginfo_seller.sell_ADR02}"
						disabled="disabled" />
				</div>
			</div>
		</div>
		<%-- 하단 버튼------------------------------------------------- --%>
		<div class="submit_btn col-sm-offset-3 col-sm-6">
			<button class="submit"
				onclick="location.href='${contextPath}/sellUpdate.se?sell_Email=${sessionScope.loginfo_seller.sell_Email}' ">사업자정보
				수정하기</button>
		</div>
	</div>

</body>
</html>