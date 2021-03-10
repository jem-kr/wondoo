<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="${contextPath}/js/noticeupdate.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#fix  option").each(function(){
			if($(this).val()=="${bean.fix}"){
				$(this).attr("selected", "selected");
			}
		});
	});
</script>

<style type="text/css">
body {
	padding-top: 100px;
}
</style>
</head>
<body>
	<section id="notice-section">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block">
						<h2 class="subtitle wow fadeInDown" data-wow-duration="500ms"
							data-wow-delay="0.3s">공지사항 수정</h2>

						<div class="container">
							<div class="row">
								<section>
									<div class="wizard">
										<div class="wizard-inner wow fadeInDown "
											data-wow-duration="500ms" data-wow-delay="0.3s">
											<div class="connecting-line"></div>
										</div>

										<!-- =============================================[Form 양식 시작]============================================= -->
										<div class="notice-form">
											<c:set var="contextPath" value="<%=contextPath%>"
												scope="application" />
											<form id="noti-form" method="post"
												action="${contextPath}/noupdate.no" role="form"
												enctype="multipart/form-data"
												onsubmit="return chk_submit();">
												<input type="hidden" name="pageNumber"
													value="${param.pageNumber}"> <input type="hidden"
													name="pageSize" value="${param.pageSize}"> <input
													type="hidden" name="mode" value="${param.mode}"> <input
													type="hidden" name="keyword" value="${param.keyword}">
												<input type="hidden" name="num" id="num" value="${bean.num}">
												<!-- step1 -->
												<div class="tab-pane active  wow fadeInDown"
													data-wow-duration="500ms" data-wow-delay="0.6s"
													role="tabpanel" id="step1">
													<!-- ------------------------------------- [공지사항 제목]--------------------------------------- -->
													<div class="form-group">
														제목<input type="text" class="form-control"
															placeholder="제목입력" id="title" name="title"
															value="${bean.title }"> <span class="valid_check"
															id="err_title"></span>
													</div>
													<!-- ------------------------------------- [작성자]--------------------------------------- -->
													<div id="writer" class="form-group">
														작성자<input type="text" class="form-control "
															placeholder="작성자" id="fakewriter" name="fakewriter"
															value="도프커피" disabled="disabled"> <input
															type="hidden" name="writer" id="writer"
															value="${sessionScope.loginfo.cust_Email}" />
													</div>
													<!-- ------------------------------------- [내용]--------------------------------------- -->
													<div class="form-group">
														<textarea class="form-control" id="content" name="content"
															placeholder="내용 입력">${bean.content }</textarea>
														<span class="valid_check" id="err_content"></span>
													</div>
													<!-- ------------------------------------- [중요도]--------------------------------------- -->
													<div class="form-group">
														<input type="hidden" value="${bean.fix }" id="fixvalue"> <select
															class="form-control" name="fix" id="fix">
															<option class="form-control" value="">===중요여부를
																선택하세요===</option>
															<option class="form-control" value="0">일반</option>
															<option class="form-control" value="1">중요</option>
														</select> <span class="valid_check" id="err_fix"></span>
													</div>
													<!-- ------------------------------------- [사진]--------------------------------------- -->
													<div class="form-group">
														<input name="image" type="hidden" value="${bean.image}">
														기존 이미지 : <input name="oldimg" type="text"
															value="${bean.image}"> <input type="file"
															class="form-control" name="img" id="img"
															placeholder="파일을 선택하지 않으면 기존 이미지가 유지됩니다.">
														<p style="color: red;">변경할 파일을 선택하지 않으면 기존이미지가 유지됩니다.</p>
													</div>

													<ul class="list-inline pull-right">
														<li class="step-li"><input type="submit"
															id="noti-submit" class="btn btn-default btn-send"
															value="수정 하기" data-toggle="modal" data-target="#myModal"></li>
													</ul>
												</div>


											</form>
										</div>
										<!-- =============================================[Form 양식 끝]============================================= -->
									</div>
								</section>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</section>
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
					<button type="button" class="btn btn-default" data-dismiss="modal"
						style="font-size: 13px" id="modal-btn-ok">확인</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>