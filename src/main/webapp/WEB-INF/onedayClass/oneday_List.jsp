<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="./../common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>원데이 클래스 목록</title>
<script type="text/javascript" src="${contextPath}/js/onedayClass.js"></script>
<link rel="stylesheet" href="${contextPath}/css/onedayClass.css">
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
					data-wow-duration="500ms" data-wow-delay="0ms">ONEDAY CLASS</h2>
				
				<c:if test="${not empty sessionScope.loginfo_seller || sessionScope.loginfo.cust_Email == 'admin@gmail.com'}">
					<hr>
					<p class="subtitle-des wow fadeInLeft animated" data-wow-duration="500ms"
					data-wow-delay="0ms">
						※ 개설한 원데이 클래스의 수업 날짜가 경과된 건은 자동으로 삭제됩니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;자동 삭제 처리는 일주일 정도 소요됩니다.
					</p>
				</c:if>
				<span class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
					data-wow-delay="0.1s" id="search_btn" data-toggle="tooltip"
					title="클릭하세요!" onclick="search();"> <i class="fas fa-search"></i>
					검색
				</span> <br>
			</div>


			<%-- [검색 모드] ==== 시작 ==== --%>
			<form id="contact-form search" method="get"
				action="${contextPath}/onedayList.odc" role="form">
				<div id="search">
					<select class="form-control" name="mode" id="mode"
						data-toggle="tooltip" title="검색할 조건을 선택하세요!">
						<option class="form-control" value="all">전체</option>
						<c:if test="${not empty sessionScope.loginfo_seller}">
							<option class="form-control" value="sell_email">이메일</option>
						</c:if>
						<option class="form-control" value="address1">지역</option>
						<option class="form-control" value="classname">클래스명</option>
					</select> <input type="text" class="form-control"
						placeholder="검색할 내용을 입력하세요" id="keyword" name="keyword">
					<button type="submit">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</form>
			<%-- ==== 끝 ==== --%>
			<p id="list_top">${requestScope.totalCount}개의수업</p>
			<c:forEach var="bean" items="${requestScope.lists}" varStatus="status">
				<input id="status" type="hidden" value="${status.count}">
				<c:if test="${status.count % 3 == 0}"> <!-- 현재 반복 순서가 3의 배수 인 경우  -->
					<div class="row">
						<div class="col-md-4">
							<!-- 검색 모드에서 활용 [시작]-->
							<input type="hidden" value="${bean.address1}">
							<!-- 주소 지역 -->
							<input type="hidden" value="${bean.sell_email}">
							<!-- 사업자 이메일 -->
	
							<!-- 검색 모드에서 활용 [끝] -->
							<input type="hidden" id="code" value="${bean.code}">
							<!-- 코드  -->
							<input type="hidden" id="oneday_seq" value="${bean.oneday_seq}">
							<!--  시퀀스 -->
							<figure class="wow fadeInLeft animated portfolio-item" data-wow-duration="500ms" data-wow-delay="0ms">
								<div class="img-wrapper">
									<img src="./upload/${bean.main_image}" class="img-responsive" alt="image">
									<div class="overlay">
										<div class="buttons">
											<a href="${contextPath}/onedayDetail.odc?code=${bean.code}">자세히 보기</a>
											<c:if test="${bean.sell_email eq sessionScope.loginfo_seller.sell_Email}">
												<a href="${contextPath}/onedayUpdate.odc?code=${bean.code}">수정</a>
												<a href="${contextPath}/onedayDelete.odc?code=${bean.code}">삭제</a>
											</c:if>
										</div>
									</div>
								</div>
								<figcaption>
									<h4>
										<a href="#detail.jsp">${bean.classname}</a>
									</h4>
									<div class="list_bottom">
										<p id="list_price">
											<i class="fas fa-won-sign"></i>&nbsp;
											<fmt:formatNumber pattern="###,###" value="${bean.oneprice}" />
										</p>
										<p class="list_person">최대 ${bean.person}명</p>
									</div>
								</figcaption>
							</figure>
						</div>
					</div>
				</c:if>
				<c:if test="${status.count % 3 != 0}"> <!-- 현재 반복 순서가 3의 배수가 아닌 인 경우  -->
					<div class="col">
						<div class="col-md-4">
							<!-- 검색 모드에서 활용 [시작]-->
							<input type="hidden" value="${bean.address1}">
							<!-- 주소 지역 -->
							<input type="hidden" value="${bean.sell_email}">
							<!-- 사업자 이메일 -->
	
							<!-- 검색 모드에서 활용 [끝] -->
							<input type="hidden" id="code" value="${bean.code}">
							<!-- 코드  -->
							<input type="hidden" id="oneday_seq" value="${bean.oneday_seq}">
							<!--  시퀀스 -->
							<figure class="wow fadeInLeft animated portfolio-item" data-wow-duration="500ms" data-wow-delay="0ms">
								<div class="img-wrapper">
									<img src="./upload/${bean.main_image}" class="img-responsive" alt="image">
									<div class="overlay">
										<div class="buttons">
											<a href="${contextPath}/onedayDetail.odc?code=${bean.code}">자세히 보기</a>
											<c:if test="${bean.sell_email eq sessionScope.loginfo_seller.sell_Email}">
												<a href="${contextPath}/onedayUpdate.odc?code=${bean.code}">수정</a>
												<a href="${contextPath}/onedayDelete.odc?code=${bean.code}">삭제</a>
											</c:if>
										</div>
									</div>
								</div>
								<figcaption>
									<h4>
										<a href="#detail.jsp">${bean.classname}</a>
									</h4>
									<div class="list_bottom">
										<p id="list_price">
											<i class="fas fa-won-sign"></i>&nbsp;
											<fmt:formatNumber pattern="###,###" value="${bean.oneprice}" />
										</p>
										<p class="list_person">최대 ${bean.person}명</p>
									</div>
								</figcaption>
							</figure>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<div align="center">
			<footer>${requestScope.pagingHtml}</footer>
		</div>
	</section>


	<%-- <!-- ------------------------------------- [모달 section]--------------------------------------- -->
	<div class="container">
		Modal
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 id="modal-title" class="modal-title" style="font-size: 35px">
							<i class="fas fa-exclamation-circle"></i>
						</h4>
					</div>
					<div class="modal-body">
						<p id="modal-body" style="font-size: 13px">정말 삭제 하시겠습니까?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px">예</button>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px">아니오</button>
					</div>
				</div>
			</div>
		</div>
	</div> --%>
</body>
</html>
</html>