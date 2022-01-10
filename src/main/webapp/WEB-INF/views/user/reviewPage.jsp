<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css" integrity="sha512-4wfcoXlib1Aq0mUtsLLM74SZtmB73VHTafZAvxIp/Wk9u1PpIsrfmTvK0+yKetghCL8SHlZbMyEcV8Z21v42UQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<link href="<c:url value="/resources/css/userCSS/detail.css"/>" rel="stylesheet">
<link href="c:<url value="/resources/js/userJS/detail.js"/>" rel="stylesheet">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css" integrity="sha512-4wfcoXlib1Aq0mUtsLLM74SZtmB73VHTafZAvxIp/Wk9u1PpIsrfmTvK0+yKetghCL8SHlZbMyEcV8Z21v42UQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"> 
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<link href="<c:url value="/resources/css/index.css"/>" rel="stylesheet">
	<link href="<c:url value="/resources/css/owner.css"/>" rel="stylesheet">
	<link href="<c:url value="/resources/css/userCSsS/detail.css"/>" rel="stylesheet">
	<script src="<c:url value="/resources/js/index.js"/>"></script>
	<script src="<c:url value="/resources/js/userJS/detail.js"/>"></script>
 <script>
 $(document).ready(function() {
	    fnhover();
	    fnQuickMenu();
	});

	function fnQuickMenu() {
	    var currentPosition = parseInt($(".quickmenu").css("top"));
	    $(window).scroll(function() {
	        var position = $(window).scrollTop();
	        $(".quickmenu").stop().animate({ "top": position + currentPosition + "px" }, 1000);
	    });
	}

	function fnhover() {
	    (function($) {
	        $('.cate ul').hide();
	        $('.cate .menu .subopen').click(function() {
	            if ($(this).hasClass('active')) {
	                $(this).parent().next().slideUp('slow');
	                $(this).removeClass('active');
	            } else {
	                $('.accordion').find('.active').parent().next().slideUp('slow');
	                $('.accordion').find('.active').removeClass('active');
	                $(this).parent().next().slideDown('slow');
	                $(this).addClass('active');
	            }
	        });
	    })(jQuery);
	}
	
 </script>
 
 <style>
	 a{
	 	color: black;
	 	text-decoration:none;
	 	font-weight: normal;
	 }
	 
	 /* component */
	
	.star-rating {
	  display:flex;
	  flex-direction: row-reverse;
	  font-size:1.5em;
	  justify-content:space-around;
	  padding:0 .2em;
	  text-align:center;
	  width:5em;
	}
	.col-6 {
	    width: 700px;
	}
	.star-rating input {
	  display:none;
	}
	
	.star-rating label {
	  color:#ccc;
	  cursor:pointer;
	}
	
	.star-rating :checked ~ label {
	  color:#f90;
	}
	
	.star-rating label:hover,
	.star-rating label:hover ~ label {
	  color:#fc0;
	}
 	#reviewbtn{
	 	width: 100px;
	    background-color: rgb(160, 57, 38);
	    border: none;
	    color: white;
	    padding: 5px;
	    margin: 30px 5px;
	    border-radius: 10px;
 	}
 	.reviewdone_btn{
 		font-size:16px;
 		width:150px;
 		background-color: rgb(160, 57, 38);
	    border: none;
	    color: white;
	    padding: 7px;
	    margin:5px;
	    border-radius: 10px;
	    
 	}
 	.main_image{
 		padding:0;
 		width:200px;
 	}
 	
 	.returndetailbtn{
 		font-size:16px;
 		width:160px;
 		background-color: rgb(160, 57, 38);
	    border: none;
	    color: white;
	    padding: 7px;
	    margin:5px;
	    border-radius: 10px;
 	}
 </style>
</head>
<body>

	
	  <header>
        <div class="wrap">
            <h1 style="padding-top: 0">
                <a href="/restaurant/" >
                    <img  src="/restaurant/resources/image/index/projectlogo.png">
                </a>
                
            </h1>
            <ul id="gnb">
            
            		<li><a href="/restaurant/user/search"><i class="fas fa-search fa-lg"></i></a></li>
            
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
            		  <li>${loginUser.id} 님 환영합니다&nbsp;&nbsp;&nbsp;/</li>
            		  <li><a href="/restaurant/admin/adminPage">ADMIN PAGE</a></li>
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
                <li><a href="/restaurant/user/search"> 식당 검색  </a></li>
                <li><a href="식당검색페이지"> 할인 되는 식당</a></li>
                <li><a href="/restaurant/user/reserve"> 신규 오픈 </a></li>
            </ul>
        </div>
        <div class="cate quickmenu">
            <span class="menu"> 
                <a href="#" class="menulink">Board</a>
                <a href="javascript:void(0);" class="subopen"></a>
            </span>
            <ul>
                <li><a href="공지사항"> 공지사항 </a></li>
                <li><a href="리뷰"> 리뷰 </a></li>
                <li><a href="리뷰"> Q&A </a></li>
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
        <div class="container">
		  <div class="row">
		    <div class="col-4">
		     <img alt="${restaurant.resOrigin}" src="/restaurant/${restaurant.resPath}/${restaurant.resSaved}" class="main_image"/>
			 <h3 >${restaurant.resName}</h3>

			 <input type="button" value="식당정보로 돌아가기" class="returndetailbtn" onclick="location.href='/restaurant/user/detail?resNo='+'${restaurant.resNo}'">  	

		    </div>
		    <div class="col-6">
			    <form action="/restaurant/user/insertReview" id="reviewform" method="POST" enctype="multipart/form-data">
			    	<input type="hidden" name="resNo" value="${restaurant.resNo}">
			    	<input type="hidden" name="userNo" value="${loginUser.userNo}">
			    	<table>
			    		<tbody>
			    			<tr>
			    				<td>작성자</td>
			    				<td><input type="text" name="reviewWriter" value="${loginUser.name}"></td>
			    			</tr>
			    			<tr>
                               <td>사진 등록</td>
                               <td>
                                  <input type="file" name="r_file" id="r_file" multiple>
                                  <div id="upload_result"> 
                                 	 	
                                  </div>
                               </td>
			    			<tr>
			    				<td>별점</td>
			    				<td>
									<div class="star-rating">
									  <input type="radio" id="5-stars" name="rating" value="5" />
									  <label for="5-stars" class="star">&#9733;</label>
									  <input type="radio" id="4-stars" name="rating" value="4" />
									  <label for="4-stars" class="star">&#9733;</label>
									  <input type="radio" id="3-stars" name="rating" value="3" />
									  <label for="3-stars" class="star">&#9733;</label>
									  <input type="radio" id="2-stars" name="rating" value="2" />
									  <label for="2-stars" class="star">&#9733;</label>
									  <input type="radio" id="1-star" name="rating" value="1" />
									  <label for="1-star" class="star">&#9733;</label>
									</div>
								</td>
			    			</tr>
			    			<tr>
			    				<td colspan="2"><textarea rows="3" cols="70" name="reviewContent" placeholder="리뷰를 작성해주세요"></textarea></td>
			    			</tr>
			    		</tbody>
			    		<tfoot>
			    		<tr>
				    		<td colspan="2">
				    			 <button class="reviewdone_btn">리뷰 작성 완료</button>
				    		</td>
			    		</tr>
			    		</tfoot>
			    	</table>
			    </form>
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