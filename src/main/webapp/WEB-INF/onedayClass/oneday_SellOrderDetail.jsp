<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="./../common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>원데이 클래스 사업자용 결제 상세</title>
	<script type="text/javascript" src="${contextPath}/js/onedayClass.js"></script>
	<link rel="stylesheet" href="${contextPath}/css/onedayClass.css">
</head>
<body onload="sell_Orderdetail();">
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
								data-wow-delay="0.3s">원데이 클래스 수업 세부 현황</h2>
							<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.6s">${requestScope.bookdate_after}&nbsp;&nbsp;${requestScope.code}에 대한 수업 세부 현황입니다!</p>
							<span class="subtitle-des wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.1s"
							id="search_btn" data-toggle="tooltip" title="클릭하세요!" onclick="search();">
								<i class="fas fa-search"></i> 검색
							</span>
						</div>
						
						<%-- [검색 모드] 
					   		==== 시작 ==== 
					   	--%>	   
					   	<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
				        <form id="contact-form search" method="get" action="${contextPath}/onedaySellOrderdetail.odc" role="form">
				        	<input type="hidden" id="code" name="code" value="${requestScope.code}"><!-- 클래스 코드 -->
				        	<input type="hidden" id="bookdate" name="bookdate" value="${requestScope.bookdate}"><!-- 예약일자 -->
				        	<div id="search" class="search_css">
				               <select class="form-control" name="mode" id="mode" data-toggle="tooltip" title="검색할 조건을 선택하세요!">
				                      <option class="form-control" value="all">전체</option>
				                      <option class="form-control" value="cust_email">회원 이메일</option>
				               </select>
				               <input type="text" class="form-control" placeholder="검색할 내용을 입력하세요" id="keyword" name="keyword">
				               <button type="submit"><i class="fas fa-search"></i></button>
			                </div>
			            </form>
			            <%-- ==== 끝 ==== --%>
						
						
						<%-- =========================
									중간 내용 부분 						
						==============================--%>
						<p id="list_top_css">${requestScope.totalCount}명 신청</p>
						<section class="wow fadeInDown col-md-12" data-wow-duration="500ms" data-wow-delay="0.8s">
							<div class="row ">
	      						<table class="table table-bordered table-hover dt-responsive">
	        
							        <%-- 결제 목록의 header 부분 -------------------------------------------------------%>
							        <thead class="thead_css">
						                <tr>
						                    <th><spring:message code="oneday.bookdate_sell"/></th>
						                    <th><spring:message code="oneday.booktime_sell"/></th>
						                    <th><spring:message code="oneday.class_sell"/></th>
						                    <th><spring:message code="oneday.cust_email_sell"/></th>
						                    <th><spring:message code="oneday.custname_sell"/></th>
						                    <th><spring:message code="oneday.custcontact_sell"/></th>
						                    <th><spring:message code="oneday.realtime_sell"/></th>
						                    <th><spring:message code="oneday.management"/></th>
						                </tr>
							        </thead>
							        
							      	<%-- 결제 목록의 내용 부분 -------------------------------------------------------%>
						            <tbody>
							            <c:forEach var="bean" items="${requestScope.lists}">
							                	<tr>
							                    	<td>${bean.bookdate}</td>
							                    	<td>${bean.booktime}</td>
						                     		<td>${bean.code}</td>
						                     		<td>${bean.cust_email}</td>
						                  			<td>${bean.cust_name}</td>
								                    <td>${bean.cust_contact}</td>
								                    <td>${bean.realtime}</td>
								                    <td>
								                    	<input type="hidden" id="onedayorder_seq" value="${bean.onedayorder_seq}">
								                    	<p class="management_css" data-toggle="modal" data-target="#myModal">
								                    		수강 취소
								                    	</p>
								                    </td>
							                	</tr>
							            </c:forEach>  
							            
						            </tbody>
						            
							       
							         
							      </table>
							      <hr>
									<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
									data-wow-delay="1.2s">※ 사업자는 당일 수업 취소가 가능합니다.
										<br>&nbsp;&nbsp;&nbsp;(단, 날짜가 경과된 수업은 취소가 불가능합니다.)
									</p>
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
							<i class="fas fa-exclamation-circle"></i>
						</h4>
					</div>
					<div class="modal-body">
						<p id="modal-body" style="font-size: 13px">
							회원이 수업 참여를 할 수 없습니다. 
							<br>정말 취소 하시겠습니까?
						</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px" onclick="onedaySellCancle();">예</button>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px">아니오</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	 
</body>
</html>