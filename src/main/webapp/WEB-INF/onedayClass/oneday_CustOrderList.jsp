<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="./../common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>원데이 클래스 결제 내역</title>
	<script type="text/javascript" src="${contextPath}/js/onedayClass.js"></script>
	<link rel="stylesheet" href="${contextPath}/css/onedayClass.css">
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
								data-wow-delay="0.3s">원데이 클래스 수업신청 내역</h2>
							<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.6s">${sessionScope.loginfo.cust_Name}님의 수업신청 내역 입니다!</p>
							<span class="subtitle-des wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.1s"
							id="search_btn" data-toggle="tooltip" title="클릭하세요!" onclick="search();">
								<i class="fas fa-search"></i> 검색
							</span>
						</div>
						
						<%-- [검색 모드] 
					   		==== 시작 ==== 
					   	--%>	   
					   	<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
				        <form id="contact-form search" method="get" action="${contextPath}/onedayCustOrderList.odc" role="form">
				        	<input type="hidden" id="cust_email" name="cust_email" value="${sessionScope.loginfo.cust_Email}">
				        	<div id="search" class="search_css">
				               <select class="form-control" name="mode" id="mode" data-toggle="tooltip" title="검색할 조건을 선택하세요!">
				                      <option class="form-control" value="all">전체</option>
				                      <option class="form-control" value="bookdate">예약일자</option>
				               </select>
				               <input type="text" class="form-control" placeholder="검색할 내용을 입력하세요" id="keyword" name="keyword">
				               <button type="submit"><i class="fas fa-search"></i></button>
			                </div>
			            </form>
			            <%-- ==== 끝 ==== --%>
						
						
						<%-- =========================
									중간 내용 부분 						
						==============================--%>
						<p id="list_top_css">${requestScope.totalCount}개의 수업</p>
						<section class="wow fadeInDown col-md-12" data-wow-duration="500ms" data-wow-delay="0.8s">
							<div class="row ">
	      						<table class="table table-bordered table-hover dt-responsive">
	        
							        <%-- 결제 목록의 header 부분 -------------------------------------------------------%>
							        <thead class="thead_css">
						                <tr>
						                	
						                    <th><spring:message code="oneday.bookdate"/></th>
						                    <th><spring:message code="oneday.time"/></th>
						                    <th colspan="2"><spring:message code="oneday.classinfo"/></th>
						                    <th><spring:message code="oneday.person"/></th>
						                    <th><spring:message code="oneday.totalprice"/></th>
						                </tr>
							        </thead>
							        
							      	<%-- 결제 목록의 내용 부분 -------------------------------------------------------%>
						            <tbody>
							            <c:forEach var="bean" items="${requestScope.lists}">
							                	<tr>
							                    	<td>${bean.bookdate}</td>
							                    	<td>${bean.booktime}</td>
						                     		<td>
						                     			<img alt="image" src="${contextPath}/upload/${bean.main_image}" width="150" height="100"> 
						                     		</td>
						                  			<td>
						                  				<a href="${contextPath}/onedayCustOrderDetail.odc?onedayorder_seq=${bean.onedayorder_seq}">
						                  					${bean.classname}
						                  				</a>
						                  			</td>
								                    <td>${bean.person}</td>
								                    <td>${bean.totalprice}</td>
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