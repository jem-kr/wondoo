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
<script type="text/javascript" src="${contextPath}/js/login.js"></script>

<!-- 카카오 로그인 구현중 -->
<!-- <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 --><script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
   <div align="center" class="container col-md-12">
      <div class="cd-tabs">
         <nav>
            <ul class="cd-tabs-navigation">
               <li><a href="#" data-content="login" class="selected">개인회원</a></li>
               <li><a href="#" data-content="signup">사업자회원</a></li>
            </ul>
         </nav>
         <ul class="cd-tabs-content">
            <%-- 개인회원 로그인 ------------------------------------------------------- --%>
            <li data-content="login" class="selected">
               <form name="login-form" action="<%=contextPath%>/custLog.cu"
                  method="post">
                  <div class="form-fild">
                     <input type="text" placeholder="Email Address" class="input"
                        name="cust_Email" id="cust_Email" data-toggle="tooltip"
                        data-placement="top" title="이메일을 입력해주세요." value="">
                  </div>
                  <div class="form-fild">
                     <input type="password" placeholder="Password" class="input"
                        name="cust_PW" id="cust_PW" data-toggle="tooltip"
                        data-placement="top" title="비밀번호를 입력해주세요." value="">
                  </div>
                  <button type="submit" data-toggle="modal" data-target="#myModal"
                     id="loginbtn" onclick="return logincheck();">로그인</button>
                  <div class="search">
                     <span><a href="<%=contextPath%>/custIdSearch.cu">이메일
                           찾기</a> ｜</span> <span><a href="<%=contextPath%>/custInsert.cu">회원가입</a>
                        ｜</span> <span><a href="<%=contextPath%>/custPWSearch.cu">비밀번호
                           찾기</a></span>
                  </div>
                  <hr>
                  <div class="social">
                     <span>SNS계정으로 간편 로그인/회원가입</span>
                  </div>
                  
                  <!-- 카카오 로그인 버튼 생성 -->
						<!-- <a href="javascript:kakaoLogin();"> -->
						 <a href="https://kauth.kakao.com/oauth/authorize?client_id=b8d0c914a6edd571c65d199b22e14fb8&redirect_uri=http://localhost:8989/cafe/kakaoLog.cu&response_type=code">
							<button type="button" class="kakao btn-lg" id="kakao-login-btn">
								카카오로 시작하기
							</button>
						</a>
               </form>
            </li>
            <%-- 사업자회원 로그인 ------------------------------------------------------- --%>
            <li data-content="signup">
               <form name="signup-form" action="<%=contextPath%>/sellLog.se"
                  method="post">
                  <div class="form-fild">
                     <input type="text" placeholder="Business Email Address"
                        class="input" name="sell_Email" id="sell_Email"
                        data-toggle="tooltip" data-placement="top" title="이메일을 입력해주세요."
                        value="">
                  </div>
                  <div class="form-fild">
                     <input type="password" placeholder="Password" class="input"
                        name="sell_PW" id="sell_PW" data-toggle="tooltip"
                        data-placement="top" title="비밀번호를 입력해주세요." value="">
                  </div>

                  <button type="submit" data-toggle="modal" data-target="#myModal"
                     id="loginbtn" onclick="return logincheck_sell();">로그인</button>

                  <div class="search">
                     <span><a href="<%=contextPath%>/sellIdSearch.se">이메일
                           찾기</a> ｜</span> <span><a href="<%=contextPath%>/sellInsert.se">회원가입</a>
                        ｜</span> <span><a href="<%=contextPath%>/sellPWSearch.se">비밀번호
                           찾기</a></span>
                  </div>
               </form>
            </li>
         </ul>
      </div>
   </div>

</body>
</html>