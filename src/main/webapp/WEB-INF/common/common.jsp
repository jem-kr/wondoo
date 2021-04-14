<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String contextPath = request.getContextPath();
%>
<c:set var="contextPath" value="<%=contextPath%>" scope="application" />

<!-- whologin 변수는 로그인 상태를 저장하고 있는 변수입니다. -->
<c:set var="whologin" value="0" />
<c:if
	test="${empty sessionScope.loginfo || empty sessionScope.loginfo_seller}">
	<!-- 로그인 하지 않은 경우 (비회원)-->
	<c:set var="whologin" value="0" />
</c:if>

<c:if
	test="${not empty sessionScope.loginfo || not empty sessionScope.loginfo_seller}">
	<!-- 사업자로 로그인한 경우 -->
	<c:if
		test="${empty sessionScope.loginfo.cust_Email || not empty sessionScope.loginfo_seller.sell_Email}">
		<c:set var="whologin" value="2" />
	</c:if>
	<!-- 일반 사용자로 로그인한 경우 -->
	<c:if
		test="${not empty sessionScope.loginfo.cust_Email || empty sessionScope.loginfo_seller.sell_Email}">
		<c:set var="whologin" value="3" />
	</c:if>
	<!-- 관리자로 로그인한 경우 -->
	<c:if
		test="${sessionScope.loginfo.cust_Email == 'admin@gmail.com' || sessionScope.loginfo_seller.sell_Email == 'admin@gmail.com'}">
		<c:set var="whologin" value="1" />
	</c:if>
</c:if>

<%
// 파일 업로드 관련
String myurl = request.getRequestURL().toString();
String uri = request.getRequestURI();
int idx = myurl.indexOf(uri);
//웹서버에 올릴 이미지의 저장 경로 
String uploadPath = "/upload";//개발자가 임의 지정 가능
String uploadedFolder = myurl.substring(0, idx) + contextPath + uploadPath;
String realPath = application.getRealPath(uploadPath);
%>

<!-- 부트 스트랩 -->
<%
int twelve = 12;
%>
<c:set var="twelve" value="12" />
<%!String YesForm = null;
	String NoForm = null;%>
<!DOCTYPE html>
<html class="no-js">
<head>
<!-- Basic Page Needs
        ================================================== -->
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="shortcut icon" href="images/favicon.ico">
<link rel="icon" type="image/png" href="images/favicon.png">
<title>:::DOPE COFFEE:::</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="author" content="">
<!-- Mobile Specific Metas
        ================================================== -->
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Template CSS Files
        ================================================== -->
<!-- Twitter Bootstrs CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- Ionicons Fonts Css -->
<link rel="stylesheet" href="css/ionicons.min.css">
<!-- animate css -->
<link rel="stylesheet" href="css/animate.css">
<!-- Hero area slider css-->
<link rel="stylesheet" href="css/slider.css">
<!-- owl craousel css -->
<link rel="stylesheet" href="css/owl.carousel.css">
<link rel="stylesheet" href="css/owl.theme.css">
<link rel="stylesheet" href="css/jquery.fancybox.css">
<!-- template main css file -->
<link rel="stylesheet" href="css/main.css">
<!-- responsive css -->
<link rel="stylesheet" href="css/responsive.css">

<!-- Template Javascript Files
        ================================================== -->
<!-- modernizr js -->
<script src="js/vendor/modernizr-2.6.2.min.js"></script>
<!-- jquery -->
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<!-- owl carouserl js -->
<script src="js/owl.carousel.min.js"></script>
<!-- bootstrap js -->

<script src="js/bootstrap.min.js"></script>
<!-- wow js -->
<script src="js/wow.min.js"></script>
<!-- slider js -->
<script src="js/slider.js"></script>
<script src="js/jquery.fancybox.js"></script>
<!-- template main js -->
<script src="js/main.js"></script>

<!-- pickatime / pickadate API 사용-->
<link rel="stylesheet" href="${contextPath}/css/default.css">
<link rel="stylesheet" href="${contextPath}/css/default.date.css">
<link rel="stylesheet" href="${contextPath}/css/default.time.css">
<script type="text/javascript" src="js/picker.js"></script>
<script type="text/javascript" src="js/picker.date.js"></script>
<script type="text/javascript" src="js/picker.time.js"></script>

<!-- 카카오 우편 주소 API 사용 -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 아이콘 사용 -->
<script src="https://kit.fontawesome.com/0bccbc6608.js" crossorigin="anonymous"></script>


