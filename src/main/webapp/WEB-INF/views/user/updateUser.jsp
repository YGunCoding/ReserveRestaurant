<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<link href="<c:url value="/resources/css/userCSS/updateUser.css"/>" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
  <style>
 
 		a {
		    text-decoration: none;
		    color: inherit;
		    font-weight: normal;
		}
    </style>
   <script type="text/javascript">
   
   $(document).ready(function(){
		fnPresentPwCheck();
		fnPwCheck();
		fnPw2Check();
		fnUpdatePw();
		fnLeave();
		fnUpdateUser();
		fnEmailCheck();
		fnInit();
		
		
	});
   	
// 현재 비밀번호 확인 변수와 함수
	let presentPwPass = false;
	function fnPresentPwCheck() {
		$('#pw0').blur(function(){
			$.ajax({
				url: 'presentPwCheck',
				type: 'post',
				data: $('#f').serialize(),
				dataType: 'json',
				success: function(map){
					if (map.result) {
						alert(' 현재 비밀번호와 일치합니다.');
						presentPwPass = true;
					} else {
						presentPwPass = false;
						alert('현재 비밀번호와 일치하지 않습니다. 다시 한번 입력해주세요.');
					}
				}
			});
		});
	}  // end fnPresentPwCheck
	
	// 새 비밀번호 입력 검증 변수와 함수
	let pwPass = false;
	function fnPwCheck() {
		let regPw = /^[a-zA-Z0-9!@#$%^&*()]{8,20}$/;
		$('#pw').keyup(function(){			
			if ( regPw.test($('#pw').val()) == false ) {
				$('#pw_result').text('비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자 등 3종류 이상으로 조합해주세요.').addClass('no').removeClass('ok');
				pwPass = false;
			} else {
				$('#pw_result').text('사용 가능한 비밀번호입니다.').addClass('ok').removeClass('no');
				pwPass = true;
			}
		});
	}  // end fnPwCheck
	
	
	// 새 비밀번호 입력 확인 변수와 함수
	let pwPass2 = false;
	function fnPw2Check(){
		$('#pw2').keyup(function(){			
			if ($('#pw').val() != $('#pw2').val()) {
				$('#pw2_result').text('비밀번호를 확인하세요.').addClass('no').removeClass('ok');
				pwPass2 = false;
			} else {
				$('#pw2_result').text('동일한 비밀번호입니다.').addClass('ok').removeClass('no');
				pwPass2 = true;
			}
		});
	}  // end fnPw2Check
	
	// 비밀번호 변경 함수
	function fnUpdatePw() {
		$('#updatePw1_btn').click(function(){
			if ( presentPwPass == false ) {
				alert('현재 비밀번호를 확인하세요.');
				return;
			}
			else if ( pwPass == false || pwPass2 == false ) {
				alert('새 비밀번호 입력을 확인하세요.');
				return;
			}
			else if ( $('#pw0').val() == $('#pw').val() ) {
				alert('현재 비밀번호와 동일한 비밀번호로 변경할 수 없습니다.');
				return;
			}
			$('#f').attr('action', '/restaurant/user/updatePw');
			$('#f').submit();
		});
	}  // end fnUpdatePw
   
   

	// 회원 탈퇴 함수
	function fnLeave(){
		$('#leave_btn').click(function(){
			if (confirm('탈퇴할까요?')){
				$('#f').attr('action', '/restaurant/user/leave');
				$('#f').submit();
			}
		});
	}  // end fnLeave
	
	// 이메일 중복체크 변수와 함수
	let emailPass = false;
	function fnEmailCheck() {
		if ( $('#email').val() == '${loginUser.email}' ) {
			emailPass = true;
			return;
		}
		let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}$/;
		if ( regEmail.test($('#email').val()) == false ) {
			emailPass = false;
			alert('이메일 형식을 체크해주세요.');
			return;
		}
		$.ajax({
			url: '/restaurant/user/emailCheck',
			type: 'post',
			data: 'email=' + $('#email').val(),
			dataType: 'json',
			success: function(map){
				if (map.result == null) {
					emailPass = true;
				} else {
					alert('이미 사용 중인 이메일입니다. 다른 이메일을 입력하세요.');
					emailPass = false;
				}
			},
			error: function(){
				emailPass = false;
			}
		});
	}  // end fnEmailCheck
	
	
	// 회원정보 변경 함수
	function fnUpdateUser() {
		fnEmailCheck();
		$('#updateUser_btn').click(function(){
			if ( $('#tel').val() == '${loginUser.tel}' && 
				 $('#email').val() == '${loginUser.email}' ) {
				alert('변경할 내용이 없습니다.');
				return;
			}
			else if ( emailPass == false ) {
				return;
			} 
			
			$('#f').attr('action', '/restaurant/user/updateUser');
			$('#f').submit();
		});
	}  // end fnUpdateMember
	
	//초기화
	
	function fnInit() {
		$('#reset_btn').click(function () {
			$('#tel').val('');
			$('#email').val('');
			$('#pw0').val('');
			$('#pw2').val('');
			$('#pw').val('');
			
		});
	}
	
	
   </script>
   
   <style type="text/css">
   .no{
   
   	color: red;
   	font-size: 12px;
   	
   }
   .ok{
   	color: green;
   	   	font-size: 12px;
   	
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
                        <li><a href="/restaurant/user/findQnaList?qnaWriter=${loginUser.name}">문의 내역</a></li>
                        <li><a href="/restaurant/user/goCartPage">찜 목록</a></li>
                    </ul>
                </div>
                <div class="menu_nav">
                    <h2 class="menu_title">내 정보</h2>
                    <ul>
                        <li><a href="#">내 정보 수정</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="col-6">
                 
                <div>
                    <h2 class="ing_title">개인 정보</h2>
                </div>
                <hr>
                <form id="f" method="post">
                	<input type="hidden" name="userNo" id="userNo" value="${loginUser.userNo}">
                	<input type="hidden" name="id" id="id" value="${loginUser.id}">
	      
	               	 <div class="input_row">
	                       <div class="icon_cell">
		                     <div class="input_text">
	                               <span>아이디</span>
		                     </div>
	                       </div>
	                     <div class="input_text">
	                    	 ${loginUser.id}
	                     </div>
	                 </div>
	                 
	               	 <div class="input_row">
	               	 
	                     <div class="input_text">
	                    	 <span style="margin-right: 180px;">이름 </span> ${loginUser.name}
	                     </div>
	                 </div>
	               	 <div class="input_row">
	                       <div class="icon_cell1">
	                           		 <div class="input_text">
		                               <span>전화번호</span>
				                     </div>
	                       </div>
	                     <div class="input_text">
	                    	 <input style="width: 200px" class="input_text" type="text" name="tel" id="tel" value="${loginUser.tel}"/>
	                     </div>
	                 </div>
	                 
	               	 <div class="input_row">
	                       <div class="icon_cell1">
	                           		 <div class="input_text">
		                               <span>이메일</span>
				                     </div>
	                       </div>
	                     <div class="input_text">
	                    	 <input style="width: 223px" class="input_text" type="text" name="email" id="email" value="${loginUser.email}"/>
	                    	  <p id="email_result"></p>
	                     </div>
	                 </div>
	                 
	               	 <div class="input_row">
	                       <div class="icon_cell1">
	                           <div class="input_text">
	                               <span>생일</span>
				                </div>
	                       </div>
	                     <div class="input_text">
	                    	 ${loginUser.hbd}
	                     </div>
	                 </div>
	               	 <div class="input_row">
	                       <div class="icon_cell1">
	                           <div class="input_text">
	                               <span>등급</span>
				                </div>
	                       </div>
	                     <div class="input_text">
	                    	 ${loginUser.grade}
	                     </div>
	                 </div>
	               	 <div class="input_row">
	                       <div class="icon_cell1">
	                           <div class="input_text">
	                               <span>포인트</span>
				                </div>
	                       </div>
	                     <div class="input_text">
	                    	 ${loginUser.point}
	                     </div>
	                 </div>
	               		
	               	 <div class="input_row">
	                       <div class="icon_cell1">
	                            <div class="input_text">
	                               <span>가입일</span>
				                </div>
	                       </div>
	                     <div class="input_text">
	                    	 ${loginUser.userDate}
	                     </div>
	                 </div>
                	
	               	 <div class="input_row">
	                     <div class="input_text">
	                    	 <span style="margin-right: 90px;">현재 비밀번호 :</span><input class="input_text" type="password" name="pw0" id="pw0">
	                     </div>
	                 </div>
	               	 <div class="input_row">
	                     <div class="input_text">
	                    	 <span style="margin-right: 110px;">새 비밀번호 :</span><input class="input_text" type="password" name="pw" id="pw">
	                    	  <p id="pw_result"></p>
	                     </div>
	                 </div>
	               	 <div class="input_row">
	                     <div class="input_text">
	                    	 <span style="margin-right: 70px;">새 비밀번호 확인 :</span><input class="input_text" type="password" name="pw2" id="pw2">&nbsp;
	                    	  <p id="pw2_result"></p>
	                     </div>
	                 </div><br>
	                 <div class="bottom_btns">
	                	<input type="button" value="비밀번호변경하기" id="updatePw1_btn" class="bottom_btn btn btn-danger">
	                	<input type="button" value="회원정보변경하기" id="updateUser_btn" class="bottom_btn btn btn-danger">
	                	<input type="button" value="초기화" id="reset_btn" class="bottom_btn btn btn-danger">
	                	<input type="button" value="탈퇴하기" id="leave_btn" class="bottom_btn btn btn-danger">
	                 </div>
                </form>
                
           
                <table>
                     <tbody>
                     <c:forEach var="reserve" items="ingReserve">
                        <tr>
                           <td>
                              <div id="paging"></div>
                           </td>
                        </tr>
                     </c:forEach>
                     </tbody> 
               </table>
              
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