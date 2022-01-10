<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>

<link href="<c:url value="/resources/css/userCSS/myPage.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/css/userCSS/datail.css"/>" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
	
	
	
<script type="text/javascript">

$(document).ready(function () {
	
	
	fnPaygogo();

	
	
	
	
	
  });// 페이지로드 끝
  
  function fnPaygogo() {
		
		$('#pay_btn').on('click',function () {
			var IMP = window.IMP;
	        IMP.init('imp27170655');

	        IMP.request_pay({
	            pg: 'kakao',
	            merchant_uid: 'merchant_' + new Date().getTime(),
	            name: '예약금',
	            amount: 1,
	        }, function (rsp) {
	            console.log(rsp);
	            if (rsp.success) {
	                var msg = '결제가 완료되었습니다.';
	                msg += '**결제 금액: ' + rsp.paid_amount+'원**';
	                let pay = JSON.stringify({
	    				userNo : $('#userNo').val(),
	    				resNo : $('#resNo').val(),
	    				amount : 1,
	    				payName : '예약금',
	    				id : $('#id').val(),
	    				payMethod : 'card',
	    				bookNo :  $('#bookNo').val()
	    			});
	                $.ajax({
	                    url: '/restaurant/user/gogopay', 
	                    type: 'post', 
	                    data:  pay,
	                    contentType : 'application/json',
	                    dataType : 'json',
	                	success : function (map) {
	    					if(map.result > 0){
	    						alert('성공.');
	    					} else{
	    						
	    						alert('실패');
	    					}
	    				},
	    				error : function (xhr) {
	    					alert('서버실패');
	    				}
	                });
	            } else {
	                var msg = '결제에 실패하였습니다.';
	                msg += '에러내용 : ' + rsp.error_msg;
	            }
	            alert(msg);
	           // document.location.href="/user/mypage/home"; //alert창 확인 후 이동할 url 설정
	        });
	    });
}//fn paygogo end
		

</script>
  <style>
  
  
  	.no{
  	   display: none
  	}
  	
  	.ok{
  		display: inline-block;
  	
  	}
	a {
	    text-decoration: none;
	    color: inherit;
	    font-weight: normal;
	}
	
	.page_area{
		display: flex;
		margin-left: 220px;
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
                    <h2 class="ing_title"> 예약 목록</h2>
                </div>
         
                <hr>
               
               <c:if test="${empty bookingInfo}">
	                <div>
	                    <div class="empty_box">
	                        <img class="empty_img" src="/restaurant/resources/image/myPage/mangirl.png " width="200px" height="200px" alt="빈사진 "><br>
	                        <p>예약이 비어있습니다.</p>
	                    </div>
	                </div>
                </c:if>
                
                 <table class="table table-hover">
					 <thead>
						<tr>
							 <th scope="col">예약번호</th>
							 <th scope="col">식당명</th>
							 <th scope="col">인원수</th>
							 <th scope="col">예약날짜</th>
							 <th scope="col"></th>
						</tr>
					</thead>
					<tbody>
						 <c:if test="${not empty bookingInfo}">
							<c:forEach var="booking" items="${bookingInfo}">
									<c:if test="${booking.bookState == 6}">
									<tr>	
										<th scope="row">${booking.bookNo}</th>
										<td>
											  <a href="/restaurant/book/selectBookingDetail?resNo=${booking.resNo}" class="btn btn-light">${booking.restaurant.resName}</a>
										</td>
										<td>${booking.bookPeople}</td>
										<td>${booking.bookDate}</td>
										<td>
										<input type="button" value='예약금결제' id="pay_btn" onclick="fnPaygogo()" >
										<input type="button" value='취소' id="cancel_btn" onclick="location.href='/restaurant/book/bookingCancel?bookNo='+${booking.bookNo}">
										</td>
									</tr>
									</c:if>
									 <input type="hidden" id="resNo" value="${booking.resNo}">
									 <input type="hidden" id="bookNo" value="${booking.bookNo}">
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
	    
	    
	    
	    
	    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	 
	    <input type="hidden" id="id" value="${loginUser.id}">
	    <input type="hidden" id="tel" value="${loginUser.tel}">
	    <input type="hidden" id="email" value="${loginUser.email}">
	    <input type="hidden" id="userNo" value="${loginUser.userNo}">
	    
	    	
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
</body>
</html>