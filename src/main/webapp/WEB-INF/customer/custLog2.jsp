<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="./../common/common.jsp" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	int myoffset = 2;
	int mywidth = twelve - 2 * myoffset;
	int formleft = 3 ;
	int formright = twelve - formleft ; 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath}/css/custLog-style.css">
<script type="text/javascript">

/* 	$(".login-form").hide();
	$(".login").css("background", "none");
	
	$(".login").click(function(){
	  $(".signup-form").hide();
	  $(".login-form").show();
	  $(".signup").css("background", "none");
	  $(".login").css("background", "#fff");
	});
	
	$(".signup").click(function(){
	  $(".signup-form").show();
	  $(".login-form").hide();
	  $(".login").css("background", "none");
	  $(".signup").css("background", "#5080bf");
	});
	
	$(".btn").click(function(){
	  $(".input").val("");
	}); */
	
</script>
</head>
<body>
<div align="center" class="container col-md-12">
	<div class="panel panel-default panel-primary">
			<div class="panel-heading">로그인 하기</div>
			<div class="panel-body">
				<form class="form-horizontal" role="form" action="<%=contextPath%>/custLog.cu" method="post">
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="cust_Email">아이디</label>
						<div class="col-sm-<%=formright%>">
							<input type="text" class="form-control" name="cust_Email" id="cust_Email"
								data-toggle="tooltip" data-placement="top" 
								title="아이디는  4글자 이상 10글자 이하로 입력해 주세요."
								placeholder="아이디를 넣어 주셔용^^" value="admin@gmail.com">
								<span class="err">${errid}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-<%=formleft%>" for="cust_PW">비밀 번호</label>
						<div class="col-sm-<%=formright%>">
							<input type="password" class="form-control" name="cust_PW"
								id="cust_PW" placeholder="비밀 번호를 넣어 주셔용^^" value="admin123">
							<span class="err">${errpassword}</span>
						</div>
					</div>
					<div class="form-group">
						<div align="center" class="col-sm-offset-3 col-sm-6">
							<button class="btn btn-default" type="submit">로그인</button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button class="btn btn-default" type="reset">취소</button>
							&nbsp;&nbsp;&nbsp;
							<a href="<%=contextPath%>/Insert.me">회원 가입</a>
						</div>
					</div>
				</form>
			</div>
		</div>
</div>
	<script>
		$(document).ready(function(){
    		$('[data-toggle="tooltip"]').tooltip();    		
		});
	</script>
</body>
</html>