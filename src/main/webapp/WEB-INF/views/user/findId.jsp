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

 <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
  
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="<c:url value="/resources/css/userCSS/login.css"/>" rel="stylesheet">

<style type="text/css">
li{
	list-style: none;
	list-style-type: none;
}

  
  .icon_ul {
      display: flex;
      justify-content: center;
  }
  
  .icon_ul li{
  
  	margin:  0 40px;
  }
</style>
<script type="text/javascript">
$(document).ready(function(){
	fnFindId();
});
function fnFindId(){
	$('#search_btn').click(function(){
		let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}$/;
		if ( regEmail.test($('#email').val()) == false ) {
			alert('이메일 형식을 확인하세요.');
			$('#search_result').text('');
			return;
		}
		$.ajax({
			url: '/restaurant/user/findId',
			type: 'post',
			data: 'email=' + $('#email').val(),
			dataType: 'json',
			success: function(map) {
				if(map.result >0){
					$('#search_result').text("회원님의 아이디는 " + map.result.id + "입니다!");
				} else {
					alert('일치하는 아이디가 없습니다.');
					return false;
				}
			},
			error: function(xhr) {
				$('#search_result').text(xhr.responseText);
			}
		});
	});
}
 </script>
 <style>
 	#search_result{
 		color: green;
 		font-size: 18px;
 		font-weight: bold;
 	}
 </style>

</head>
<body>

   <div id="root" class="root">
      <!-- 맨윗부분 -->
      <header class="shareit_header"> 
         <div>
            <a class="header-logo" href="/restaurant"><img src="/restaurant/resources/image/join/FindTableLogo.png" alt="shareit-logo"></a> 
            <a class="header-logo1" href="/restaurant"><img src="/restaurant/resources/image/join/rightaway.svg" alt="파인드테이블">&nbsp;&nbsp;FindTable 사이트 가기</a> 
         </div>
      </header>
      <div style="
        background-image: url(/restaurant/resources/image/join/background.png) ;
        background-color: 색상이름 또는 코드;
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100vh;
        background-size: cover;
        z-index: -1;">
		</div>
      
     
      <div>
         <main class="mainlogin"> 
            <div class="sc-kmisXD blbgsK">
               <img src="/restaurant/resources/image/join/FindTableLogo.png" alt="findtablelogo">
            </div>
      
            <div class="welcomelogin"> 
                  <div class="title">아이디 찾기</div>
                  <p>😁&nbsp;&nbsp;환영합니다.&nbsp;무엇을 도와드릴까요?&nbsp;&nbsp;😁</p> 
            </div>
            
            
            
			 <label for="email" class="loginMiddle">
             <span>이메일</span>
             <input type="text" name="email" id="email" placeholder="가입 당시 이메일을 입력해주세요."></label>
			<input type="button" value="아이디찾기" id="search_btn" class="LoginEnter"><br><br>
			
			<div id="search_result"></div>
			
			<div>
				<p class="loginBottom">더 많은 서비스를 누려보세요!&nbsp;&nbsp;&nbsp;<a href="/restaurant/user/loginPage">로그인하러가기</a></p> 
				
			</div>
			
			<hr>
			
      	</main>	
    </div>
    </div>
               
		
</body>
</html>