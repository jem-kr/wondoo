<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>상품 및 주문 정보</title>
	<script type="text/javascript" src="${contextPath}/js/prOrder.js"></script>
	<link rel="stylesheet" href="${contextPath}/css/prOrder.css">
</head>
<body onload="today();">
	<section id="contact-section">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block">
						<div class="top">
							<h2 class="subtitle subtitle_css wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.3s">주문 상세 내역</h2>
							<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.6s">${customer.cust_Name}님의 주문 상세 내역을 확인하세요!</p>
							
						</div>
						<%-- =========================
									상단 부분 						
						==============================
						--%>
						<section class="wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.8s">
						<div class="col-md-12 subtitle_css ">
							<div class="sidebar payment_css" >
								<h3 class="widget-head">
									상품 정보
								</h3>
								<div class="author widget col-md-12" id="author_widget">
									<div class="author-body text-center col-md-4">
										<div class="author-bio " id="author_css">
											<img alt="image" src="./upload/${product_bean.pro_pic}" width="300px" height="180px">
										</div>
									</div>
									<div class="author-body text-center col-md-8">
										<div class="author-bio " id="author_pont_css">
											<p>${product_bean.pro_name }</p>
										</div>
											<p>고객님께서 주문하신 상품 내역입니다!</p>
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
									주문 정보
								</h3>
								<%-- ========================== Form 양식 시작 부분 ====================================--%>
									<div id="form_css" class="categories widget categories_css">
										<ul>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														받으실 분
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_totalprice" name="fake_totalprice"
													value="${customer.cust_Name}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														우편번호
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_orders_zipcode" name="fake_orders_zipcode"
														value="${bean.orders_zipcode}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name ">
														주소
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_orders_adr01" name="fake_orders_adr01"
														value="${bean.orders_adr01}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														상세주소
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_orders_adr02" name="fake_orders_adr02"
													value="${bean.orders_adr02}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														요청사항
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_orders_request" name="fake_orders_request"
													value="${bean.orders_request}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														결제일시
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_orders_realtime" name="fake_orders_realtime"
													value="${bean.orders_realtime}">
												</div>
											</li>
											<li>
												<div class="form-group payment_input">
													<div class="column_name">
														결제금액
													</div>
													<input type="text" class="input_data form-control" disabled="disabled" id="fake_orders_total_amount" name="fake_orders_total_amount"
													value="${bean.orders_amount}">
												</div>
											</li>
										</ul>
									</div>
									<hr>
									<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
									data-wow-delay="1.2s">※ 판매자가 상품 준비 단계인 경우 취소가 불가능합니다.</p>
									<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
									data-wow-delay="1.2s">※ 판매자가 24시간 이내에 주문 내역을 확인하여 상품 준비를 합니다.</p>
									<div class="detail_css">
										<button id="btn_detail" class="btn-send" onclick="history.back();"> 목록 </button>
										
										<!-- input 태그에 시퀀스 담아 놓기  -->
										<input type="hidden" id="orders_seq" name="orders_seq" value="${bean.orders_seq}">
										<button id="btn_detail" class="btn-send" data-toggle="modal" data-target="#myModal"> 결제 취소 </button>
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
							style="font-size: 13px" onclick="prOrderCancel();">예</button>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px">아니오</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>