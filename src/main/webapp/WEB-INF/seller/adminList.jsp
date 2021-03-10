<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./../common/common.jsp"%>
<!-- spring:message 및 properties 파일 사용을 위함  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	int myoffset = 2;
	int mywidth = twelve - 2 * myoffset;
	int formleft = 3 ;
	int formright = twelve - formleft ; 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 개인 회원 목록</title>
<!-- AdminList Style CSS -->
<link rel="stylesheet" href="${contextPath}/css/adminList-style.css">

<script type="text/javascript">
/* 수정필요) 상단 search, 페이지 수 조회 부분 */
/* 	$('table').DataTable(); */
</script>
 
</head>
<body>
<%-- 관리자 권한, 회원 목록 보기 -------------------------------------------------------%>
<div align="center" class="container col-sm-offset-2 col-sm-8">
	<h2>전체 회원 목록</h2>
		<div class="row">
			<%-- 상단 페이지 수 show ---------------------------------------------------%>
		    <div class="col-sm-6">
		        <div class="dataTables_length" id="DataTables_Table_0_length">
		            <label>
		                Show 
		                <select class="form-control input-sm" name="DataTables_Table_0_length" aria-controls="DataTables_Table_0">
			                <option value="10">10</option>
			                <option value="25">25</option>
			                <option value="50">50</option>
			                <option value="100">100</option>
		            	</select>
		            </label>
		        </div>
		    </div>
			<%-- 상단 검색 search ---------------------------------------------------%>
		    <div class="col-sm-6">
		        <div class="dataTables_filter" id="DataTables_Table_0_filter">
		            <label>
		                Search:
		                <input type="search" class="form-control input-sm" 
		                placeholder="" aria-controls="DataTables_Table_0">
		            </label>
		        </div>
		    </div>
		</div>
	
	  	<div class="row">
	      <table class="table table-bordered table-hover dt-responsive">
	        
	        <%-- 회원 목록의 header 부분 -------------------------------------------------------%>
	        <thead>
                <tr>
                	
                    <th><spring:message code="customer.cust_Email"/></th>
                    <th><spring:message code="customer.cust_Name"/></th>
                    <th><spring:message code="customer.cust_Contact"/></th>
                    <th><spring:message code="customer.cust_Birth"/></th>
                    <th><spring:message code="customer.cust_RegDate"/></th>
                    <th><spring:message code="customer.cust_Join"/></th>
                    <th><spring:message code="customer.savepoint"/></th>
                </tr>
	        </thead>
	        
	      	<%-- 회원 목록의 내용 부분 -------------------------------------------------------%>
            <tbody>
	            <c:forEach var="bean" items="${requestScope.lists}">
	                <tr>
	                    <td>${bean.cust_Email}</td>
	                    <td>
		                    <a href="<%=contextPath%>custDetail.cu&id=${bean.cust_Email}">
		                    	${bean.cust_Name}
		                    </a>
	                    </td>
	                    <td>${bean.cust_Contact}</td>
	                    <td>${bean.cust_Birth}</td>
	                    <td>${bean.cust_RegDate}</td>
	                    <td>${bean.cust_Join}</td>
	                    <td>${bean.savepoint}원</td>
	                </tr>
	            </c:forEach>    
            </tbody>
            
	        <%-- 회원 목록의 하단 부분 -------------------------------------------------------%>
			<tfoot>
			    <tr>
			        <td colspan="7">
                        ${requestScope.pageInfo.pagingHtml}	
			        </td>
			    </tr>
			</tfoot>
	      </table>
	  </div>
</div>
</body>
</html>