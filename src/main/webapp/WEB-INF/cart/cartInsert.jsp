<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
	<title>장바구니</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script type="text/javascript" src="${contextPath}/js/cart.js"></script>
	<!-- Stylesheet CSS -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/css/cart.css" />
</head>
<body>
    <section class="cart-page page fix"><!--Start Cart Area-->
        <div class="container">
            <div class="row">
                
                <div class="col-sm-12">
                    <div>
                        <h2 id="subject" class="subtitle wow fadeInDown" data-wow-duration="500ms"
                            data-wow-delay="0.3s">장바구니</h2>
                        <ul class="subtitle-des wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.6s">
                            <li id="font_step1">01&nbsp;&nbsp;장바구니&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;</li> 
                            <li id="font_step2">02&nbsp;&nbsp;배송지 입력&nbsp;&nbsp;&nbsp;</li> 
                        </ul>
                    </div>
                    <%-- ================================
                    		form 태그 시작 
                    ===================================== --%>
                    <c:set var="contextPath" value="<%=contextPath%>" scope="application" />
                    <form id="contact-form" method="post" action="${contextPath}/orderPayment.or" role="form">
                    <!-- ====================
                  		 STEP1. 장바구니 부분
             		   ====================== -->
                    <div class="step1 table-responsive wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.6s">
                        <table class="table cart-table">
                            <thead class="table-title">
                                <tr>
                                    <th class="produ" colspan="2">상품 정보</th>
                                    <th class="quantity">수량</th>
                                    <th class="unit">상품 금액</th>
                                    <th class="acti">상품 삭제</th>
                                </tr>													
                            </thead>
                            <tbody>
                                <tr class="table-info">
                                    <td class="produ">
                                        <a href="#"><img alt="" src="images/cart-2.jpg"></a>
                                    </td>
                                    <td class="namedes">
                                        <h2><a href="#">상품이름</a></h2>
                                        <p>여러가지 내용</p>
                                    </td>
                                    
                                    <td class="quantity">
                                        <div class="cart-plus-minus">
                                            <div class="dec qtybutton">-</div>
                                            <input type="text" value="0" name="qtybutton" class="cart-plus-minus-box">
                                            <div class="inc qtybutton">+</div>
                                        </div>
                                    </td>
                                    <td class="unit">
                                        <h5>5,000</h5>
                                    </td>
                                    <td class="acti">
                                        <a href="#"><i class="far fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-sm-6 col-md-7">
           			</div>
             	    <div class="footer_step1 col-sm-6 col-md-5">
	                    <div class="proceed fix wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.6s">
	                        <a href="#" id="back_list"><i class="fas fa-chevron-left"></i>&nbsp;쇼핑 계속하기</a>
	                        <div class="total">
	                            <h5>총 1개의 상품금액 <span>5000</span>원</h5>
	                            <h5><i class="fas fa-plus-circle"></i>&nbsp;&nbsp;배송비 <span>2500</span>원</h5>
	                            <hr>
	                            <h6>합계 <span>7500</span>원</h6>
	                        </div>
	                        <a id="all_procedto" href="#">전체 상품주문</a>
	                    </div>
              		  </div>
                      <!-- ====================
                 		  STEP2. 배송지 입력 부분
                		=========================  -->
                     <div class="step2 table-responsive wow fadeInDown col-sm-12" data-wow-duration="500ms" data-wow-delay="0.6s" >
                        <table class="table cart-table">
                            <tbody>
                                <tr class="table-info">
                                    <td class="col-sm-2">
                                        * 배송지 입력
                                    </td>
                                    <td class="col-sm-10">
                                        <input id="cust_name" class="radio_css" name="cust_name" type="radio" checked="checked">&nbsp;기본 배송지
                                        &nbsp;&nbsp;&nbsp;
                                        <input id="cust_name" class="radio_css" name="cust_name" type="radio">&nbsp;직접 입력
                                    </td>
                                </tr>
                                <tr class="table-info">
                                    <td class="col-sm-2">
                                        * 받으실 분
                                    </td>
                                    <td class="col-sm-10">
                                        <input id="cust_name" name="cust_name" type="text">
                                    </td>
                                </tr>
                                <tr class="table-info">
                                    <td class="col-sm-2">
                                        * 받으실 곳
                                    </td>
                                    <td class="col-sm-10">
                                        <div class="address_find">
                                            <div class="zipcode_find">
                                                <input id="zipcode" name="zipcode" type="text">
                                                <button id="zipcodebtn" onclick='zipCheck();'>우편번호 찾기</button>
                                            </div>
                                            <div class="address_css">
                                                <input id="address1" name="address1" type="text">
                                                <input id="address2" name="address2" type="text">
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="table-info">
                                    <td class="col-sm-2">
                                        * 휴대폰 번호
                                    </td>
                                    <td class="col-sm-10">
                                        <input id="phone" name="phone" type="text">
                                    </td>
                                </tr>
                                <tr class="table-info">
                                    <td class="col-sm-2">
                                        * 남기실 말씀
                                    </td>
                                    <td class="col-sm-10">
                                        <input id="phone" name="phone" type="text">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-sm-6 col-md-7">
           	   		</div>
                	<div class="footer_step2 col-sm-6 col-md-5">
                    	<div class="proceed fix wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.6s">
                        	<a href="#" class="prev"><i class="fas fa-chevron-left"></i>&nbsp;이전 단계</a>
                    	</div>
                    	<div class="proceed fix wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.6s">
                    		<input id="payment_css" type="submit" value="전체 상품결제">
                    	</div>
                	</div>
                </form>
                 <%-- ================================
                    		form 태그 끝
                 ===================================== --%>
                </div>
            </div>
        </div>
    </section>
</body>
</html>