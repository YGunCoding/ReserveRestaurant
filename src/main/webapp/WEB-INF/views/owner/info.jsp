<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css" integrity="sha512-4wfcoXlib1Aq0mUtsLLM74SZtmB73VHTafZAvxIp/Wk9u1PpIsrfmTvK0+yKetghCL8SHlZbMyEcV8Z21v42UQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<link href="<c:url value="/resources/css/index.css"/>" rel="stylesheet">
	<link href="<c:url value="/resources/css/owner.css"/>" rel="stylesheet">
	<script src="<c:url value="/resources/js/index.js"/>"></script>
	<script src="<c:url value="/resources/js/owner.js"/>"></script>
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
   	
// 현재 비밀번호 확인
	let presentPwPass = false;
	function fnPresentPwCheck() {
		$('#pw0').blur(function(){
			$.ajax({
				url: 'presentPwCheck',
				type: 'post',
				data: $('#f3').serialize(),
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
	
	// 새 비밀번호 입력
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
	
	
	// 새 비밀번호 입력 확인
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
			$('#f3').attr('action', 'updatePw');
			$('#f3').submit();
		});
	}  // end fnUpdatePw
   
   
	// 회원 탈퇴 함수
	function fnLeave(){
		$('#leave_btn').click(function(){
			if (confirm('탈퇴할까요?')){
				$('#f3').attr('action', 'delete');
				$('#f3').submit();
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
			url: 'emailCheck',
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
			$('#f3').attr('action', 'updateOwner');
			$('#f3').submit();
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
   .infobtnbox{
    width: 100%;
    display: flex;
    margin: 20px 30px 20px 10px;
   	display:flex;
   }
   .bottom_btn{
    width: 120px;
    background-color: rgb(160, 57, 38);
    border: none;
    color: white;
    padding: 10px;
    margin: 5px;
    border-radius: 10px;
   }
   .bottom_btn:hover{
    background-color:  rgba(160, 57, 38, 0.795);
	}
	.infobox input{
	padding:5px;
	}
   </style>
   
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
               <li><a href="/restaurant/owner/logout">LOGOUT</a></li>
               <li><a href="/restaurant/owner/bookPage">MYPAGE</a></li>
            </ul>
        </div>
    </header>
   
    <div class="container">
        <div class="row">
          <div class="col-4">
                <div class="menu_nav">
                    <h4 class="menu_title">나의 사업장</h4>
                    <ul>
                        <li><a href="addPage" class="menu_sub_title">등록하기</a></li>
                        <li><a href="managePage" class="menu_sub_title"> 사업장 관리</a></li>
                        <li><a href="bookPage" class="menu_sub_title"> 예약 관리</a></li>
                    </ul>
                </div>
                <div class="menu_nav">
                    <h4 class="menu_title">My 활동</h4>
                    <ul>
                        <li><a href="questionPage">문의 내역</a></li>
                        <li><a href="reviewPage">리뷰 관리</a></li>
                    </ul>
                </div>
                <div class="menu_nav">
                    <h4 class="menu_title">내 정보</h4>
                    <ul>
                        <li><a href="modifyOwner?ownerNo=${loginUser.ownerNo}">내 정보 수정</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-6">
                <div class="section2">
                    <h4 class="ing_title">내 정보 수정하기</h4>
                </div>
                <hr>
                <div>
                    <form id="f3" method="POST" enctype="multipart/form-data">
                    	<input type="hidden" name="ownerNo" value="${loginUser.ownerNo}">
                        <table class="infobox">
                            <tbody>
                                <tr>
                                    <td>이름</td>
                                    <td>
                                        <input type="text" name="name" id="name" value="${loginUser.name}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>아이디</td>
                                    <td>
                                        <input type="text" value="${loginUser.id}" name="id" id="id"/>
                                         <p id="id_result"></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>전화번호</td>
                                    <td>
                                        <input type="text" name="tel" id="tel" value="${loginUser.tel}">
                                    </td>
                                </tr>
                                <tr>
                                    <td>이메일</td>
                                    <td>
                                        <input type="text" name="email" id="email" value="${loginUser.email}">
                                         <p id="email_result"></p>
                                    </td>
                                </tr>
                                <tr>
                                	<td>현재 비밀번호 :</td>
                                	<td><input class="input_text" type="text" name="pw0" id="pw0"></td>
                                </tr>
                                <tr>
                                    <td>새 비밀번호 :</td>
                                    <td>
                                        <input class="input_text" type="text" name="pw" id="pw">
                                         <p id="pw_result"></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>새 비밀번호 확인 :</td>
                                    <td>
                                       <input class="input_text" type="text" name="pw2" id="pw2">
                                       <!--  <input type="button" value="비밀번호 확인" name="check_pw" id="check_pw"/> -->
                                        <p id="pw2_result"></p>
                                    </td>
                                </tr>
                            </tbody>
                           </table>
                              <div class="infobtnbox">
            					<input type="button" value="비밀번호 변경" id="updatePw1_btn" class="bottom_btn">
                                  <input type="button" value="회원정보 변경" id="updateUser_btn" class="bottom_btn">
                                  <input type="reset" value="초기화 하기" id="reset_btn" class="bottom_btn">
                                  <input type="button" value="탈퇴하기" id="leave_btn" class="bottom_btn">
                              </div>
                    </form>
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
    
   <!--  <script>
    //아아디체크
    let idPass = false;
    let regId = /^[a-zA-Z0-9-_]{4,10}$/;
    function fnIdCheck(){
        $('#ownerId').keyup(function(){
            if( regId.text($(this).val() == false)){
                $('#id_result').text('아이디는 영어 소문자, 대문자, 숫자포함 4 ~ 10자리로 입력해주세요').addClass('no').removeClass('ok');
                idPass = false;
                return;
        }
        $.ajax({
                url: 'owner/idCheck',
                type: 'post',
                data: 'id=' + $(this).val(),
                dataType: 'json',
                success: function(map){
                    if (map.result == null) {
                        $('#id_result').text('사용 가능한 아이디입니다').addClass('ok').removeClass('no');
                        idPass = true;
                    } else {
                        $('#id_result').text('사용 중인 아이디입니다').addClass('no').removeClass('ok');
                        idPass = false;
                    }
                },
                error: function(xhr){
                    $('#id_result').text(xhr.responseText).addClass('no').removeClass('no');
                    idPass = false;
                }
            });
        });
    }       
  
</script> -->
</body>
</html>