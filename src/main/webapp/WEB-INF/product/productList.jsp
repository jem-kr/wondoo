<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="./../common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<script type="text/javascript" src="${contextPath}/js/product.js"></script>
<link rel="stylesheet" href="${contextPath}/css/product.css">
</head>
<body onload="list_loading();" class="top">
	<!-- 
        ================================================== 
            사진 Section Start
        ================================================== -->
	<section class="works service-page">

		<div class="container">
			<div id="top">
				<h2 class="wow fadeInLeft animated portfolio-item"
					data-wow-duration="500ms" data-wow-delay="0ms">PRODUCT</h2>
				<span class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
					data-wow-delay="0.1s" id="search_btn" data-toggle="tooltip"
					title="클릭하세요!" onclick="search();"> <i class="fas fa-search"></i>
					검색
				</span> <br>
			</div>


			<%-- [검색 모드] ==== 시작 ==== --%>
			<form id="contact-form search" method="get"
				action="${contextPath}/prList.pr" role="form">
				<div id="search">
					<select class="form-control" name="mode" id="mode"
						data-toggle="tooltip" title="검색할 조건을 선택하세요!">
						<option class="form-control" value="all">전체</option>
						<option class="form-control" value="pro_type">타입</option>
						<option class="form-control" value="pro_name">이름</option>
					</select> <input type="text" class="form-control"
						placeholder="타입은 컵, 용품, 기타 중 입력하세요" id="keyword" name="keyword">
					<button type="submit">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</form>
			<%-- ==== 끝 ==== --%>
			<p id="list_top">${requestScope.totalCount}개의 상품</p>
			
			<c:forEach var="bean" items="${requestScope.lists}" varStatus="status">
				<input id="status" type="hidden" value="${status.count}">
				<div class="col">
						<div class="col-md-4" >
							<!-- 검색 모드에서 활용 [시작]-->
							<input type="hidden" value="${bean.pro_type}">
							<input type="hidden" value="${bean.pro_name}">
							<!-- 검색 모드에서 활용 [끝] -->
							<input type="hidden" id="products_seq" value="${bean.products_seq}">
							<figure class="wow fadeInLeft animated portfolio-item" data-wow-duration="500ms" data-wow-delay="0ms">
								<div class="img-wrapper">
									<img src="./upload/${bean.pro_pic}" class="img-responsive pro_picture" alt="image">
									<div class="overlay">
										<div class="buttons">
											<a href="${contextPath}/prDetail.pr?products_seq=${bean.products_seq}">자세히 보기</a>
											<c:if test="${bean.pro_sell_email eq sessionScope.loginfo_seller.sell_Email}">
												<a href="${contextPath}/prUpdate.pr?products_seq=${bean.products_seq}">수정</a>
											</c:if>
										</div>
									</div>
								</div>
								<figcaption style="height:96px; display:inline;">
									<h5>
										<a href="#detail.jsp" style="overflow: hidden; font-weight: bold;">&nbsp;${bean.pro_name}</a>
									</h5>
									<div class="list_bottom">
										<p id="list_price">
											<i class="fas fa-won-sign"></i>&nbsp;
											<fmt:formatNumber pattern="###,###" value="${bean.pro_price}" />
										</p>
									</div>
								</figcaption>
							</figure>
						</div>
					</div>
			</c:forEach>
			</div>
		<div align="center">
			<footer>${requestScope.pagingHtml}</footer>
		</div>
	</section>
</body>
</html>