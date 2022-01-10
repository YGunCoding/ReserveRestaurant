<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="<c:url value="/resources/css/qnaBoardCSS/qnaList.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/index.js"/>"></script>
 <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    fnhover();
	    fnQuickMenu();
		fnInsertPage();
		fnSearchSetting();
	
	});
	


    function fnQuickMenu() {
        var currentPosition = parseInt($(".quickmenu").css("top"));
        $(window).scroll(function() {
            var position = $(window).scrollTop();
            $(".quickmenu").stop().animate({
                "top": position + currentPosition + "px"
            }, 1000);
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
	
	function fnInsertPage() {
		$('#insert_btn').click(function() {
			location.href='/restaurant/qnaboard/insertPage';
		})
	}
	
	// 검색 기본 세팅
	function fnSearchSetting() {
		$('#search_btn').click(function() {
			if ( $('#column').val() == '' ) {
				alert('검색 카테고리를 선택하세요')
				return;
			} else if ( $('#query').val() == '' ) {
				alert('검색어를 입력하세요')
				return;
			}
			$('#search_form').submit();
		})	
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

                <li><a href="/restaurant/admin/searchPage"><i class="fas fa-search fa-lg"></i></a></li>

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



	<div class="qna_title">
        <span>Q&A</span>
    </div>
    <div class="search_box">
        <form action="/restaurant/qnaboard/searchQna" id="search_form">
        	<select id="column" name="column" class="column">
        		<option value="" selected>::: 선택 :::</option>
        		<option value="QNA_WRITER">작성자</option>
        		<option value="QNA_TITLE">제목</option>
        		<option value="QNA_CONTENT">내용</option>
        	</select>
            <input type="text" class="search_text" id="query" name="query">
            <div class="icon_box" id="search_btn">
                <i class="fas fa-search" class="search_btn"></i>
            </div>
        </form>
    </div>
    <div class="qna_list">
        <table class="list_table">
            <thead>
                <tr>
                    <td class="head_no">글 번호</td>
                    <td class="head_writer">작성자</td>
                    <td class="head_title">제목</td>
                    <td class="head_date">등록일</td>
                    <td>조회수</td>
                </tr>
            </thead>
            <tbody>
            	<c:if test="${empty list}">
            		<tr rowspan="5">
            			<td colspan="5" class="emptyQna">등록된 Q&A가 없습니다</td>
            		</tr>
            	</c:if>
            	<c:if test="${not empty list}">
	                <tr>
	                    <td class="body_td">${list[0].qnaNo}</td>
	                    <td>${list[0].qnaWriter}</td>
	                    <td>
	                    	<a href="/restaurant/qnaboard/updateQnaHit?qnaNo=${list[0].qnaNo}">${list[0].qnaTitle}</a>
	                    </td>
	                    <td>${list[0].qnaDate}</td>
	                    <td>${list[0].qnaHit}</td>
	                </tr>
	                <tr>
	                    <td class="body_td">${list[1].qnaNo}</td>
	                    <td>${list[1].qnaWriter}</td>
	                    <td>
	                    	<a href="/restaurant/qnaboard/updateQnaHit?qnaNo=${list[1].qnaNo}">${list[1].qnaTitle}</a>
	                    </td>
	                    <td>${list[1].qnaDate}</td>
	                    <td>${list[1].qnaHit}</td>
	                </tr>
	                <tr>
	                    <td class="body_td">${list[2].qnaNo}</td>
	                    <td>${list[2].qnaWriter}</td>
	                    <td>
	                    	<a href="/restaurant/qnaboard/updateQnaHit?qnaNo=${list[2].qnaNo}">${list[2].qnaTitle}</a>
	                    </td>
	                    <td>${list[2].qnaDate}</td>
	                    <td>${list[2].qnaHit}</td>
	                </tr>
	                <tr>
	                    <td class="body_td">${list[3].qnaNo}</td>
	                    <td>${list[3].qnaWriter}</td>
	                    <td>
	                    	<a href="/restaurant/qnaboard/updateQnaHit?qnaNo=${list[3].qnaNo}">${list[3].qnaTitle}</a>
	                    </td>
	                    <td>${list[3].qnaDate}</td>
	                    <td>${list[3].qnaHit}</td>
	                </tr>
	                <tr>
	                    <td class="body_td">${list[4].qnaNo}</td>
	                    <td>${list[4].qnaWriter}</td>
	                    <td>
	                    	<a href="/restaurant/qnaboard/updateQnaHit?qnaNo=${list[4].qnaNo}">${list[4].qnaTitle}</a>
	                    </td>
	                    <td>${list[4].qnaDate}</td>
	                    <td>${list[4].qnaHit}</td>
	                </tr>
            	</c:if>
            </tbody>
            <tfoot class="paging_foot">
                <tr class="paging_tr">
                    <td colspan="5" class="paging_td">${paging}</td>
                </tr>
            </tfoot>
        </table>
    </div>
    <c:if test="${not empty loginUser}">
	    <div class="btn_box">
	        <input type="button" class="insert_btn" value="작성하기" id="insert_btn">
	    </div>
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
                        <a href="#" target="_blank">
                  			<img src="/restaurant/resources/image/index/projectlogo.png" class="logo_box">
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