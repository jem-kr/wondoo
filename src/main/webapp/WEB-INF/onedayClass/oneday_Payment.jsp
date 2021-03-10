<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>원데이 클래스 예약 정보</title>
	<script type="text/javascript" src="${contextPath}/js/onedayClass.js"></script>
	<link rel="stylesheet" href="${contextPath}/css/onedayClass.css">
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body onload="today();">
	<section id="contact-section">
		<%-- =======================================
			PG사 결제에 필요한 파라미터 [시작]
		===============================================--%>
		<input type="hidden" id="cust_Name" name="cust_Name" value="${customer.cust_Name}">
		<input type="hidden" id="cust_Contact" name="cust_Contact" value="${customer.cust_Contact}">
		<%-- =======================================
			PG사 결제에 필요한 파라미터 [끝]
		===============================================--%>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block">
						<div class="top">
							<h2 class="subtitle subtitle_css wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.3s">원데이 클래스 수업 신청</h2>
						
							<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.6s">${customer.cust_Name}님의 수업 신청 내역을 확인하세요!</p>
						</div>
						<%-- =========================
									상단 부분 						
						==============================
						--%>
						<section class="wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.8s">
						<div class="col-md-12 subtitle_css ">
							<div class="sidebar payment_css" >
								<h3 class="widget-head">
									수업 정보
								</h3>
								<div class="author widget col-md-12" id="author_widget">
									<div class="author-body text-center col-md-4">
										<div class="author-bio " id="author_css">
											<img alt="image" src="./upload/${onedayclass.main_image}" width="300px" height="180px">
										</div>
									</div>
									<div class="author-body text-center col-md-8">
										<div class="author-bio " id="author_pont_css">
											<p>${onedayclass.classname}</p>
										</div>
										<p id="p_css"><i class="fas fa-map-marked-alt"></i>&nbsp;&nbsp;${onedayclass.zipcode}&nbsp;${onedayclass.address1}&nbsp;${onedayclass.address2}</p>
									</div>
								</div>
							</div>
						</div>
						
						<%-- =========================
									하단 부분 						
						==============================--%>
						
						
						<div class="col-md-12">
							
							<div class="sidebar payment_css">
								<h3 class="widget-head">
									예약 정보
								</h3>
								<%-- ========================== Form 양식 시작 부분 ====================================--%>
								<c:set var="contextPath" value="<%=contextPath%>" scope="application" />
								<form method="post" action="${contextPath}/onedayPayment.odc">
									<input type="hidden" id="code" name="code" value="${onedayclass.code}"><!-- 상품코드 -->
									<input type="hidden" id="cust_email" name="cust_email" value="${sessionScope.loginfo.cust_Email}"><!-- 로그인 정보 -->
									<input type="hidden" id="sell_email" name="sell_email" value="${onedayclass.sell_email}"><!-- 사업자 이메일 정보 -->
									<div id="form_css" class="categories widget categories_css">
										<ul>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														<spring:message code="oneday.bookdate" />
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_bookdate" name="fake_bookdate"
														value="${bookdate}">
													<input type="hidden" class="input_data form-control" id="bookdate" name="bookdate"
														value="${bookdate}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<!-- 파라미터 이름은 수정 할 것  -->
													<div class="column_name ">
														<spring:message code="oneday.time" />
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_booktime" name="fake_booktime"
														value="${booktime}">
													<input type="hidden" class="input_data form-control" id="booktime" name="booktime"
														value="${booktime}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														신청인원
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="person_fk" name="person_fk"
													value="${person}">
													<input type="hidden" class="input_data form-control" id="person" name="person"
													value="${person}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														결제금액
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_totalprice" name="fake_totalprice"
													value="${totalprice}">
													<input type="hidden" class="input_data form-control" id="totalprice" name="totalprice"
													value="${totalprice}">
												</div>
											</li>
										</ul>
									</div>
									<hr>
									<h3 class="widget-head">
										결제 정보
									</h3>
									<div class="final_payment">
										<p>최종 결제 금액</p>
										<p id="price"><i class="fas fa-won-sign"></i>&nbsp;${totalprice}원</p>
									</div>
									<div class="submit_detail">
										<input type="button" id="pay" class="btn-send" value="결제하기" onclick="payment();"> 
									</div>
								</form>
							</div>
						</div>
					</section>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- ------------------------------------- [모달 section]--------------------------------------- -->
	<div class="container">

		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 id="modal-title" class="modal-title" style="font-size: 35px">
						</h4>
					</div>
					<div class="modal-body">
						<p id="modal-body" style="font-size: 13px">
						</p>
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
	</div>

</body>
</html>