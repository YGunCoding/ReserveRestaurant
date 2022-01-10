<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value="/resources/css/adminCSS/main.css"/>" rel="stylesheet">
<script>
	$(document).ready(function() {
		fnLogOut();
	})
	
	function fnLogOut() {
		$('#logOut').click(function() {
			if (confirm('로그아웃 하시겠습니까?')) {
				location.href="/restaurant/user/logout";
			}
		})
	}
</script>
</head>
<body>
    <header>
        <div class="wrap">
            <h1>
                <a href="/restaurant/admin/adminPage">
                    <img src="/restaurant/resources/image/index/projectlogo.png">
                </a>
            </h1>
            <ul id="gnb">
                <li>${loginUser.id} 님 환영합니다</li>
                <li><span id="logOut">LOGOUT&nbsp;&nbsp;&nbsp;</span></li>
            </ul>
        </div>
    </header>
    <div class="go">
        <div class="admin">
            <div class="admin_user">
                <a href="/restaurant/admin/userAdminPage" class="admin_go_link">
                    <span class="admin_go">회원 조회</span>
                </a>
            </div>
            <div class="admin_rest">
                <a href="/restaurant/admin/resAdminPage" class="admin_go_link">
                    <span class="admin_go">사업장 조회</span>
                </a>
            </div>
        </div>
        <div class="go_mainPage">
            <a href="/restaurant/main/mainPage" class="admin_go_link">
                <span class="main_go">메인 페이지 이동</span>
            </a>
        </div>
    </div>


</body>
</html>