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
<link href="<c:url value="/resources/css/adminCSS/adminUser.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/index.js"/>"></script>
 <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
	$(document).ready(function() {
		fnFind();
		fnFindAllUser();
		fnFindAllOwner();
	})
	
	
	// 모든 회원 전체 검색
	function fnFindAllUser() {
		$('#all_user_search').click(function() {
			location.href="/restaurant/admin/findAllUser";
		})
	}
	
	// 모든 사업자 회원 전체 검색
	function fnFindAllOwner() {
		$('#all_owner_search').click(function() {
			location.href="/restaurant/admin/findAllOwner";
		})
	}

	
	
	// 검색 함수
	function fnFind() {
		$('#search_btn').click(function(event) {
			if ($('#column').val() == '') {
				alert('검색 카테고리를 선택하세요');
				return;
			} else if ($('#query').val() == '') {
				alert('검색어를 입력하세요')
				return;
			}
			$('#search_form').attr('action', '/restaurant/admin/findUser');
			$('#search_form').submit();
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
                <li>관리자님 환영합니다</li>
                <li><a href="/restaurant/user/logout">LOGOUT&nbsp;&nbsp;&nbsp;/</a></li>
                <li><a href="/restaurant/admin/adminPage">ADMIN&nbsp;PAGE&nbsp;&nbsp;&nbsp;</a></li>
            </ul>
        </div>
    </header>
    <section class="search_section">
        <div class="search_box">
            <p class="user_search">회원 조회</p>
            <form id="search_form" action="/restaurant/admin/findUser">
           		<div class="chose">
	                <select id="column" name="column">
	                    <option value="" selected>:: 선택 ::</option>
	                    <option value="ID">아이디</option>
	                    <option value="NAME">이름</option>
	                    <option value="TEL">전화번호</option>
	                </select>
	                
	                <input type="text" class="select_text" id="query" name="query">
	                <input type="button" value="검색" id="search_btn">
	                <input type="button" value="일반회원 전체검색" id="all_user_search">
	                <input type="button" value="사업자회원 전체검색" id="all_owner_search"> 
	            	<div class="radio">
		                <input type="radio" name="radio" id="user" value="user" checked>
		                <label for="user">일반회원</label>
		
		                <input type="radio" name="radio" id="owner" value="owner">
		                <label for="owner">사업자회원</label>
		            </div>
           		</div>
            </form>
        </div>
    </section>
    <section class="result_section">
        <%@ include file="list.jsp" %>
    </section>

</body>
</html>