<script type="text/javascript">
	/* ==================================
	 모든 검색 기능 토글 처리 
	==================================
	*/
	$(document).ready(function() {
	$('#search').hide();
	});
	
	
	
	//검색 버튼을 누르면 검색 창이 나오게 수정
	function search() {
	$('#search').toggle();
	}	
	
	

</script>
</head>
<body onload="modal_popup();">
	<!--
        ==================================================
        Header Section Start
        ================================================== -->
	<header id="top-bar" class="navbar-fixed-top animated-header">
		<div class="container">
			<div class="navbar-header">
				<!-- responsive nav button -->
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<!-- /responsive nav button -->

				<!-- logo -->
				<div class="navbar-brand">
					<a href="${contextPath }/main.co"> <img
						src="images/coffeelogo.jpg" alt="">
					</a>
				</div>
				<!-- /logo -->
			</div>
			<!-- main menu -->
			<nav class="collapse navbar-collapse navbar-right" role="navigation">
				<div class="main-menu">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="${contextPath}/main.co">Home</a></li>
						<li><a href="${contextPath}/nolist.no">공지사항</a></li>
						<li><a href="${contextPath}/cbti.cb">내 커피 찾기</a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">회원 <span class="caret"></span></a> <c:if
								test="${whologin == 0}">
								<div class="dropdown-menu">
									<ul>
										<li><a href="${contextPath}/custInsert.cu">회원가입</a></li>
										<li><a href="${contextPath}/sellInsert.se">사업자 회원가입</a></li>
										<li><a href="${contextPath}/custLog.cu">로그인</a></li>
									</ul>
								</div>
							</c:if> <c:if test="${whologin == 1 || whologin == 3}">
								<div class="dropdown-menu">
									<ul>
										<li><a href="${contextPath}/custLogout.cu">로그아웃</a></li>
										<li><a href="${contextPath}/custDetail.cu">마이페이지</a></li>
										<li><a
											href="${contextPath}/custUpdate.cu?cust_Email=${sessionScope.loginfo.cust_Email}">회원정보수정</a></li>
										<li><a href="${contextPath}/prOrderList.po?cust_email=${sessionScope.loginfo.cust_Email}">나의 구매내역</a></li>
										<li>
											<a href="${contextPath}/onedayCustOrderList.odc?cust_email=${sessionScope.loginfo.cust_Email}">나의 수업내역</a>
										</li>
										<li><a href="${contextPath}/caList.ca?cart_cust_email=${sessionScope.loginfo.cust_Email}">나의 장바구니</a></li>
									</ul>
								</div>
							</c:if> 
							<c:if test="${whologin == 2}">
								<div class="dropdown-menu">
									<ul>
										<li><a href="${contextPath}/sellLogout.se">로그아웃</a></li>
										<li><a href="${contextPath}/sellDetail.se">마이페이지</a></li>
										<li><a
											href="${contextPath}/sellUpdate.se?sell_Email=${sessionScope.loginfo_seller.sell_Email}">회원정보수정</a></li>
										<li><a href="${contextPath}/sellorderlist.pm">상품관리</a></li>
										<li><a
											href="${contextPath}/onedaySellOrderlist.odc?sell_email=${sessionScope.loginfo_seller.sell_Email}">수업관리</a></li>
										<li><a
											href="${contextPath}/sellApp.se?sell_Email=${sessionScope.loginfo_seller.sell_Email}">사업승인신청</a></li>
									</ul>
								</div>
							</c:if>
						</li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">원데이클래스 <span class="caret"></span></a>
							<div class="dropdown-menu">
								<ul>
									<c:if test="${whologin == 2}">
										<li><a href="${contextPath}/onedayInsert.odc">수업등록</a></li>
									</c:if>
									<li><a href="${contextPath}/onedayList.odc">수업목록</a></li>
								</ul>
							</div></li>
							<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">커피 <span class="caret"></span></a>
							<div class="dropdown-menu">
								<ul>
									<li><a href="${contextPath}/cfList.pr">커피목록</a></li>
								</ul>
							</div></li>
							<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">용품 및 기타 <span class="caret"></span></a>
							<div class="dropdown-menu">
								<ul>
									<li><a href="${contextPath}/prList.pr">용품목록</a></li>
								</ul>
							</div></li>
						<c:if test="${whologin == 1}">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">관리자메뉴 <span class="caret"></span></a>

								<div class="dropdown-menu">
									<ul>
										<li><a href="${contextPath}/admin.cu">사업자 승인 관리</a></li>
                             			<li><a href="${contextPath}/adminApp.cu">사업자회원 관리</a></li>
                            			<li><a href="${contextPath}/adminList.cu">개인회원 관리</a></li>
										<li><a href="${contextPath}/onedayAdminOrderlist.odc">원데이 클래스 <br>전체 결제내역</a></li>
									</ul>
								</div></li>
						</c:if>
						<li>
							<c:if test="${whologin == 2}">
								<a href="${contextPath}/prInsert.pr">상품등록</a>
							</c:if>
							<c:if test="${whologin == 3}">
							<a href="${contextPath}/caList.ca?cart_cust_email=${sessionScope.loginfo.cust_Email}"> 
								<i class="fas fa-shopping-cart"></i> 장바구니
							</a>
							</c:if>
						</li>
						
						<c:if test="${whologin==0 }">
							<li><a href="${contextPath}/custLog.cu"> <i
									class="fa fa-user-circle-o" style="font-size: 15px"></i> login
							</a></li>
						</c:if>
						<c:if test="${whologin==1||whologin==3 }">
							<li><a href="${contextPath}/custLogout.cu"> <i
									class="fa fa-sign-out" style="font-size: 15px"></i> logout
							</a></li>
						</c:if>
						<c:if test="${whologin==2 }">
							<li>
								<a href="${contextPath}/sellLogout.se"> 
									<i class="fa fa-sign-out" style="font-size: 15px"></i> logout
								</a>
							</li>
						</c:if>
						
					</ul>
				</div>

			</nav>
			<!-- /main nav -->
		</div>
	</header>
	<%-- =======================================
              에러 메세지를 담아주는 modal 부분 [시작]
         ========================================     
        --%>
	<c:if test="${not empty sessionScope.message}">
		<div class="container">
			<input type="hidden" id="modal_popup" value="${sessionScope.message}">
			<!-- Modal -->
			<div class="modal fade" id="modal_pop" role="dialog">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 id="modal-title" class="modal-title" style="font-size: 35px">
								<i class="fas fa-exclamation-circle"></i>
							</h4>
						</div>
						<div class="modal-body">
							<p id="modal-body" style="font-size: 13px">${sessionScope.message}</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal" style="font-size: 13px">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	<%-- =================================================
	      [장바구니 추가 후 이동 경로 모달 section 시작 부분] 
	     ================================================= --%>
	<c:if test="${not empty sessionScope.cart_modal}">
		<input type="text" id="cart_popup" value="${sessionScope.cart_modal}">
		<!-- 장바구니 데이터 추가 후 페이지 경로 이동 시 회원 이메일 파라미터 값이 필요함 -->
        <input type="hidden" disabled="disabled" name="cust_Email" id="cust_Email" 
        value="${sessionScope.loginfo.cust_Email}">
		<div class="container">
		
		  <!-- Modal -->
		  <div class="modal fade" id="cart_pop" role="dialog">
		    <div class="modal-dialog modal-sm">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 id="modal-title" class="modal-title" style="font-size: 35px">
		          	 <i class="fas fa-cart-arrow-down"></i>
		          </h4>
		        </div>
		        <div class="modal-body">
		          <p id="modal-body" style="font-size: 13px">장바구니에 상품이 담겼습니다.</p>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal" style="font-size: 13px" 
		          onclick="gotopage_caList();">바로가기</button>
		          <button type="button" class="btn btn-default" data-dismiss="modal" style="font-size: 13px">쇼핑 계속하기</button>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>  
	</c:if>

</body>

<script type="text/javascript">
	/* 페이지가 열렸을 때 에러메세지를 담고있는 모달을 보여줘야함 */
	function modal_popup() {
		var modal_popup = $('#modal_popup').val();
		var cart_popup = $('#cart_popup').val();

		if (modal_popup != '') {
			$('#modal_pop').modal();
		}
		
		if (cart_popup != '') {
			$('#cart_pop').modal();
		}
	<%
		session.removeAttribute("cart_modal");
		session.removeAttribute("message");
	%>
	}
	

	/* ===============================
		장바구니 추가 성공 후 이동 경로 확인 부분
	   ===============================
	*/

	function getContextPath() {
		var offset = location.href.indexOf(location.host) + location.host.length;
		var ctxPath = location.href.substring(offset, location.href.indexOf('/', offset + 1));
		return ctxPath;
	}


	// 장바구니 바로가기 버튼을 클릭 시 장바구니 페이지로 이동 
	function gotopage_caList() {
		var cart_cust_email = $('#cust_Email').val();
		location.href = getContextPath() + "/caList.ca?cart_cust_email=" + cart_cust_email;
	}

	

</script>


<%-- =======================================
             에러 메세지를 담아주는 modal 부분 [끝]
     =======================================     
--%>
</html>