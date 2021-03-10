<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <script
  src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <style>
  .commentArea{
  	text-align: left;
  }
  </style>
<script>

var num = $("#num").val(); //게시글 번호
 
$('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 
    var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
    commentInsert(insertData); //Insert 함수호출(아래)
});
 
 
 
//댓글 목록 
function commentList(){
    	console.log(num)
	$.ajax({
        url : './comlist.no',
        type : 'post',
     	data : {num:num},
        success : function(data){
            var a =''; 
            $.each(data, function(key, value){ 
                a += '<div class="commentArea col-sm-11" style="border-bottom:1px dotted darkgray; margin-bottom: 5px;">';
                a += '<div class="commentInfo'+value.cnum+'" style="margin-bottom:5px;">' + value.writer+'   ('+value.regdate+')   ';
                a += '<a onclick="commentUpdate('+value.cnum+',\''+value.content+'\');"> 수정 </a>';
                a += '<a onclick="commentDelete('+value.cnum+');"> 삭제 </a>'; 
                a += '</div>';
                a += '<div class="commentContent'+value.cnum+'" style="margin-bottom:5px;">'+value.content;
                a += '</div></div>';
            });
            $(".commentList").html(a);
        },
        error : function(error){
        	console.log(error)
        	alert(error)
        }
    });
}

//댓글 등록
function commentInsert(insertData){
    $.ajax({
        url : './cominsert.no',
        type : 'post',
        data : insertData,
        success : function(data){
            if(data == 1) {
                commentList(); //댓글 작성 후 댓글 목록 reload
                $('[name=content]').val('');
            }
        }
    });
}
  
//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function commentUpdate(cnum, content){
    var a ='';
    
    a += '<div class="input-group">';
    a += '<input type="text" class="form-control" name="content_'+cnum+'" value="'+content+'"/>';
    a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="commentUpdateProc('+cnum+');">수정</button> </span>';
    a += '</div>';
    
    $('.commentContent'+cnum).html(a);
    
}
 
//댓글 수정
function commentUpdateProc(cnum){
    var updateContent = $('[name=content_'+cnum+']').val();
    
    $.ajax({
        url : './comupdate.no',
        type : 'post',
        data : {'content' : updateContent, 'cnum' : cnum},
        success : function(data){
            if(data == 1) commentList(num); //댓글 수정후 목록 출력 
        }
    });
}
function delcheck(){
	
} 
//댓글 삭제 
function commentDelete(cnum){
	if(confirm("삭제하시겠습니까?")){
	$.ajax({
        url : './comdelete.no?cnum='+cnum,
        type : 'get',
        success : function(data){
            if(data == 1) {
            	commentList(num); //댓글 삭제후 목록 출력 
            }else {
            	alert('작성자 본인만 삭제 가능합니다.');
            }
        },
    	error: function(error){
    		console.log(error)
    	}
    });
	}else{
		return false;
	}
	
}
 
$(document).ready(function(){
    commentList(); //페이지 로딩시 댓글 목록 출력 
});
 
</script>