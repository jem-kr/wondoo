<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<style type="text/css">
		/*이미지 hover 되었을 때 전체*/
	.overlay{
	    width: 100% !important;
	}
	
	/*이미지 hover 되었을 때 버튼*/
	.buttons{
	    width: inherit !important;
	    position: absolute !important;
	    top: 45% !important;
	    left: 0% !important;
	}
	
	/* 이미지 클래스명 ,상품명 부분 */
	figure figcaption h4 a {
	    color: #5080BF !important;
	}
	
	figure figcaption h4 a:hover {
	    color: #5080BF !important;
	}
	.list_bottom{
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: space-between;
		align-content: center;
	}

	.list_bottom p.list_person {
		font-size: 13px !important;
		border-radius: 20px;
	    background-color: #84C1D9;
		padding: 5px 10px 5px 10px;
		color: #fff;
		font-weight: bold !important;
		margin-top: 10px !important;
	}
	#list_price{
		font-size: 20px;
	}
	
</style>
</head>
<body>


	<!--
        ==================================================
        Slider Section Start
        ================================================== -->
	<section id="hero-area">
		<div class="container">
			<div class="row">
				<div class="col-md-12 text-center">
					<div class="block wow fadeInUp" data-wow-delay=".3s">

						<!-- Slider -->
						<section class="cd-intro">
							<h1 class="wow fadeInUp animated cd-headline slide"
								data-wow-delay=".4s">
								<span>안녕하세요. DOPE COFFEE 입니다. 당신과 딱 맞는 </span><br> <span
									class="cd-words-wrapper"> <b class="is-visible">커피를
										찾아드립니다.</b> <b>원데이 클래스를 찾아드립니다.</b> 
								</span>
							</h1>
						</section>
						<!-- cd-intro -->
						<!-- /.slider -->
						<h2 class="wow fadeInUp animated" data-wow-delay=".6s">
							저희 DOPE COFFEE는 다양한 싱글오리진, 블렌딩, 캡슐 커피를 제공하기 위해 최고의 노력을 다할 것을
							약속합니다.<BR> 당신의 집이 최고의 카페가 될 수 있도록 도와드리겠습니다.
						</h2>
						<a
							class="btn-lines dark light wow fadeInUp animated smooth-scroll btn btn-default btn-green"
							data-wow-delay=".9s" href="#works" data-section="#works">최신
							상품 보기</a>
						<div align="right" id="kakao-talk-channel-chat-button"
							data-channel-public-id="_qsUeK" data-title="consult"
							data-size="small" data-color="yellow" data-shape="pc"
							data-support-multiple-densities="true"></div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/#main-slider-->

	<section id="works" class="works">
		<div class="container">
			<div class="section-heading">
				<h1 class="title wow fadeInDown" data-wow-delay=".3s">
					NEW COFFEE & ONEDAY CLASS</h1>
				<p class="wow fadeInDown" data-wow-delay=".5s">
					가장 최신 상품 입니다.
				</p>
				<p class="wow fadeInDown" data-wow-delay=".5s">
					로그인을 하시고 DOPE COFFEE의 다양한 커피와 원데이클래스를 만나보세요.
				</p>
			</div>
			<%-- =================
				커피 섹션
			====================== --%>
			<div class="row">
				<c:forEach var="productbean" items="${requestScope.products}" varStatus="status">
					<c:if test="${status.count <= 3}">
						<div class="col">
							<div class="col-sm-4 col-xs-12">
								<figure class="wow fadeInLeft animated portfolio-item"
									data-wow-duration="500ms" data-wow-delay="0ms">
									<div class="img-wrapper">
										<img src="./upload/${productbean.pro_pic}" class="img-responsive"
											alt="this is a title">
										<div class="overlay">
											<div class="buttons">
												<a href="${contextPath}/prDetail.pr?products_seq=${productbean.products_seq}">상품보기</a>
											</div>
										</div>
									</div>
									<figcaption>
										<h4>
											<a href="${contextPath}/prDetail.pr?products_seq=${productbean.products_seq}">${productbean.pro_name}</a>
										</h4>
										<div class="list_bottom">
											<p id="list_price">
												<i class="fas fa-won-sign"></i>&nbsp;
												<fmt:formatNumber pattern="###,###" value="${productbean.pro_price}" />
											</p>
										</div>
									</figcaption>
								</figure>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<%-- =================
				원데이 섹션
			====================== --%>
			<div class="row">
				<c:forEach var="onedaybean" items="${requestScope.lists}" varStatus="status">
					<c:if test="${status.count <= 3}">
						<div class="col">
							<div class="col-sm-4 col-xs-12">
								<figure class="wow fadeInLeft animated portfolio-item"
									data-wow-duration="500ms" data-wow-delay="0ms">
									<div class="img-wrapper">
										<img src="./upload/${onedaybean.main_image}" class="img-responsive"
											alt="this is a title">
										<div class="overlay">
											<div class="buttons">
												<a href="${contextPath}/onedayDetail.odc?code=${onedaybean.code}">수업보기</a>
											</div>
										</div>
									</div>
									<figcaption>
										<h4>
											<a href="${contextPath}/onedayDetail.odc?code=${onedaybean.code}"> ${onedaybean.classname}</a>
										</h4>
										<div class="list_bottom">
											<p id="list_price">
												<i class="fas fa-won-sign"></i>&nbsp;
												<fmt:formatNumber pattern="###,###" value="${onedaybean.oneprice}" />
											</p>
											<p class="list_person">최대 ${onedaybean.person}명</p>
										</div>
									</figcaption>
								</figure>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
			</div>
	</section>
	<!-- #works -->


</body>
<script>
	window.kakaoAsyncInit = function() {
		Kakao.Channel.createChatButton({
			container : '#kakao-talk-channel-chat-button',
		});
	};

	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id))
			return;
		js = d.createElement(s);
		js.id = id;
		js.src = 'https://developers.kakao.com/sdk/js/kakao.channel.min.js';
		fjs.parentNode.insertBefore(js, fjs);
	})(document, 'script', 'kakao-js-sdk');
</script>
</html>