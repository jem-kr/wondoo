<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	int twelve = 12;
	int myoffset = 2;
	int mywidth = twelve - 2 * myoffset;
	int formleft = 3;
	int formright = twelve - formleft;
%>
<%
	String contextPath = request.getContextPath(); //현재 진행 중인 프로젝트 이름 
	String mappingName = "/cafe"; //요청을 위한 url 패턴 이름
	String YesForm = contextPath + mappingName; //폼이 있는 경우에 사용된다.
	String NoForm = contextPath + mappingName + "?command=";	
	
%>
<!DOCTYPE html>
<html>
<head>
	<title>우편 번호 찾기</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet"
		href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script
		src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		function sendAddress(zipcode, address) {
			// zipcode는 우편 번호, address는 주소
			/* alert(zipcode + '/' + address) ;  */
			//opener : 나 자신을 open 시킨 창
			opener.document.myform.cust_Zipcode.value = zipcode ; // 우편 번호
			opener.document.myform.fakecust_Zipcode.value = zipcode; // 가짜 우편 번호 
			opener.document.myform.fakecust_ADR01.value = address; // 가짜 주소 01
			opener.document.myform.cust_ADR01.value = address ; // 주소 01
			opener.document.myform.cust_ADR02.focus(); // 주소 02에 포커스 주기
			self.close(); //self : 자기 자신을 의미
		}
		function myzipcheck( ){
			var finddata = document.myform.dong.value ;
			if(finddata.length <= 1){
				alert('동이름을 2글자 이상 입력해주세요') ;
				document.myform.dong.focus() ; 
				return false ;
			}
		}
		/* 우편번호 검색 후 창닫기 */
		function closezipcode(){
			self.close();
		}
	</script>
</head>
<body>
	<div class="container col-sm-offset-<%=myoffset%> col-sm-<%=mywidth%>">
		<div class="panel panel-default panel-primary">
			<div class="panel-heading">우편 번호 검색</div>
			<div class="panel-body">
				<form name="myform" class="form-inline" role="form" method="get" action="<%=contextPath%>/zipcheck.cu" >
					<table class="table table-striped table-hover table-condensed">
						<tr>
							<td colspan="2" align="center">
								<p class="form-control-static">동이름 입력 :</p>

								<div class="form-group">
									<input type="text" class="form-control" name="dong" id="dong"
										placeholder="검색할 동이름을 입력하세요" value=${requestScope.dong}>
								</div>
								<button class="btn btn-default" type="submit" onclick="return myzipcheck();">검색</button>
							</td>
						</tr>
						<c:forEach items="${lists}" var="oneitem">
							<c:set var="address"
								value="${fn:trim(oneitem.si_nm)} ${fn:trim(oneitem.sgg_nm)} ${fn:trim(oneitem.rd_nm)} ${fn:trim(oneitem.bd_ma_sn)}(${fn:trim(oneitem.emd_nm)} ${fn:trim(oneitem.search_word)})" />
							<tr>
								<td width="25%" align="center"><a href='#'
									onclick="sendAddress('${oneitem.area_cd}', '${address}');">
										${oneitem.area_cd} </a></td>
								<td width="75%" align="left"><a href='#'
									onclick="sendAddress('${oneitem.area_cd}', '${address}');">
										${address} </a></td>
							</tr>
						</c:forEach>
					</table>
				</form>
				<div class="row" align="center">
					<button class="btn btn-primary" type="button" onclick="javascript:closezipcode();">
						닫&nbsp;&nbsp;기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>