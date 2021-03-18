<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 상세보기</title>

    <script type="text/javascript" src="${contextPath}/js/product.js"></script>
    <link rel="stylesheet" href="${contextPath}/css/onedayClass.css">
    <style type="text/css">
    .pro_picture{
    	max-width: 648px;
    	max-height: 438px;
    }
    .btn-delete{
    width: 100% !important;
    margin-bottom:20px;
    color: #fff !important;
    outline: none !important;
    background: red !important;
    border-radius: 0px;
    border: red;
    height: 30px;
    display: flex;
    justify-content: center;
    text-align: center;	
    }
    </style>
</head>
<body class="top" onload="detail_loading();">
	 <section id="blog-full-width">
        <div class="container">
        <c:if test="${bean.pro_category == 'c' }">
            <h2 class="subtitle wow fadeInDown" data-wow-duration="500ms" data-wow-delay=".3s">커피 상세보기</h2>
            </c:if>
        	<c:if test="${bean.pro_category == 'p' }">
            <h2 class="subtitle wow fadeInDown" data-wow-duration="500ms" data-wow-delay=".3s">상품 상세보기</h2>
            </c:if>
            <div class="row">
                <div class="col-md-8">
                    <article class="wow fadeInDown animated" data-wow-delay=".3s" data-wow-duration="500ms" style="visibility: visible; animation-duration: 500ms; animation-delay: 0.3s; animation-name: fadeInDown;">
                    	<h3 class="widget-head">${bean.pro_name}</h3>
                        <div class="blog-post-image">
                            <div id="myCarousel" class="carousel slide carousel-fade" data-ride="carousel">

                              
                                <!-- Wrapper for slides -->
                                <div class="carousel-inner carousel-zoom carousel-fade">
                                        <div class="item active">
                                            <img class="img-responsive pro_picture" src="./upload/${bean.pro_pic}" alt="">
                                        </div>
                                    <!-- Carousel nav -->
                                    
                                  </div>
                              </div>
                            </div>
                            <c:if test="${not empty bean.pro_detail}">
	                            <div class="blog-content">
	                           		 <div class="blog-meta">
	                           		 	<i class="fas fa-bullhorn"></i>&nbsp;&nbsp;
	                                 	 <div id="content_css" class="categories widget">
	                                 	 	<p id="frist_content">저희 상품을 <br>소개 합니다!</p>
	                            			<p id="second_content">${bean.pro_detail}</p>
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
                                    <c:if test="${not empty bean.pro_sell_email}">
                                    	<p><i class="fas fa-user"></i> 판매자 소개</p>
                                    	<p>상호명 : ${seller.sell_Name}</p>
                                    </c:if>
                                    <c:if test="${empty bean.pro_sell_email}">
                                    	<p>원두해요는 사용자에게<br> 다양한 상품을 소개합니다.</p>
                                    </c:if>
                                    <p><i class="fas fa-map-marked-alt"></i>&nbsp;주소 <br>${seller.sell_Zipcode}&nbsp;${seller.sell_ADR01}&nbsp;${seller.sell_ADR02}</p>
                                </div>
                            </div>
                        </div>
                    	<c:if test="${bean.pro_sell_email eq sessionScope.loginfo_seller.sell_Email}">
                        	<div class="delete_detail">
                        		<button class="btn-delete" onclick="del_check();" >상품 삭제 하기</button>
                        	</div>
                        	</c:if> 
                    	<%-- ========================== Form 양식 시작 부분 ====================================--%>
                    	<c:set var="contextPath" value="<%=contextPath%>" scope="application" />
                        <form method="get" action="${contextPath}/caInsert.ca">
                        	<input type="hidden" id="products_seq" name="products_seq" value="${bean.products_seq}">
                            <div id="form_css"  class="categories widget">
                                <h3 id="class_css" class="widget-head">상품정보</h3>
                                <ul>
                                    <li>
                                        <div class="form-group">
                                        	<div class="column_name">
                                        		상품명
                                        	</div>
                                        	<input type="hidden" class="input_data form-control"  disabled="disabled" id="pro_name" name="pro_name" value="${bean.pro_name }">
                                            <span>${bean.pro_name }</span>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="form-group">
                                        	<div class="column_name">
                                        		원산지
                                        	</div>
                                        	<input type="hidden" class="input_data form-control"  disabled="disabled" id="pro_origin" name="pro_origin" value="${bean.pro_origin }">
                                            <span>${bean.pro_origin }</span>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="form-group">
                                        	<div class="column_name">
                                            	가격
                                            </div>
                                            <input type="hidden" disabled="disabled" class="input_data form-control" id="pro_price" name="pro_price" value="${bean.pro_price}">
                                        	<span>${bean.pro_price }원 / 개</span>
                                        </div>
                                    </li>
                                    <li>
                                    	<div class="column_name">
                                    		수량선택
                                    	</div>
                                        <div id="qty_css" class="form-group">
                                            <input type="hidden" disabled="disabled" class="input_data form-control" value="${bean.pro_stock}" id="pro_stock" name="pro_stock">
                                            <input type="text" disabled="disabled" class="input_data form-control" value="1" id="fake_qty" name="fake_qty">
                                            <input type="hidden" class="input_data form-control" id="qty" name="qty" value="1">
                                           	<button id="plusbtn" type="button" class="btn-send pmbtn" data-toggle="modal" data-target="#myModal"><i class="fas fa-plus"></i></button>
                                           	<button id="minusbtn" type="button" class="btn-send pmbtn"><i class="fas fa-minus"></i></button>
                                            
                                        </div>
                                    </li>
                                    <li>
                                        <div class="form-group">
                                        	<div class="column_name">
                                            	총 금액
                                            </div>
                                            <input type="text" disabled="disabled" class="input_data form-control" value="${bean.pro_price}" id="fake_totalprice" name="fake_totalprice">
                                            <input type="hidden" class="input_data form-control" value="${bean.pro_price}" id="totalprice" name="totalprice">
                                        </div>
                                    </li>
                                </ul>
                               
                            </div>
                        	
                            <div class="submit_detail">
                                <input type="submit" id="contact-submit" class="btn-send" value="상품 구매 하기">
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