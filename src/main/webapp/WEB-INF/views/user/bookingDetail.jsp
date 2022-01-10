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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="<c:url value="/resources/css/userCSS/myPage.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/css/userCSS/datail.css"/>" rel="stylesheet">
	
<style>
 
 		a {
		    text-decoration: none;
		    color: inherit;
		    font-weight: normal;
		}
		.container{
		 border-radius: 10px;
		}
		
		.col{
		 width: 300px;
		 font-family: "nanumsquare";
			font-size: 17px;
			margin: 15px 0;
			text-align: center;
			border-bottom: 1px solid #eaedf0;
		}
		nav{
			display: block;
			margin: 0 auto;
		}
		.detail_text{
			font-family: "nanumsquare";
			font-size: 17px;
			text-align: center;
			font-weight: bold;
		}
		.page_area{
			
			display:flex;
			margin-left: 200px;
			
		}
		
	
		
		
    </style>
    
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
                    <h2 class="menu_title">예약 내역</h2>
                    <ul>
                        <li><a href="/restaurant/book/selectBookingList?userNo=${loginUser.userNo}" class="menu_sub_title">예약완료</a></li>
                        <li><a href="/restaurant/book/findCancelList" class="menu_sub_title">예약취소내역 / 환불</a></li>
                        <li><a href="/restaurant/user/PayListPage" class="menu_sub_title">결제내역</a></li>
                    </ul>
                </div>
                <div class="menu_nav">
                    <h2 class="menu_title">My 활동</h2>
                    <ul>
                        <li><a href="/restaurant/user/findQnaList?qnaWriter=${loginUser.name}">문의 내역</a></li>
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
                    <h2 class="ing_title"> 예약 세부 내역</h2>
                </div>
                <hr>
				<div class="container" style="margin-top: 0;">
	               
	                <c:if test="${detail !=null}">
	                 <c:forEach var="detail" items="${detail}">
						  <div class="row row-cols-2">
						    <div class="col"><span class="detail_text">예약번호</span></div>
						    <div class="col">No.${detail.bookNo}</div>
						    
						    <div class="col"><span class="detail_text">이름</span></div>
						    <div class="col">${loginUser.name}</div>
						   
						    <div class="col"><span class="detail_text">인원</span></div>
						    <div class="col">${detail.bookPeople}명</div>
						   
						    <div class="col"><span class="detail_text">예약타입</span></div>
						    <div class="col">${detail.bookType}</div>
						   
						    <div class="col"><span class="detail_text">예약날짜</span></div>
						    <div class="col">${detail.bookDate}</div>
						   
						    <div class="col"><span class="detail_text">예약시간</span></div>
						    <div class="col">${detail.bookHours}시</div>
						   
						    <div class="col"><span class="detail_text">요청사항</span></div>
						    <div class="col">${detail.bookRequest}</div>
						   
						    <div class="col"><span class="detail_text">식당이름</span></div>
						    <div class="col">${detail.restaurant.resName}</div>
						   
						    <div class="col"><span class="detail_text">연락처</span></div>
						    <div class="col">${detail.restaurant.resTel}</div>
						   
						    <div class="col"><span class="detail_text">주소</span></div>
						    <div class="col">${detail.restaurant.resAddress} ${detail.restaurant.resAddressDetail}</div>
					 	<c:if test="${not empty paging}">
					 		<div class="page_area">
					 			${paging}
					 		</div>	
					    </c:if>
				
						  </div>
	                 </c:forEach>
					 </c:if>
					</div>
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