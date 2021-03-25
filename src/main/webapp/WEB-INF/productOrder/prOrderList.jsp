<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 결제 내역</title>
	<script type="text/javascript" src="${contextPath}/js/prOrder.js"></script>
	<link rel="stylesheet" href="${contextPath}/css/prOrder.css">
</head>
<body>
	<section id="contact-section">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block">
						<%-- =========================
									상단 제목 부분 						
						==============================--%>
						<div class="top">
							<h2 class="subtitle subtitle_css wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.3s">상품 결제 내역</h2>
							<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.6s">${sessionScope.loginfo.cust_Name}님의 상품 결제 내역 입니다!</p>
						</div>

						<%-- =========================
									결제된 상품 부분 						
						==============================--%>
						<section class="wow fadeInDown col-md-12" data-wow-duration="500ms" data-wow-delay="0.8s">
							<div class="row ">
	      						<table class="table table-bordered table-hover dt-responsive">
	        
							        <%-- 결제 목록의 header 부분 -------------------------------------------------------%>
							        <thead class="thead_css">
						                <tr>
						                    <th>결제일자</th>
						                    <th colspan="2">상품정보</th>
						                    <th>구매수량</th>
						                    <th>결제금액</th>
						                </tr>
							        </thead>
							        
							      	<%-- 결제 목록의 내용 부분 -------------------------------------------------------%>
						            <tbody>
							            <c:forEach var="bean" items="${requestScope.lists}">
							                	<tr>
							                    	<td>
								                    	<a href="${contextPath}/prOrderDetail.po?orders_seq=${bean.orders_seq}">
								                    		${bean.orders_realtime}
								                    	</a>
							                    	</td>
							                    	
							                        <td>
						                     			<img alt="image" src="./upload/${bean.pro_pic}" width="150px" height="100px"> 
						                     		</td>
						                  			 <td>
						                  				${bean.pro_name }
						                  			</td>
								                    <td>${bean.orders_qty}</td>
								                    <td>${bean.orders_amount}</td>
							                	</tr>
							            </c:forEach>  
						            </tbody>
							      </table>
							      
							      <%-- 결제 목록의 하단 부분 -------------------------------------------------------%>
						           <div align="center">
										<footer>${requestScope.pagingHtml}</footer>
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