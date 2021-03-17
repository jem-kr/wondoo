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
	                            <!-- =====================================
	                            		list 반복문 부분 [시작]
	                            ========================================== -->
	                            <c:forEach var="bean" items="${requestScope.lists}">
		                            <tbody>
		                                <tr class="table-info">
		                                	
		                                    <td class="produ">
		                                    	<%--@--%><input type="text" id="orders_cust_email" name="orders_cust_email" value="${customer.cust_Email}">
		                      		      		<%--@--%><input type="text" id="orders_pro_no" name="orders_pro_no" value="${bean.cart_pro_no}">
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
		                                        <div class="cart-plus-minus">
		                                            <div class="dec qtybutton" onclick="minusqty();">-</div>
		                                            <input type="hidden" disabled="disabled" id="pro_stock" value="${bean.pro_stock}" name="qtybutton" class="cart-plus-minus-box">
		                                            <%--@--%><input type="text" id="orders_qty" name="orders_qty"  value="${bean.cart_cust_qty}" 
		                                            name="qtybutton" class="cart-plus-minus-box" oninput="qty_check()">
		                                            <div class="inc qtybutton" onclick="plusqty();">+</div>
		                                        </div>
		                                    </td>
		                                    <td class="unit">
		                                    	<input type="hidden" disabled="disabled" id="pro_price" value="${bean.pro_price}" name="qtybutton" class="cart-plus-minus-box">
		                                        <h5 id="cart_price"><fmt:formatNumber pattern="#,###,###" value="${bean.cart_price}"/></h5>
		                                       	<%--@--%><input type="text" id="orders_amount" name="orders_amount" value="${bean.cart_price}">
		                                    </td>
		                                    <td class="acti">
		                                    	<input id="cart_seq" type="hidden" disabled="disabled" value="${bean.cart_seq}">
		                                        <i class="far fa-trash-alt" data-toggle="modal" data-target=".modal"></i>
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
		                        <a href="${contextPath}/cfList.pr" id="back_list"><i class="fas fa-chevron-left"></i>&nbsp;쇼핑 계속하기</a>
		                        <div class="total">
		                            <h5>
		                            	총 ${requestScope.total_list}개의 상품금액 
		                            	<span><fmt:formatNumber pattern="#,###,###" value="${requestScope.sum_price}"/></span>원
		                            </h5>
		                            <h5>
		                            	<i class="fas fa-plus-circle"></i>&nbsp;&nbsp;배송비 
		                            	<span><fmt:formatNumber pattern="#,###,###" value="${requestScope.delivery_price}"/></span>원
		                            </h5>
		                            <hr>
		                            <h6>
		                            	합계<span>
		                            		<fmt:formatNumber pattern="#,###,###" value="${requestScope.sum_price + requestScope.delivery_price}"/>
		                            	</span>원
		                            	<%-- 이건 DB에 들어가는 파라미터는 아니지만.. 결제 API 사용시 총 결제 금액이 필요 할 듯 해서 일단..남길게 --%>
		                            	<%--@@--%><input type="text" id="orders_total_amount" name="orders_total_amount" value="${requestScope.sum_price + requestScope.delivery_price}">
		                            </h6>
		                        </div>
		                        <a id="all_procedto" href="#">전체 상품주문</a>
		                    </div>
	              		  </div>
	                      <!-- ========================================================================
	                 		  STEP2. 배송지 입력 부분 - 1. 기존 배송지가 있는 경우 / 2. 없는 경우로 나뉨
	                		===========================================================================  -->
	                     <div class="step2 table-responsive wow fadeInDown col-sm-12" data-wow-duration="500ms" data-wow-delay="0.6s" >
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
	                                        	<input id="cust_name" class="radio_css" name="cust_name" type="radio" checked="checked">&nbsp;
	                                        	기본 배송지
	                                        </label>
	                                        &nbsp;&nbsp;&nbsp;
	                                        <label class="delivery" onclick="delivery_change();">
	                                        	<input id="cust_name" class="radio_css" name="cust_name" type="radio" >&nbsp;
	                                        	기본 배송지 변경
	                                        </label>
	                                        &nbsp;&nbsp;&nbsp;
	                                        <label class="delivery" onclick="delivery_new();">
	                                        	<input id="cust_name" class="radio_css" name="cust_name" type="radio">&nbsp;
	                                        	신규 배송지
	                                        </label>
	                                    </td>
	                                </tr>
	                                <tr class="table-info">
	                                    <td class="col-sm-2">
	                                        * 받으실 분
	                                    </td>
	                                    <td class="col-sm-10">
	                                        <input id="cust_name" class="new_data" disabled="disabled" name="cust_name" type="text" value="${customer.cust_Name}">
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
	                                                <%--@--%><input id="orders_zipcode" class="new_data" name="orders_zipcode" type="hidden" value="${customer.cust_Zipcode}">
	                                                <button id="zipcodebtn" type="button" disabled="disabled" onclick='zipCheck();'>우편번호 찾기</button>
	                                            </div>
	                                            <div class="address_css">
	                                                <input disabled="disabled"  id="fake_orders_ADR01" class="new_data" name="fake_orders_ADR01" type="text" value="${customer.cust_ADR01}">
	                                                <%--@--%><input id="orders_adr01" class="new_data" name="orders_adr01" type="hidden" value="${customer.cust_ADR01}">
	                                                <input disabled="disabled"  id="fake_orders_ADR02" class="new_data" name="fake_orders_ADR02" type="text" value="${customer.cust_ADR02}">
	                                                <%--@--%><input id="orders_adr02" name="orders_adr02" class="new_data" type="hidden" value="${customer.cust_ADR02}">
	                                            </div>
	                                        </div>
	                                    </td>
	                                </tr>
	                                <tr class="table-info">
	                                    <td class="col-sm-2">
	                                        * 휴대폰 번호
	                                    </td>
	                                    <td class="col-sm-10">
	                                    	<c:if test="${not empty customer.cust_Contact}">
	                                        	<input disabled="disabled" class="new_data" id="fake_orders_phone" name="fake_orders_phone" type="text" value="${customer.cust_Contact}">
	                                        	<%--@--%><input class="new_data" id="orders_phone" name="orders_phone" type="hidden" value="${customer.cust_Contact}">
	                                        </c:if>
	                                        <c:if test="${empty customer.cust_Contact}">
	                                        	<%--@--%><input class="new_data" id="orders_phone" name="orders_phone" type="text">
	                                        </c:if>
	                                    </td>
	                                </tr>
	                                <tr class="table-info">
	                                    <td class="col-sm-2">
	                                        &nbsp;&nbsp;&nbsp;남기실 말씀
	                                    </td>
	                                    <td class="col-sm-10">
	                                        <%--@--%><textarea id="orders_request" name="orders_request" rows="5"></textarea>
	                                    </td>
	                                </tr>
	                            </tbody>
	                        </table>
	                	    </c:if>
	                	    <%-- 1. 기존 배송지가 있는 경우 [끝] --%>
	                	    
	                	    <%-- 2. 기존 배송지가 없는 경우 [시작] 
	                	    <c:if test="${empty customer.cust_Zipcode}">
	                        <table class="table cart-table">
	                            <tbody>
	                                <tr class="table-info">
	                                    <td class="col-sm-2">
	                                        * 배송지 입력
	                                    </td>
	                                    <td class="col-sm-10">
	                                        <label class="delivery">
	                                        	<input id="cust_name" class="radio_css" name="cust_name" type="radio">&nbsp;
	                                        	신규 배송지
	                                        </label>
	                                    </td>
	                                </tr>
	                                <tr class="table-info">
	                                    <td class="col-sm-2">
	                                        * 받으실 분
	                                    </td>
	                                    <td class="col-sm-10">
	                                        <input id="cust_name" disabled="disabled" name="cust_name" type="text" value="${customer.cust_Name}">
	                                    </td>
	                                </tr>
	                                <tr class="table-info">
	                                    <td class="col-sm-2">
	                                        * 받으실 곳
	                                    </td>
	                                    <td class="col-sm-10">
	                                        <div class="address_find">
	                                            <div class="zipcode_find">
	                                                <input id="orders_Zipcode" name="orders_Zipcode" type="text" value="${customer.cust_Zipcode}">
	                                                <button id="zipcodebtn" type="button" onclick='zipCheck();'>우편번호 찾기</button>
	                                            </div>
	                                            <div class="address_css">
	                                                <input id="orders_ADR01" name="orders_ADR01" type="text" value="${customer.cust_ADR01}">
	                                                <input id="orders_ADR02" name="orders_ADR02" type="text" value="${customer.cust_ADR02}">
	                                            </div>
	                                        </div>
	                                    </td>
	                                </tr>
	                                <tr class="table-info">
	                                    <td class="col-sm-2">
	                                        * 휴대폰 번호
	                                    </td>
	                                    <td class="col-sm-10">
	                                    	<c:if test="${not empty customer.cust_Contact}">
	                                        	<input id="phone" name="phone" type="text" value="${customer.cust_Contact}">
	                                        </c:if>
	                                        <c:if test="${empty customer.cust_Contact}">
	                                        	<input id="phone" name="phone" type="text">
	                                        </c:if>
	                                    </td>
	                                </tr>
	                                <tr class="table-info">
	                                    <td class="col-sm-2">
	                                        &nbsp;&nbsp;&nbsp;남기실 말씀
	                                    </td>
	                                    <td class="col-sm-10">
	                                        <textarea id="orders_Request" name="orders_Request" rows="5"></textarea>
	                                    </td>
	                                </tr>
	                            </tbody>
	                        </table>
	                	    </c:if> --%>
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
     <%-- ==============================================
               삭제 관련 모달 section
          =============================================--%>
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