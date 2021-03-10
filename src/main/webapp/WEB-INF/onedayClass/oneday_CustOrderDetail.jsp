<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>원데이 클래스 결제 정보</title>
	<script type="text/javascript" src="${contextPath}/js/onedayClass.js"></script>
	<link rel="stylesheet" href="${contextPath}/css/onedayClass.css">
</head>
<body onload="today();">
	<section id="contact-section">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block">
						<div class="top">
							<h2 class="subtitle subtitle_css wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.3s">원데이 클래스 수업 상세 내역</h2>
							<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.6s">${customer.cust_Name}님의 수업 상세 내역을 확인하세요!</p>
							
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
											<img alt="image" src="./upload/${oneday_bean.main_image}" width="300px" height="180px">
										</div>
									</div>
									<div class="author-body text-center col-md-8">
										<div class="author-bio " id="author_pont_css">
											<p>${oneday_bean.classname}</p>
										</div>
										<p id="p_css"><i class="fas fa-map-marked-alt"></i>&nbsp;&nbsp;${oneday_bean.zipcode}&nbsp;${oneday_bean.address1}&nbsp;${oneday_bean.address2}</p>
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
									<div id="form_css" class="categories widget categories_css">
										<ul>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														예약자명
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_totalprice" name="fake_totalprice"
													value="${customer.cust_Name}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														<spring:message code="oneday.bookdate" />
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_bookdate" name="fake_bookdate"
														value="${bean.bookdate}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<!-- 파라미터 이름은 수정 할 것  -->
													<div class="column_name ">
														<spring:message code="oneday.time" />
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_booktime" name="fake_booktime"
														value="${bean.booktime}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														신청인원
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="person_fk" name="person_fk"
													value="${bean.person}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														결제일자
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_totalprice" name="fake_totalprice"
													value="${bean.realtime}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														결제금액
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_totalprice" name="fake_totalprice"
													value="${bean.totalprice}">
												</div>
											</li>
										</ul>
									</div>
									<hr>
									<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
									data-wow-delay="1.2s">※ 당일 예약인 경우 수업 1시간전에만 취소가 가능합니다.</p>
									<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
									data-wow-delay="1.2s">※ 날짜가 경과된 예약은 취소가 불가능합니다.</p>
									<div class="detail_css">
										<button id="btn_detail" class="btn-send" onclick="history.back();"> 목록 </button>
										
										<!-- input 태그에 시퀀스 담아 놓기  -->
										<input type="hidden" id="onedayorder_seq" name="onedayorder_seq" value="${bean.onedayorder_seq}">
										<button id="btn_detail" class="btn-send" data-toggle="modal" data-target="#myModal"> 수업 취소 </button>
									</div>
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
							<i class="fas fa-exclamation-circle"></i>
						</h4>
					</div>
					<div class="modal-body">
						<p id="modal-body" style="font-size: 13px">
							정말 취소 하시겠습니까?
						</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px" onclick="onedayCancle();">예</button>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px">아니오</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>