<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>원데이 클래스 상세보기</title>

    <script type="text/javascript" src="${contextPath}/js/onedayClass.js"></script>
    <link rel="stylesheet" href="${contextPath}/css/onedayClass.css">
    
</head>
<body class="top" onload="detail_loading();">
	 <section id="blog-full-width">
        <div class="container">
            <h2 class="subtitle wow fadeInDown" data-wow-duration="500ms" data-wow-delay=".3s">ONEDAY CLASS</h2>
            <div class="row">
                <div class="col-md-8">
                    <article class="wow fadeInDown animated" data-wow-delay=".3s" data-wow-duration="500ms" style="visibility: visible; animation-duration: 500ms; animation-delay: 0.3s; animation-name: fadeInDown;">
                    	<h3 class="widget-head">${bean.classname}</h3>
                        <div class="blog-post-image">
                            <div id="myCarousel" class="carousel slide carousel-fade" data-ride="carousel">

                                <!-- Indicators -->
                                <ol class="carousel-indicators">
                                  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                                  <li data-target="#myCarousel" data-slide-to="1"></li>
                                  <li data-target="#myCarousel" data-slide-to="2"></li>
                                </ol>
                              
                                <!-- Wrapper for slides -->
                                <div class="carousel-inner carousel-zoom carousel-fade">
                                        <div class="item active">
                                            <img class="img-responsive" src="./upload/${bean.main_image}" alt="">
                                        </div>
                                       <div class="item">
                                            <img class="img-responsive" src="./upload/${bean.detail_image1}" alt="">
                                        </div>
                                      <div class="item">
                                            <img class="img-responsive" src="./upload/${bean.detail_image2}" alt="">
                                      </div>
                                    <!-- Carousel nav -->
                                    
                                  </div>
                              </div>
                            </div>
                            <c:if test="${not empty bean.content}">
	                            <div class="blog-content">
	                           		 <div class="blog-meta">
	                           		 	<i class="fas fa-bullhorn"></i>&nbsp;&nbsp;
	                                 	 <div id="content_css" class="categories widget">
	                                 	 	<p id="frist_content">저희 원데이 클래스를 <br>소개 합니다!</p>
	                            			<p id="second_content">${bean.content}</p>
	                        			</div>
	                                </div>
	                            </div>
                            </c:if>
                    </article>
                </div>
                <div class="col-md-4">
                    <div class="sidebar">
                    	<h3 class="widget-head"></h3>
                    	<div class="author widget">
                            <div class="author-body text-center">
                                <div class="author-img">
                                    <img src="${contextPath}/images/logo2.png">
                                </div>
                                <div class="author-bio">
                                    <h3 id="sellname_css">${seller.sell_Name}</h3>
                                    <c:if test="${not empty bean.instructor}">
                                    	<p><i class="fas fa-user"></i> 강사 소개</p>
                                    	<p><spring:message code="oneday.instructor"/> : ${bean.instructor}</p>
                                    </c:if>
                                    <c:if test="${empty bean.instructor}">
                                    	<p>DOPE COFFEE 는 사용자에게<br> 다양한 콘텐츠를 전달합니다.</p>
                                    </c:if>
                                    <p><i class="fas fa-map-marked-alt"></i>&nbsp;주소 <br>${bean.zipcode}&nbsp;${bean.address1}&nbsp;${bean.address2}</p>
                                </div>
                            </div>
                        </div>
                    	
                    	<%-- ========================== Form 양식 시작 부분 ====================================--%>
                    	<c:set var="contextPath" value="<%=contextPath%>" scope="application" />
                        <form method="get" action="${contextPath}/onedayPayment.odc">
                        	<input type="hidden" id="" name="code" value="${bean.code}">
                            <div id="form_css"  class="categories widget">
                                <h3 id="class_css" class="widget-head"><spring:message code="oneday.Detail_title"/></h3>
                                <ul>
                                    <li>
                                        <div class="form-group">
                                        	<div class="column_name">
                                        		<spring:message code="oneday.bookdate"/>
                                        	</div>
                                        	<input type="hidden" class="input_data form-control"  disabled="disabled" id="enddate" name="enddate" value="${bean.enddate}">
                                            <input type="text" class="input_data form-control datepicker"  placeholder="예약 일자" id="bookdate" name="bookdate" onclick="booking_date();" onmouseleave="myBookdateCheck();">
                                            <span class="valid_check" id="err_bookdate"></span>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="form-group">
                                            <!-- 파라미터 이름은 수정 할 것  -->
                                            <div class="column_name">
                                            	<spring:message code="oneday.time"/>
                                            </div>
                                            <select class="form-control" name="booktime" id="booktime" onclick="myBooktimeCheck();">
                                                <option class="form-control" value="-">이용 시간</option>
                                                <option class="form-control" value="${requestScope.opentime}">${requestScope.opentime}</option>
                                                <c:if test="${requestScope.add_opentime1 ne 'null ~ null'}">
                                                	<option class="form-control" value="${requestScope.add_opentime1}">${requestScope.add_opentime1}</option>
                                                </c:if>
                                                <c:if test="${requestScope.add_opentime2 ne 'null ~ null'}">
                                                	<option class="form-control" value="${requestScope.add_opentime2}">${requestScope.add_opentime2}</>
                                                </c:if>
                                            </select>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="form-group">
                                        	<div class="column_name">
                                            	<spring:message code="oneday.oneprice"/>
                                            </div>
                                            <input type="text" disabled="disabled" class="input_data form-control" id="oneprice" name="oneprice" value="${bean.oneprice}">
                                        </div>
                                    </li>
                                    <li>
                                    	<div class="column_name">
                                    		<spring:message code="oneday.person"/>
                                    	</div>
                                        <div id="person_css" class="form-group">
                                            <input type="hidden" disabled="disabled" class="input_data form-control" value="${bean.person}" id="max_person" name="max_person">
                                            <input type="text" disabled="disabled" class="input_data form-control" value="1" id="fake_person" name="fake_person">
                                            <input type="hidden" class="input_data form-control" id="person" name="person" value="1">
                                           	<button id="plusbtn" type="button" class="btn-send pmbtn" data-toggle="modal" data-target="#myModal"><i class="fas fa-plus"></i></button>
                                           	<button id="minusbtn" type="button" class="btn-send pmbtn"><i class="fas fa-minus"></i></button>
                                            
                                        </div>
                                    </li>
                                    <li>
                                        <div class="form-group">
                                        	<div class="column_name">
                                            	<spring:message code="oneday.totalprice"/>
                                            </div>
                                            <input type="text" disabled="disabled" class="input_data form-control" value="${bean.oneprice}" id="fake_totalprice" name="fake_totalprice">
                                            <input type="hidden" class="input_data form-control" value="${bean.oneprice}" id="totalprice" name="totalprice">
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        
                            <div class="submit_detail">
                                <input type="submit" id="contact-submit" class="btn-send" value="수업 신청하기" onclick="return payment_check();">
                            </div>
                        </form>
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
	          <h4 id="modal-title" class="modal-title" style="font-size: 35px"></h4>
	        </div>
	        <div class="modal-body">
	          <p id="modal-body" style="font-size: 13px"></p>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal" style="font-size: 13px">닫기</button>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>      
</body>
</html>