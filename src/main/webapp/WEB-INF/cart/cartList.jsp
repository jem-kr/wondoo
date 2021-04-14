<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<%-- 아임포트 사용 시 제이쿼리 버전이 1.12.4로만 사용 가능한지 확인 필요 , 
		 1.12.4 버전이 낮아 기존 장바구니에 적용되었던 자바스크립트가 적용이 안됨	--%>
	<%-- <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script> --%>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
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
                    <%-- ※ jsp 주석 <%-현지-%> 는 장바구니 자바스크립트 함수 적용 시 필요한 input 태그임 , disabled로 결제 처리 시 파라미터는 안넘어감 --%>
                    <%-- ※ jsp 주석 <%-지은-%> 는 결제 처리 시 넘어가야 되는 파라미터 --%>
                    <c:set var="contextPath" value="<%=contextPath%>" scope="application" />
                    <form id="contact-form" method="post" action="${contextPath}/prOrderPayment.po" role="form">
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
	                            <!-- =====================================
	                            		list 반복문 부분 [시작]
	                            ========================================== -->
	                            <c:forEach var="bean" items="${requestScope.lists}" varStatus="status">
		                            <tbody>
		                                <tr class="table-info">
		                                    <td class="produ">
		                      		      		<%--현지--%><input type="hidden" disabled="disabled" id="orders_pro_no${status.count}" name="orders_pro_no" value="${bean.cart_pro_no}">
		                                        <a href="${contextPath}/prDetail.pr?products_seq=${bean.cart_pro_no}">
		                                        	<img width="250" height="150" alt="noimage" src="${contextPath}/upload/${bean.pro_pic}">
		                                        </a>
		                                    </td>
		                                    <td class="namedes" >
		                                        <h2>
		                                        	<a href="${contextPath}/prDetail.pr?products_seq=${bean.cart_pro_no}">
		                                        		${bean.pro_name}
		                                        	</a>
		                                        </h2>
		                                    </td>
		                                    <td class="quantity">
		                                    	<!-- 수정 & 삭제 처리에 사용됨 -->
		                                    	<%--현지--%><input id="cart_seq${status.count}" type="hidden" disabled="disabled" value="${bean.cart_seq}">
		                                        <div class="cart-plus-minus">
		                                            <div class="dec qtybutton" onclick="minusqty(${status.count});">-</div>
		                                            <%--현지--%><input type="text" disabled="disabled" id="orders_qty${status.count}" 
		                                            name="orders_qty" value="${bean.cart_cust_qty}" 
		                                            name="qtybutton" class="cart-plus-minus-box">
		                                            <div class="inc qtybutton" onclick="plusqty(${status.count});">+</div>
		                                        </div>
		                                    </td>
		                                    <td class="unit">
		                                    	<%--현지--%><input type="hidden" disabled="disabled" id="pro_price${status.count}" value="${bean.pro_price}" name="qtybutton" class="cart-plus-minus-box">
		                                        <h5 id="cart_price${status.count}">${bean.cart_price}</h5>
		                                    </td>
		                                    <td class="acti">
		                                        <i class="far fa-trash-alt" onclick="click_count(${status.count});"></i>
		                                    </td>
		                                </tr>
		                            </tbody>
	                            </c:forEach>
	                            <!-- =====================================
	                            		list 반복문 부분 [끝]
	                            ========================================== -->
	                        </table>
	                    </div>
	                    <div class="col-sm-6 col-md-7">
	           			</div>
	             	    <div class="footer_step1 col-sm-6 col-md-5">
		                    <div class="proceed fix wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.6s">
		                        <a id="back_list" onclick="cart_back();"><i class="fas fa-chevron-left"></i>&nbsp;쇼핑 계속하기</a>
		                        <div class="total">
		                            <h5>
		                            	총 ${requestScope.total_list}개의 상품금액 
		                            	<span id="sum_price">${requestScope.sum_price}</span>원
		                            </h5>
		                            <h5>
		                            	<i class="fas fa-plus-circle"></i>&nbsp;&nbsp;배송비 
		                            	<span id="delivery_price">${requestScope.delivery_price}</span>원
		                            </h5>
		                            <hr>
		                            <h6>
		                            	합계
		                            	<span id="total_amount">
		                            		${requestScope.sum_price + requestScope.delivery_price}
		                            	</span>원
		                            	<%--지은--%><input type="hidden" id="orders_total_amount" name="orders_total_amount" value="${requestScope.sum_price + requestScope.delivery_price}">
		                            </h6>
		                        </div>
		                        <a id="all_procedto" href="#">전체 상품주문</a>
		                    </div>
	              		  </div>
	                      <!-- ========================================================================
	                 		  STEP2. 배송지 입력 부분 - 1. 기존 배송지가 있는 경우 / 2. 없는 경우로 나뉨
	                		===========================================================================  -->
	                     <div class="step2 table-responsive wow fadeInDown col-sm-12" data-wow-duration="500ms" data-wow-delay="0.6s" >
	                     	<%--지은--%><input type="hidden" id="orders_cust_email" name="orders_cust_email" value="${customer.cust_Email}">
	                        <%-- 1. 기존 배송지가 있는 경우 [시작] --%>
	                		<c:if test="${not empty customer.cust_Zipcode}">
		                        <table class="table cart-table">
		                            <tbody>
		                                <tr class="table-info">
		                                    <td class="col-sm-2">
		                                        * 배송지 입력
		                                    </td>
		                                    <td class="col-sm-10">
		                                    	<label class="delivery" onclick="delivery_restore();">
		                                        	<input class="radio_css" name="cust_name" type="radio" checked="checked">&nbsp;
		                                        	기본 배송지
		                                        </label>
		                                        &nbsp;&nbsp;&nbsp;
		                                        <label class="delivery" onclick="delivery_change();">
		                                        	<input class="radio_css" name="cust_name" type="radio" >&nbsp;
		                                        	기본 배송지 변경
		                                        </label>
		                                        &nbsp;&nbsp;&nbsp;
		                                    </td>
		                                </tr>
		                                <tr class="table-info">
		                                    <td class="col-sm-2">
		                                        &nbsp;&nbsp;받으실 분
		                                    </td>
		                                    <td class="col-sm-10">
		                                        <input id="cust_name" class="new_data" disabled="disabled" name="cust_name" type="text" value="${customer.cust_Name}">
		                                        <%--지은--%><input id="cust_Name" class="new_data" name="cust_Name" type="hidden" value="${customer.cust_Name}">
		                                    </td>
		                                </tr>
		                                <tr class="table-info">
		                                    <td class="col-sm-2">
		                                        * 받으실 곳
		                                    </td>
		                                    <td class="col-sm-10">
		                                        <div class="address_find">
		                                            <div class="zipcode_find">
		                                                <input disabled="disabled" class="new_data" id="fake_orders_zipcode" name="fake_orders_zipcode" type="text" value="${customer.cust_Zipcode}">
		                                                <%--지은--%><input id="orders_zipcode" class="new_data" name="orders_zipcode" type="hidden" value="${customer.cust_Zipcode}">
		                                                <button id="zipcodebtn" type="button" disabled="disabled" onclick='zipCheck1();' data-toggle="tooltip" title="주소 변경 시 클릭하세요!">우편번호 찾기</button>
		                                            </div>
		                                            <div class="address_css">
		                                                <input disabled="disabled"  id="fake_orders_adr01" class="new_data" name="fake_orders_adr01" type="text" value="${customer.cust_ADR01}">
		                                                <%--지은--%><input id="orders_adr01" class="new_data" name="orders_adr01" type="hidden" value="${customer.cust_ADR01}">
		                                                <input disabled="disabled"  id="fake_orders_adr02" class="new_data" name="fake_orders_adr02" type="text" value="${customer.cust_ADR02}" oninput="input_adr2()">
		                                                <%--지은--%><input id="orders_adr02" name="orders_adr02" class="new_data" type="hidden" value="${customer.cust_ADR02}">
		                                            </div>
		                                             <p class="valid_check" id="err_address2"></p>
		                                        </div>
		                                       
		                                    </td>
		                                </tr>
		                                <tr class="table-info">
		                                    <td class="col-sm-2">
		                                        * 휴대폰 번호
		                                    </td>
		                                    <td class="col-sm-10">
		                                    	<c:if test="${not empty customer.cust_Contact}">
		                                        	<input disabled="disabled" class="new_data" id="fake_orders_phone" name="fake_orders_phone" type="text" value="${customer.cust_Contact}" oninput="input_phone()">
		                                        	<%--지은--%><input class="new_data" id="orders_phone" name="orders_phone" type="hidden" value="${customer.cust_Contact}">
		                                        </c:if>
		                                        <c:if test="${empty customer.cust_Contact}">
		                                        	<%--지은--%><input class="new_data" id="orders_phone" name="orders_phone" type="text">
		                                        </c:if>
		                                        <p class="valid_check" id="err_phone"></p>
		                                    </td>
		                                </tr>
		                                <tr class="table-info">
		                                    <td class="col-sm-2">
		                                        &nbsp;&nbsp;&nbsp;남기실 말씀
		                                    </td>
		                                    <td class="col-sm-10">
		                                        <%--지은--%><textarea id="orders_request" name="orders_request" rows="5"></textarea>
		                                        <p class="valid_check" id="err_request"></p>
		                                    </td>
		                                </tr>
		                            </tbody>
	                        	</table>
	                	    </c:if>
	                	     <%-- 2. 기존 배송지가 없는 경우(신규 등록) [시작] --%>
	                		<c:if test="${empty customer.cust_Zipcode}">
	                			 <table class="table cart-table">
		                            <tbody>
		                                <tr class="table-info">
		                                    <td class="col-sm-2">
		                                        * 배송지 입력
		                                    </td>
		                                    <td class="col-sm-10">
		                                        <label class="delivery">
		                                        	<input class="radio_css" name="cust_name" type="radio" checked="checked">&nbsp;
		                                        	신규 배송지
		                                        </label>
		                                    </td>
		                                </tr>
		                                <tr class="table-info">
		                                    <td class="col-sm-2">
		                                       &nbsp;&nbsp;받으실 분
		                                    </td>
		                                    <td class="col-sm-10">
		                                        <input id="cust_name" class="new_data" disabled="disabled" name="cust_name" type="text" value="${customer.cust_Name}" onblur="err_check_name();">
		                                       
		                                    </td>
		                                </tr>
		                                <tr class="table-info">
		                                    <td class="col-sm-2">
		                                        * 받으실 곳
		                                    </td>
		                                    <td class="col-sm-10">
		                                        <div class="address_find">
		                                            <div class="zipcode_find">
		                                                <input disabled="disabled" class="new_data" id="fake_orders_zipcode" name="fake_orders_zipcode" type="text">
		                                                <%--지은--%><input id="orders_zipcode" class="new_data" name="orders_zipcode" type="hidden">
		                                                <button id="zipcodebtn" type="button" onclick='zipCheck2();'>우편번호 찾기</button>
		                                            </div>
		                                            <div class="address_css">
		                                                <input disabled="disabled"  id="fake_orders_adr01" class="new_data" name="fake_orders_adr01" type="text">
		                                                <%--지은--%><input id="orders_adr01" name="orders_adr01" class="new_data" type="hidden">
		                                                <%--지은--%><input id="orders_adr02" name="orders_adr02" class="new_data" type="text">
		                                            </div>
		                                        </div>
		                                        <p class="valid_check" id="err_address2"></p>
		                                    </td>
		                                </tr>
		                                <tr class="table-info">
		                                    <td class="col-sm-2">
		                                        * 휴대폰 번호
		                                    </td>
		                                    <td class="col-sm-10">
		                                    	<c:if test="${not empty customer.cust_Contact}">
		                                        	<%--지은--%><input class="new_data" id="orders_phone" name="orders_phone" type="text" value="${customer.cust_Contact}">
		                                        </c:if>
		                                        <c:if test="${empty customer.cust_Contact}">
		                                        	<%--지은--%><input class="new_data" id="orders_phone" name="orders_phone" type="text">
		                                        </c:if>
		                                        <p class="valid_check" id="err_phone"></p>
		                                    </td>
		                                </tr>
		                                <tr class="table-info">
		                                    <td class="col-sm-2">
		                                        &nbsp;&nbsp;&nbsp;남기실 말씀
		                                    </td>
		                                    <td class="col-sm-10">
		                                        <%--지은--%><textarea id="orders_request" name="orders_request" rows="5"></textarea>
		                                        <p class="valid_check" id="err_request"></p>
		                                    </td>
		                                </tr>
		                            </tbody>
	                        	</table>
	                		</c:if>
	                  	  </div>
	                    <div class="col-sm-6 col-md-7">
	           	   		</div>
	                	<div class="footer_step2 col-sm-6 col-md-5">
	                    	<div class="proceed fix wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.6s">
	                        	<a href="#" class="prev"><i class="fas fa-chevron-left"></i>&nbsp;이전 단계</a>
	                    	</div>
	                    	<div class="proceed fix wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.6s">
	                    		<input id="payment_css" type="button" value="전체 상품결제" onclick="payment();">
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
     <%-- ==============================================
               삭제 관련 모달 section
          =============================================--%>
	<div class="container">
	
	  <!-- Modal -->
	  <div class="modal fade" id="myModal" role="dialog">
	  	<input id="count" type="hidden" value=""> <!-- foreach 문에서 반복 횟수 -->
	    <div class="modal-dialog modal-sm">
	      <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 id="modal-title" class="modal-title" style="font-size: 35px">
	          	  <i class="fas fa-exclamation-circle"></i>
	          </h4>
	        </div>
	        <div class="modal-body">
	          <p id="modal-body" style="font-size: 13px">정말 삭제하시겠습니까?</p>
	        </div>
	        <div class="modal-footer">
		         <button type="button" class="modalbtn btn btn-default" data-dismiss="modal" 
		         style="font-size: 13px" onclick="del_check();">예</button>
		         <button type="button" class="modalbtn btn btn-default" data-dismiss="modal" 
		         style="font-size: 13px">아니오</button>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
	  <%-- ==============================================
               일반 에러 메세지 모달 section
          =============================================--%>
	<div class="container">
	
	  <!-- Modal -->
	  <div class="modal fade" id="err_myModal" role="dialog">
	    <div class="modal-dialog modal-sm">
	      <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 id="err_modal-title" class="modal-title" style="font-size: 35px"></h4>
	        </div>
	        <div class="modal-body">
	          <p id="err_modal-body" style="font-size: 13px"></p>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="modalbtn btn btn-default" data-dismiss="modal" style="font-size: 13px">닫기</button>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>