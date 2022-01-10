<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="<c:url value="/resources/css/adminCSS/newOpen.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/adminJS/searchPage.js"/>"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
	$(document).ready(function() {
		fnPrevent();
		
	})

	function fnPrevent() {
		$('#search_form').submit(function(event) {
			if ($('#query').val() == '') {
				alert('검색어를 입력하세요');
				event.preventDefault();
			}
		})
		
		
	}
</script>
</head>
<body>
	  <header>
        <div class="wrap">
            <h1>
                <a href="/restaurant/main/mainPage">
                    <img src="/restaurant/resources/image/index/projectlogo.png">
                </a>
                
            </h1>
            <ul id="gnb">
            
            	<c:if test="${loginUser == null}">
	                <li><a href="/restaurant/user/loginPage">LOGIN&nbsp;&nbsp;&nbsp;/</a></li>
	                <li><a href="/restaurant/user/join">JOIN&nbsp;&nbsp;&nbsp;</a></li>
            	</c:if>
            	
            	<!-- 사용자 state =1 -->
            	<c:if test="${loginUser != null}">
	            	<c:if test="${loginUser.name != '관리자'}">
	            			<li>${loginUser.id} 님 환영합니다</li>
	            		  <li><a href="/restaurant/user/logout">LOGOUT&nbsp;&nbsp;&nbsp;/</a></li>
	            		  <li><a href="/restaurant/user/myPage">MYPAGE&nbsp;&nbsp;&nbsp;</a></li>
	            	</c:if>
            	</c:if>
            	
            	
            	
            	<c:if test="${loginUser.name == '관리자'}">
            		  <li>${loginUser.id} 님 환영합니다</li>
            		  <li><a href="/restaurant/user/logout">LOGOUT&nbsp;&nbsp;&nbsp;/</a></li>
            		  <li><a href="/restaurant/admin/adminPage">ADMIN&nbsp;PAGE&nbsp;&nbsp;&nbsp;</a></li>
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
   <div class="accordion">
        <div class="cate quickmenu">
            <span class="menu">
                <a href="#" class="menulink">Reservation</a>
                <a href="javascript:void(0);" class="subopen"></a>
            </span>
            <ul>
                <li><a href="/restaurant/admin/searchPage"> 식당 검색  </a></li>
                <li><a href="식당검색페이지"> 할인 되는 식당</a></li>
                <li><a href="/restaurant/admin/newOpen"> 신규 오픈 </a></li>
            </ul>
        </div>
        
        <div class="cate quickmenu">
            <span class="menu"> 
                <a href="#" class="menulink">Board</a>
                <a href="javascript:void(0);" class="subopen"></a>
            </span>
            <ul>
                <li><a href="/restaurant/notice/selectNoticeList"> 공지사항 </a></li>
                <li><a href="리뷰"> 리뷰 </a></li>
                <li><a href="/restaurant/qnaboard/qnaList"> Q&A </a></li>
            </ul>
        </div>
        
        <div class="cate quickmenu">
            <span class="menu">
                <a href="#" class="menulink">Magazines</a>
                <a href="javascript:void(0);" class="subopen"></a>
            </span>
            <ul>
                <li><a href="/restaurant/user/detail">다이닝 매거진</a></li>
            </ul>
        </div>
    </div>
    <section class="search_section">
        <form id="search_form" action="/restaurant/admin/searchRestaurant">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="식당이름 / 지역(OO구 or OO동)" class="search_area" name="query" id="query">
            <button class="search_btn">검색</button>
        </form>
    </section>
    
    <section class="search_comment">
        <p class="comment">가장 최근 등록된 식당입니다.</p>
    </section>    
    
    <c:if test="${not empty list}">
	    <section class="list_section">
	    	<c:forEach var="restaurant" items="${list}">
		        <div class="rest_info">
		            <div>
		               <!-- <img alt="${restaurant.resOrigin}" src="/restaurant/${restaurant.resPath}/${restaurant.resSaved}"> -->
		            </div>
		            <div>
		                <span class="rest_name">
		                	<a href="/restaurant/admin/goResDetail?resNo=${restaurant.resNo}">${restaurant.resName}</a>
		                </span>
		                <span class="rest_time">${restaurant.resOpenTime} ~ ${restaurant.resCloseTime}</span><br>
		                <!-- <p class="rest_address" id="address">${restaurant.resAddress}&nbsp;${restaurant.resAddressDetail}</p>  -->
		                <input type="text" id="address" class="rest_address" value="${restaurant.resAddress}&nbsp;${restaurant.resAddressDetail}" readonly>
		                <!-- 
		                <button class="copy_address">
		                    <i class="far fa-copy"></i>복사
		                </button>
		                 -->
		                <p class="rest_tel">${restaurant.resTel}</p>
		                <p class="rest_option">${restaurant.resOption}</p>
		            </div>
		        </div>
	    	</c:forEach>
	    	<div class="paging_area">${paging}</div>
	    </section>
    </c:if>
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
                        <div>
                            <a href="#" target="_blank" class="footer_logo">
                    			<img src="/restaurant/resources/image/index/projectlogo.png">
                            </a>
                        </div>
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