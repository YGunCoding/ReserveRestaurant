<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css" integrity="sha512-4wfcoXlib1Aq0mUtsLLM74SZtmB73VHTafZAvxIp/Wk9u1PpIsrfmTvK0+yKetghCL8SHlZbMyEcV8Z21v42UQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<link href="<c:url value="/resources/css/index.css"/>" rel="stylesheet">
	<link href="<c:url value="/resources/css/owner.css"/>" rel="stylesheet">
	<script src="<c:url value="/resources/js/index.js"/>"></script>
	<script src="<c:url value="/resources/js/owner.js"/>"></script>
	
	<style>
		 #contentBtn, .contentBtn{
			width: 70px;
		    background-color: rgb(230, 225, 225);
		    border: none;
		    color: gray;
		    padding: 5px;
		    margin: 5px;
		    border-radius: 10px;
		}
		#list_btn:hover{
			background-color:  rgba(160, 57, 38, 0.795);
		}
		.bottombtn{
			   justify-content: center;
		}
		.qnatable td:first-child{
			text-align:center;
		}
		.reviewimg{
			width:200px;
			height:200px;
		}
		.commentTitle{
			line-height:70px;
		}
		.containerForm{
			margin:30px 0;
		}
		.commentBorder{
			border-bottom: 1px solid rgb(230, 225, 225);
			border-top: 1px solid  rgb(230, 225, 225);
			margin:10px 0;
			padding: 10px;
		}
		.updateDeleteLink, .updateDeleteLink2{
			display:flex;
		}
		.updatelink, .deletelink{
			color:gray;
			margin:0 10px;
		}
		.commentContent{
			padding: 5px 0 ;
		}
		.updateDeleteLink2{
			margin-left: 100px;
		}
		.commentTextarea{
			padding: 5px;
			width: 700px;
			border: 1px solid  rgb(230, 225, 225);
		}
		
	</style>
	<script>
		$(document).ready(function(){
			commentList(); 
			
		 	$('#contentBtn').click(function(){
				var insertData = $('#commentForm').serialize();
				commentInsert(insertData);
			}); 
		 });
	
		//댓글 목록
	  	function commentList(){
			$.ajax({
				url:'/restaurant/owner/list?reviewNo=${review.reviewNo}' ,
				type:'get',
				success: function(commentlist){
					var a='';
					$.each(commentlist, function(i, comment){
						a += '<div class="commentBorder">';
						a += '<div class="updateDeleteLink"><input class="commentNo" type="hidden" value="' + comment.commentNo + '">'+' 사장님 성함 : '+ comment.writer
		                a += '<div class="updateDeleteLink2"><a onclick = "commentUpdate('+ comment.commentNo +',\''+ comment.content +'\')" class="updatelink"><i class="far fa-edit"></i>&nbsp; 수정 </a>';
		                a += '<a onclick = "commentDelete('+ comment.commentNo+ ')" class="deletelink"> <i class="far fa-trash-alt"></i> &nbsp;삭제 </a> </div></div>';
		                a += '<div class="commentContent" id="commentContent'+comment.commentNo+'"> <p> 작성 내용 : ' + comment.content + '</p>';
		                a += '</div></div>';
					});
					$(".commentList").html(a);
				}
			});
		}    
		
	//댓글 등록
		function commentInsert(insertData){
			$.ajax({
				url:'/restaurant/owner/insert?'+ insertData,
				type: 'get',
				success: function(data){
					if(data == 1){
						commentList();
						$('#content').val('');
						}
					}
				});
			}
	 
	//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경
 	function commentUpdate(commentNo, content){
		var a = '';
		a += '<div class="comment">';
	    a += '<input type="text" class="commentTextarea" name="contentInput" value="' + content + '"/>';
	    a += '<button class="contentBtn" onclick="commentUpdateProc('+ commentNo +')">수정하기</button>';
	    a += '</div>';
	    
		$('#commentContent' + commentNo).html(a);
	}  
	
	//댓글 수정
	function commentUpdateProc(commentNo){
		var updateContent = $('[name=contentInput]').val();
		$.ajax({
			url : '/restaurant/owner/update',
			type: 'post',
			contentType: 'application/json',
			data: JSON.stringify({
				'content' : updateContent, 
				'commentNo': commentNo}),
	        success : function(data){
	            if(data == 1) commentList();
	        }
	    });
	} 
	 
	//댓글 삭제 
	 function commentDelete(commentNo){
		if(confirm('삭제하시겠습니까?')){			
		    $.ajax({
		        url : '/restaurant/owner/remove?commentNo=' + commentNo,
		        type : 'get',
		        success : function(data){
	            if(data == 1) commentList();
		        }
		    });
		}
	} 

	
	</script>
