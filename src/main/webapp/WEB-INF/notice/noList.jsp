<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp" %>
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
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath}/css/adminList-style.css">
<style type="text/css">
.table{
	margin-top : 30px;
}
/* 검색 부분  시작*/
#search_btn{
	cursor: pointer;
}


#search {
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
	padding-left: 15px !important;
	padding-right: 15px !important;
	margin: 10px 0px 10px 0px;
}


select#mode{
	width: 10%;
    height: 40px;
    font-size: 13px;
    line-height: 1.428571429;
    background-color: #fff;
    background-image: none;
    transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
    border-radius: 1px;
    border: 1px solid rgba(111, 121, 122, 0.3);	
}

input#keyword{
	display: block !important;
	width: 20%;
    height: 40px !important;
    padding: 6px 12px !important;
    font-size: 13px !important;
    line-height: 1.428571429 !important;
    background-color: #fff !important;
    background-image: none !important;
    transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s !important;
    border-radius: 1px !important;
    border: 1px solid rgba(111, 121, 122, 0.3) !important;
    -webkit-box-shadow: none !important;
}

#search button{
	height: 40px;
    font-size: 13px;
    line-height: 1.428571429;
    background-color: #fff;
    background-image: none;
    transition: border-color ease-in-out 0.15s, box-shadow ease-in-out 0.15s;
    border-radius: 1px;
    border: 1px solid rgba(111, 121, 122, 0.3);	
}

@media( max-width : 585px ) {
	select#mode{
		width: 30%;
	} 
	
	input#keyword{
		width: 60%;
	}
	
	button {
		width: 10%;
	}
	
}
th{
	background-color: #5080bf;
	color:white;
}

/* 검색 부분  끝*/
</style>
</head>
<body onload="list_load();">

<div align="center" class="container col-sm-offset-2 col-sm-8">
			<%-- 상단 페이지 수 show ---------------------------------------------------%>
		   <div class="container" align="left">
			<div id="top">
				<h2 class="wow fadeInLeft animated portfolio-item" data-wow-duration="500ms" data-wow-delay="0ms">공지사항목록</h2>
				<span class="subtitle-des wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.1s"
				id="search_btn" data-toggle="tooltip" title="클릭하세요!" onclick="search();">
					<i class="fas fa-search" ></i> 검색
				</span>
				<br>
			</div>
		
		
		   <%-- [검색 모드] 
		   		==== 시작 ==== 
		   	--%>	   
	        <form id="contact-form search" method="get" action="${contextPath}/nolist.no" role="form">
	        	<div id="search">
	               <select class="form-control" name="mode" id="mode" data-toggle="tooltip" title="검색할 조건을 선택하세요!">
	                      <option class="form-control" value="all">전체</option>
	                      <option class="form-control" value="title">제목</option>
	                      <option class="form-control" value="content">내용</option>
	               </select>
	               <input type="text" class="form-control" placeholder="검색할 내용을 입력하세요" id="keyword" name="keyword">
	               <button type="submit"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <%-- ==== 끝 ==== --%>
		</div>
	
	  	<div class="row">
	      <table class="table table-bordered table-hover dt-responsive">
	        
	        <%-- 공지사항 목록의 header 부분 -------------------------------------------------------%>
	        <thead>
                <tr>
                    <th width="60%">제목</th>
                    <th width="10%">작성자</th>
                    <th width="10%">조회수</th>
                    <th width="10%">작성일</th>
                </tr>
	        </thead>
	        
	      	<%-- 공지사항 목록의 내용 부분 -------------------------------------------------------%>
            <tbody>
	            <c:forEach var="bean" items="${requestScope.lists}">
	                <tr>
	                    <td>
		                    <a href="<%=contextPath%>/nodetail.no?num=${bean.num}&${requestScope.parameters}">
		                    	<c:if test="${bean.fix==0 }">${bean.title }<c:if test="${bean.comcount > 0 }"><span style="color: #5080bf;">&nbsp;&nbsp;(${bean.comcount})</span></c:if>  </c:if>
		                    	<c:if test="${bean.fix==1 }"><div style="color:red;">${bean.title }<c:if test="${bean.comcount > 0 }"><span style="color: #5080bf;">&nbsp;&nbsp;(${bean.comcount})</span></c:if>  </div></c:if>
		                    </a>
	                    </td>
	                    <td>관리자</td>
	                    <td>${bean.readhit}</td>
	                    <td>${bean.regdate}</td>
	                </tr>
	            </c:forEach>    
            </tbody>
            
	        <%-- 공지사항 목록의 하단 부분 -------------------------------------------------------%>
			<tfoot>
			    <tr>
			        <td colspan="7" align="center">
                        ${requestScope.pagingHtml}	
			        </td>
			    </tr>
			</tfoot>
	      </table>
	  </div>
	   <c:if test="${whologin == 1}">
	  <div align="right">
	  	<a type="button" class="btn btn-primary" href="${contextPath }/noinsert.no">새 글 쓰기</a>
	  </div>
	  </c:if>
</div>
<script type="text/javascript">
function search(){
	$('#search').toggle();
}
function list_load(){
	$('#search').hide(); // 검색 부분 (===> 원데이 클래스 목록 부분)
}
$(document).ready(function(){
	  $('[data-toggle="tooltip"]').tooltip();   
	});
</script>
</body>
</html>