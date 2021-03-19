<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="./../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 수정</title>
	<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="${contextPath}/js/productInsert.js"></script>
    <link rel="stylesheet" href="${contextPath}/css/product.css">    
    <script type="text/javascript">
    $(document).ready(function(){
		$("#pro_category option").each(function(){
			if($(this).val()=="${bean.pro_category}"){
				$(this).attr("selected", "selected");
			}
		});
		
		$("#pro_type option").each(function(){
			if($(this).val()=="${bean.pro_type}"){
				$(this).attr("selected", "selected");
			}
		});
		
	});
    
    </script>
</head>
<body onload="setprice();">
	<section id="contact-section">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block">
						<div class="top">
							<h2 class="subtitle wow fadeInDown" data-wow-duration="500ms"
								data-wow-delay="0.3s">상품 수정</h2>
							<p class="subtitle-des wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.1s">
								사업자님! 등록하신 상품 정보를 수정하세요.
							</p>
						</div>
						
						<div class="container">
					        <div class="row">
					            <section>
					            <div class="wizard">
					                <div class="wizard-inner wow fadeInDown " data-wow-duration="500ms" data-wow-delay="0.3s">
					                    <div class="connecting-line"></div>
					                    <ul class="nav nav-tabs" role="tablist">
					    
					                        <li role="presentation" class="active">
					                            <a href="#step1" data-toggle="tab" aria-controls="step1" role="tab" 
					                            title="01. 상품 정보 수정">
					                                <span class="round-tab">
					                                   <i class="fas fa-id-card"></i>
					                                </span>
					                            </a>
					                        </li>
					                        <li role="presentation" class="disabled">
					                            <a href="#step2" data-toggle="tab" aria-controls="step2" role="tab" 
					                            title="02. 상품 이미지 수정">
					                                <span class="round-tab">
					                                    <i class="fas fa-images"></i>
					                                </span>
					                            </a>
					                        </li>
					    
					                        <li role="presentation" class="disabled">
					                            <a href="#complete" data-toggle="tab" aria-controls="complete" role="tab" 
					                            title="03. 상품 등록">
					                                <span class="round-tab">
					                                    <i class="fas fa-check"></i>
					                                </span>
					                            </a>
					                        </li>
					                    </ul>
					                </div>
					    
                                    <!-- =============================================[Form 양식 시작]============================================= -->
                                    <div class="contact-form">
                                        <c:set var="contextPath" value="<%=contextPath%>" scope="application" />
                                        <form id="contact-form" method="post" action="${contextPath}/prUpdate.pr" role="form" enctype="multipart/form-data">
                                            <input type="hidden" id="isCheck" class="isCheck" name="isCheck" value="false">
                                            <input type="hidden" id="pro_sell_email" name="pro_sell_email" value="${sessionScope.loginfo_seller.sell_Email}">
                                            <input type="hidden" id="products_seq" name="products_seq" value="${bean.products_seq}">
                                            <div class="tab-content">
                                                <!-- step1 -->
                                                <div class="tab-pane active  wow fadeInDown"  data-wow-duration="500ms" data-wow-delay="0.6s" role="tabpanel" id="step1">
                                                    <h4 class="subtitle sub_steptitle">상품 정보를 수정하세요</h4>
                                                    <!-- ------------------------------------- [대분류 pro_category section]--------------------------------------- -->
                                                    <div class="form-group">
                                                    	<div class="column_name">
                                                    		대분류
                                                    	</div>
                                                    	<input type="hidden" value="${bean.pro_category }">
                                                        <select class="form-control" name="pro_category" id="pro_category">
                                                            <option class="form-control" value="-">대분류를 선택하세요.</option>
                                                           	<option class="form-control" value="c">커피</option>
                                                           	<option class="form-control" value="p">용품</option>
                                                        </select>
                                                        <span class="valid_check" id="err_pro_category"></span>
                                                    </div>
                                                    
                                                    <!-- ------------------------------------- [소분류 pro_type section]--------------------------------------- -->
                                                    <div class="form-group">
                                                    	<div class="column_name">
                                                    		소분류
                                                    	</div>
                                                    	<input type="hidden" value="${bean.pro_type }">
                                                        <select class="form-control" name="pro_type" id="pro_type">
                                                            <option class="form-control" value="-">소분류를 선택하세요.</option>
                                                           	<option class="form-control" value="싱글오리진">싱글오리진원두</option>
                                                           	<option class="form-control" value="블렌딩">블렌딩원두</option>
                                                           	<option class="form-control" value="캡슐">캡슐커피</option>
                                                           	<option class="form-control" value="용품">커피용품</option>
                                                           	<option class="form-control" value="컵">컵/텀블러</option>
                                                           	<option class="form-control" value="기타">기타</option>
                                                        </select>
                                                        <span class="valid_check" id="err_pro_type"></span>
                                                    </div>
                                                   <!-- ------------------------------------- [상품명 pro_name section]--------------------------------------- -->
                                                    <div id="test" class="form-group">
                                                    	<div class="column_name">
                                                    		상품명
                                                    	</div>
                                                        <input type="text" class="form-control " placeholder="상품명 전체를 적어주세요" id="pro_name" name="pro_name" value="${bean.pro_name }">
                                                        <span class="valid_check" id="err_pro_name"></span>
                                                    </div>
                                                    <!-- ------------------------------------- [원산지 pro_origin section]--------------------------------------- -->
                                                    <div id="test" class="form-group">
                                                    	<div class="column_name">
                                                    		원산지
                                                    	</div>
                                                        <input type="text" class="form-control " placeholder="원산지를 입력하세요" id="pro_origin" name="pro_origin" value="${bean.pro_origin }">
                                                        <span class="valid_check" id="err_pro_origin"></span>
                                                    </div>
                                                    <!-- ------------------------------------- [재고 pro_stock section]--------------------------------------- -->
                                                    <div class="form-group">
                                                    	<div class="column_name">
                                                    		재고수량
                                                    	</div>
                                                        <input type="text" class="form-control" placeholder="등록하실 재고수량을 입력하세요" id="pro_stock" name="pro_stock" value="${bean.pro_stock }">
                                                        <span class="valid_check" id="err_pro_stock"></span>
                                                    </div>
                                                    <!-- ------------------------------------- [가격 pro_price section]--------------------------------------- -->
                                                    <div class="form-group">
                                                    	<div class="column_name">
                                                    		가격
                                                    	</div>
                                                        <input type="text" class="form-control" placeholder="상품 1개당 가격을 입력하세요" id="pro_price" name="pro_price" value="${bean.pro_price }">
                                                        <span class="valid_check" id="err_pro_price"></span>
                                                    </div>
                                                    <!-- ------------------------------------- [수업내용 content section]--------------------------------------- -->
                                                    <div class="form-group">
                                                    	<div class="column_name">
	                                                    	내용설명
	                                                    </div>
                                                        <textarea class="form-control" id="pro_detail" name="pro_detail" placeholder="상품 설명">${bean.pro_detail}</textarea>
                                                        <span class="valid_check" id="err_pro_detail"></span>
                                                    </div>
                                                    <ul class="list-inline pull-right">
                                                        <li class="step-li"><button type="button" id="modalbtn1" class="btn btn-default next-step"  data-toggle="modal" data-target="#myModal" onclick="next_check1();">다음 단계</button></li>
                                                    </ul>
                                                </div>    
                                                <%-- ============================= step2 ==========================================================================--%>
                                                <div class="tab-pane wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.6s" role="tabpanel" id="step2">
                                                    <h4 class="subtitle sub_steptitle">상품 이미지를 수정하세요.</h4>
                                                    <!-- ------------------------------------- [사진  pro_pic section]--------------------------------------- -->
                                                    <%-- ======================구분선===================== --%>
                                                    <div class="file-upload">
                                                    	<div class="oldimage" align="center">
                                                    	<input name = "oldimg" type="text" value="${bean.pro_pic}" id="oldimg">
                                                    	<img alt="기존이미지" src="${contextPath}/upload/${bean.pro_pic}" width="200" height="200" align="middle">
                                                    	</div>
												        <button class="file-upload-btn" type="button" data-toggle="tooltip" title="썸네일 사진을 업로드 해주세요!" onclick="$('#p_img').trigger( 'click' )">
												        	사진 수정
												        </button>
												
												        <div id="main_wrap" class="image-upload-wrap"> 
												            <input class="file-upload-input" id="p_img" name="p_img"  type='file' onchange="readURL_main(this);" accept="image/*" value="${bean.pro_pic }">
												            <div class="drag-text">
												            <h3><i class="fas fa-paperclip"></i></h3>
												            </div>
												        </div>
												        <div id="main_content" class="file-upload-content">
												            <img class="file-upload-image" id="p_image" alt="your image" src="./upload/${bean.pro_pic }"/>
												            <div class="image-title-wrap">
													            <button type="button" onclick="removeUpload_main()" class="remove-image" data-toggle="tooltip" title="클릭 하면 삭제됩니다!">
													            	<span id="main_title" class="image-title">이미지 이름</span>
													            </button>
												            </div>
												        </div>
												    </div>
	                                                    
                                                    <ul class="list-inline pull-right">
                                                        <li class="step-li"><button type="button" class="btn btn-default prev-step">이전 단계</button></li>
                                                    </ul>
                                                    <div id="submit">
                                                    	<input type="submit" id="contact-submit-css" class="btn btn-default btn-send" value="수정하기" 
                                                    	onclick="return updateCheck();">
                                                    </div>
                                                </div>
                                                
                                                
                                                <%-- ============================= step4 ==========================================================================--%>
                                                <div class="tab-pane wow fadeInDown" data-wow-duration="500ms" data-wow-delay="0.8s" role="tabpanel" id="complete">
                                                    <h3>수정하기</h3>
                                                    <p>성공적으로 수정이 되었습니다.</p>
                                                </div>
                                                <div class="clearfix"></div>

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