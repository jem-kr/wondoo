<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp"%>
<%
int myoffset = 2;
int mywidth = twelve - 2 * myoffset;
int formleft = 3;
int formright = twelve - formleft;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath }/css/adminList-style.css">
<script type="text/javascript" src="${contextPath}/js/noticedetail.js"></script>
<style type="text/css">
body{
	padding-bottom;
}
.commentinsert{
	padding-top: 50px;
	padding-bottom: 50px;
}
#innettable{
	border-style: hidden;
}
</style>
</head>
<body>

	<div align="center" class="container col-sm-offset-2 col-sm-8">
		<input type="hidden" value="${bean.num }" name="num" id="num">
		<h2 align="left">공지사항</h2>
		<div class="row" style="padding-bottom:30px;">
			<table class="table table-bordered dt-responsive" style="word-wrap:break-word; white-space: pre-line; table-layout: fixed;">
				<c:if test="${whologin != 1}">
					<tr>
						<th colspan="4" align="left">${bean.title }</th>
					</tr>
				</c:if>
				<c:if test="${whologin == 1}">
					<tr>
						<th colspan="3" align="left">${bean.title }</th>
						<th colspan="1" align="right"><a id="updatebtn"
							href="${contextPath }/noupdate.no?num=${bean.num}&${requestScope.parameters}">수정</a>&nbsp;&nbsp;<a
							id="delbtn" data-toggle="modal" data-target=".modal">삭제</a></th>
					</tr>
				</c:if>
				<tr>
					<td colspan="1" align="center">작성자</td>
					<td colspan="3" align="left">관리자</td>
				</tr>
				<tr>
					<td width="10%" align="center">조회수</td>
					<td width="40%" align="left">${bean.readhit }</td>
					<td width="10%" align="center">작성일</td>
					<td width="40%" align="left">${bean.regdate }</td>
				</tr>
				<c:if test="${not empty bean.image}">
					<tr>
						<td colspan="4" align="center"><a
										href="./upload/${bean.image}" data-fancybox data-caption="캡션"
										class="fancybox-img"> <img src="./upload/${bean.image}"
											class="img-responsive" width="200" height="200"
											alt="${bean.image}">
									</a>
									${bean.content}<br><br></td>
									
								</tr>
								<br><br>
				</c:if>
				<c:if test="${empty bean.image}">
					<tr height="350px">
						<td colspan="4" align="left">${bean.content}<br><br></td>
					</tr><br><br>
				</c:if>
			</table>
			<a type="button" class="btn btn-primary"
				href="<%=contextPath%>/nolist.no">목록으로</a>
		</div>
		
		
	
	<!--  댓글  -->
	<c:if test="${whologin!=0 }">
		<div class="container col-sm-offset-2 col-sm-8 commentinsert">
			<label for="content">comment</label>
			<form name="commentInsertForm">
				<div class="input-group">
					<input type="hidden" name="num" value="${bean.num}" /> 
					<c:if test="${whologin == 2}">
					<input type="hidden" name="writer" id="writer" value="${sessionScope.loginfo_seller.sell_Name }">
					</c:if>
					<c:if test="${whologin == 1|| whologin==3}">
					<input type="hidden" name="writer" id="writer" value="${sessionScope.loginfo.cust_Name}">
					</c:if>
					<input type="text" class="form-control" id="content" name="content"
						placeholder="내용을 입력하세요.">
						<span class="input-group-btn">
						<button class="btn btn-default" type="button"
							name="commentInsertBtn">등록</button>
					</span>
				</div>
			</form>
		</div>
		</c:if>
		<div class="container">
			<div class="commentList"></div>
		</div>
		</div>
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
						<p id="modal-body" style="font-size: 13px">정말 삭제하시겠습니까?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px" id="modal-btn-del" onclick="del_check();">삭제</button>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px" id="modal-btn-no">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
<%@ include file="commentS.jsp" %>
</html>