</head>
<body>
    <header>
        <div class="wrap">
            <h1>
                <a href="/restaurant/">
                    <img src="/restaurant/resources/image/index/projectlogo.png">
                </a>
            </h1>
            <ul id="gnb">
               	<li><a href="/restaurant/owner/logout">LOGOUT</a></li>
                <li><a href="/restaurant/owner/managePage">MYPAGE</a></li>
            </ul>
        </div>
    </header>
    <div class="container">
        <div class="row">
            <div class="col-4">
                <div class="menu_nav">
                    <h4 class="menu_title">나의 사업장</h4>
                    <ul>
                        <li><a href="addPage" class="menu_sub_title">등록하기</a></li>
                        <li><a href="managePage" class="menu_sub_title"> 사업장 관리</a></li>
                    	<li><a href="bookPage" class="menu_sub_title"> 예약 관리</a></li>
                    </ul>
                </div>
                <div class="menu_nav">
                    <h4 class="menu_title">My 활동</h4>
                    <ul>
                        <li><a href="questionPage">문의 내역</a></li>
                        <li><a href="reviewPage">리뷰 관리</a></li>
                    </ul>
                </div>
                <div class="menu_nav">
                    <h4 class="menu_title">내 정보</h4>
                    <ul>
                        <li><a href="modifyPage">내 정보 수정</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-6">
                <div class="section2">
                    <h4 class="ing_title">리뷰 내용</h4>
                </div>
                <hr>
                   <div class="containers">
                     <div class="col-sm-9">
                        <table class="qnatable">
                          <tbody>
                             <tr>
                                <td style="background-color:rgb(230, 225, 225);">작성자</td>
                                <td colspan="3"><input type="text" value="${review.reviewWriter}" id="reviewWriter" readonly></td>
                             </tr>
                             <tr>
                                 <td style="background-color:rgb(230, 225, 225);">작성일</td>
                                  <td><input type="text" value="${review.reviewDate}" id="reviewDate" readonly></td>
                                	<td style="background-color:rgb(230, 225, 225);">평점</td>
                                 <td><input type="text" value="★ ${review.reviewRate}" id="reviewRate" readonly></td>
                             </tr>
                              <tr>
                              <!-- 다중 첨부할거아닌가요 유정아 -->
                                <td style="background-color:rgb(230, 225, 225);">리뷰 사진</td>
                                <td colspan="3">
                                		<img alt="${review.reviewOrigin}" src="/restaurant/${review.reviewPath}/${review.reviewSaved}" class="reviewimg">
                                </td>
                             </tr>
                             <tr>
                                <td style="background-color:rgb(230, 225, 225);">리뷰 내용</td>
                                <td colspan="3"><textarea rows="3" cols="70" name="qnaContent" readonly>${review.reviewContent}</textarea></td>
                             </tr>
                          </tbody>
                       </table>
						<div class="replyInput">
	                            <form id="commentForm"> 
	                             	<div class="comment">
	                            		<div class="commentTitle">댓글달기</div>
	                            		<input type="hidden" value="${review.reviewNo}" name="reviewNo">
	                            		<input type="hidden" value="${loginUser.name}" name="writer">
	                            		<textarea class="commentTextarea" id="content" rows="3" cols="70" name="content" placeholder="댓글을 남겨보세요"></textarea>
	                            		 <button id="contentBtn">댓글 <br> 등록</button>
	                            	</div>
	                          	</form>
						</div>
                         <div class="containerForm">
						    <div id="commentListForm">
						        <div class="commentList">
						        </div>
						    </div>
						</div>
		                           
                    	   <div class="bottombtn">
	                          <input type="button" value="목록보기" id="list_btn" >
	                          <input type="reset" value="삭제하기" id="delete_btn">
                      	   </div>
                     </div>
                  </div> 
            </div>    
        </div> 
    </div>
    <script>
    	
	    $('#list_btn').on('click', function(){
	    	alert('목록으로 이동');
	    	location.href='/restaurant/owner/reviewPage'
	    });
	    
	    $('#delete_btn').on('click',function(){
	        if(confirm('게시글을 삭제할까요?')){
	            alert( '삭제했습니다.');
	            $('#reviewform').attr('action', 'deleteReview');
	            $('#reviewform').submit();
	       	 }
   		 });
    </script>
    <section id="bottom">
        <div class="wrap">
            <div class="footer">
                <div class="footer_inner">
                    <ul class="footer_link">
                        <li><a href="#" target="_blank" class="footer_item">이용약관&nbsp;|</a></li>
                        <li><a href="#" target="_blank" class="footer_item">개인정보처리방침&nbsp;|</a></li>
                        <li><a href="#" target="_blank" class="footer_item">책임의 한계와 법적고지&nbsp;|</a></li>
                        <li><a href="#" target="_blank" class="footer_item">회원정보 고객센터</a></li>
                    </ul>
                    <div class="footer_copy">
                        <a href="#" target="_blank">
                            <img src="/restaurant/resources/image/index/projectlogo.png" alt="logo">
                        </a>
                        <span class="text">Copyright</span>
                        <span class="corp" style="font-weight: 800;">&copy; FindTable Corp.</span>
                        <span class="text">All Rights Reserved.</span>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>