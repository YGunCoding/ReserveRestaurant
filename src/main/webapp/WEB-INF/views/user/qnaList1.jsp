<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="<c:url value="/resources/css/userCSS/myPage.css"/>" rel="stylesheet">

<style>

body{
	font-family: nanumsquare;
}
 a {
    text-decoration: none;
    color: black;
}

a:hover {
    cursor: pointer;
    color:black;
}
/*question 테이블 작업*/
table{
    width: 100%;
}
.question_btn{
    display: flex;
}
.store_question, .reserve_question{
    width: 300px;
    margin:0 auto;
    padding: 5px ;
    text-align: center;
}


thead{
    text-align: center;
}

.question_table td{
    border-bottom: 1px solid gray;
}
/* table td:first-child{
    width: 250px;
} */


.addtable td:first-child{
	width:250px
}

select{
    padding:4px;
}

.address_box{
	margin:3px;
}
.address_box input{
	width: 308px;
}
.address{
	margin-right:30px;
}

.infobox td:first-child{
	width:200px;
} 
.infobox input{
	width:250px;
}
#check_id, #check_pw{
	width:100px;
    background-color: #da5e531605738;
    border: none;
    color: gray;
    padding: 5px;
    border-radius: 10px;
}
#check_id:hover, #check_pw:hover{
    cursor: pointer;
}
.empty_content{
	padding: 5px;
}
.list_table{
	border:1px solid gray;
	margin: 10px;
	border-radius:30px;
}

.list_table:hover{
	cursor:pointer;
}
.list_table td:first-child{
	width:300px;
}
.paging{
	width: 100%;
	color: rgb(160, 57, 38);
	text-align: center;
    margin: 30px;
}
.listimg{
	width:300px;
	height: 250px;
	border-radius: 10px;
}
.listtitle{
	text-align:center;
	padding-top: 15px;
}
.qnatable{
	width:100%	
}
.question_table td{
	text-align:center;
}
/* .question_table td:first-child{
	width:20%;
} */
.qnatable td:first-child.{
	width:100px;
}
.qnatable input, .qnatable textarea{
	border: none;
	outline: none;
}
.qnatable td{
	border-bottom:0.5px solid silver;
}
.comment{
	display: flex;
	margin: 10px;
	flex-flow:row nowrap;
	justify-content:space-between;
	text-align:center;
}
.commenttitle{
	font-size:14px;
	width:100px;
	height:30px;
	margin: 20px 0 0 0;
	padding:10px;
}
.content_btn{
	width:30px;
	background-color: silver;
	padding:10px
}
.bottombtn{
	display:flex;
	text-align:center;
}
.titletable{
	width:45%;
}
		
.store_question:hover, .reserve_question:hover{
    background-color: rgba(160, 57, 38, 0.795);
    color: white;
    border-radius: 30px;
    cursor: pointer;
}
table{
	font-size: 16px;
}
    </style>

<script>
$(document).ready(function () {
	$('#new_state2').click(function () {
		$('#qnaState').val(2);
	})
	$('#new_state3').click(function () {
		$('#qnaState').val(3);
	})
	
	
});


</script>
</head>
<body>
  
      <header>
        <div class="wrap">
            <h1 id="header_h1">
                <a href="/restaurant">
                    <img src="/restaurant/resources/image/index/projectlogo.png">
                </a>
            </h1>
            <ul id="gnb">
            
            	<li><a href="/restaurant/admin/searchPage"><i class="fas fa-search fa-lg"></i></a></li> 
            	
                	<c:if test="${loginUser == null}">
	                <li><a href="/restaurant/user/loginPage">LOGIN&nbsp;&nbsp;&nbsp;/</a></li>
	                <li><a href="/restaurant/user/join">JOIN&nbsp;&nbsp;&nbsp;</a></li>
            	</c:if>
            	
            	<!-- 사용자 state =1 -->
            	<c:if test="${loginUser.state == 1}">
            			<li>${loginUser.id} 님 환영합니다</li>
            		  <li><a href="/restaurant/user/logout">LOGOUT&nbsp;&nbsp;&nbsp;/</a></li>
            		  <li><a href="/restaurant/user/myPage">MYPAGE&nbsp;&nbsp;&nbsp;</a></li>
            	</c:if>
            	
            	<!-- 관리자 state 2 -->
            	<c:if test="${loginUser.state == 2}">
            		  <li>${loginUser.id} 님 환영합니다</li>
            		  <li><a href="/restaurant/admin/myPage">ADMIN PAGE</a></li>
            	</c:if>
            	
            	<!-- 사업자는 어떻게? -->
              <c:if test="${loginUser.state == 3}">
            		  <li>${loginUser.id} 님 환영합니다&nbsp;&nbsp;&nbsp;/</li>
            		  <li><a href="/restaurant/owner/logout">LOGOUT&nbsp;&nbsp;&nbsp;/</a></li>
            		  <li><a href="/restaurant/owner/managePage">OWNER PAGE</a></li>
            	</c:if>
                
         
            </ul>
        </div>
    </header>
       
   
    <div class="container">
        <div class="row">
            <div class="col-4">
                <div class="menu_nav">
                    <h2 class="menu_title">예약내역</h2>
                    <ul>
                         <li><a href="/restaurant/book/selectBookingList?userNo=${loginUser.userNo}" class="menu_sub_title">예약완료</a></li>
                        <li><a href="/restaurant/book/findCancelList" class="menu_sub_title">예약취소내역 / 환불</a></li>
                        <li><a href="/restaurant/user/PayListPage" class="menu_sub_title">결제내역</a></li>
                    </ul>
                </div>
                <div class="menu_nav"> 
                    <h2 class="menu_title">My 활동</h2>
                    <ul>
                        <li><a href="/restaurant/user/findQnaList">문의 내역</a></li>
                        <li><a href="/restaurant/user/goCartPage">찜 목록</a></li>
                    </ul>
                </div>
                <div class="menu_nav">
                    <h2 class="menu_title">내 정보</h2>
                    <ul>
                        <li><a href="/restaurant/user/updateUser">내 정보 수정</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="col-6">
                 
                <div>
                    <h3 class="ing_title" style="font-size: 30px" >예약에 대해 문의 하셨습니다 !</h3>
                </div>
                <hr>
                <div>
                    <ul class="question_btn">
                           <li class="store_question"><a href="/restaurant/user/findQnaList?qnaWriter=${loginUser.name}">식당 정보 문의</a></li>
                        <li class="reserve_question"><a href="/restaurant/user/findQnaList1?qnaWriter=${loginUser.name}">예약 문의</a></li>
                    </ul>
                    <table class="table table-hover" style="text-align: center;">
					 <thead>
						<tr>
							 <th scope="col">번호</th>
							 <th scope="col">작성자</th>
							 <th scope="col"><i class="fas fa-mouse"></i>&nbsp;제목</th>
							 <th scope="col">작성일자</th>
						</tr>
					</thead>
					<tbody>
							<c:if test="${empty list}">
								<tr>
									<th scope="col" colspan="5">문의내역 없음</td>
								</tr>
							</c:if>
						<c:if test="${not empty list}">
									<c:forEach var="qna" items="${list}">
										<c:if test="${qna.qnaState ==3}">
											<tr>
												<th scope="col">${qna.qnaNo}</th>				
												<td>${qna.qnaWriter}</td>
												<td class="titletable"><a href="findQnaByNo?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a></td>
												<td>${qna.qnaDate}</td>
											</tr>
										</c:if>
									</c:forEach>
								</c:if>
						</tbody>
					</table>
					<div class="page_area">
					    <c:if test="${not empty paging}">
						    ${paging}
					    </c:if>
					</div>
			
                    
                    
         </div>
        
     </div>
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