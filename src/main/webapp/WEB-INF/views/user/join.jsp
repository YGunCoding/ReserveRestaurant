<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value="/resources/css/userCSS/join.css"/>" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+Devanagari&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
 <script type="text/javascript">
	$(document).ready(function(){
		fnIdCheck();
		fnEmailCheck();
		fnSendAuthCode();
		fnPwCheck();
		fnPw2Check();
		fnJoin();
		
		
		$("#user_radio, #owner_radio").click(function(event){
 			if(this.value == "user") {
				$("#form").attr("action", "/restaurant/user/insertUser");
				$('.check_img1').addClass('good').removeClass('bad');
				$('.check_img2').addClass('bad').removeClass('good');
			} else if (this.value == "owner") {
				$('.check_img2').addClass('good').removeClass('bad');
				$('.check_img1').addClass('bad').removeClass('good');
				
				$("#form").attr("action", "/restaurant/owner/insertOwner");
			}
		});
		
	});
	
	// 비밀번호 변경 변수와 함수
	let pwPass = false;
	function fnPwCheck() {
		$('#pw').keyup(function() {
			let regPw = /^[a-zA-Z0-9!@#$%^&*()]{8,20}$/;
			var passwdCheck =/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/
			if ( regPw.test($(this).val()) == false ) {
				$('#pw_result').text('비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자 등 3종류 이상으로 조합해주세요.').addClass('no').removeClass('ok');
				pwPass = false;
			} else {
				$('#pw_result').text('사용 가능한 비밀번호입니다.').addClass('ok').removeClass('no');
				pwPass = true;
			}
		});
	}  // end fnPwCheck
	
	// 비밀번호 입력확인 변수와 함수
	let pwPass2 = false;
	function fnPw2Check(){
		$('#pwCheck').keyup(function(){
			if ($('#pw').val() != $(this).val()) {
				$('#pw2_result').text('비밀번호를 확인하세요.').addClass('no').removeClass('ok');
				pwPass2 = false;
			} else {
				$('#pw2_result').text('동일한 비밀번호입니다.').addClass('ok').removeClass('no');
				pwPass2 = true;
			}
		});
	}  // end fnPw2Check
	// 아이디 중복체크 변수와 함수
	let idPass = false;
	function fnIdCheck() {
		$('#id').keyup(function(){
			
            let regId = /^[a-zA-Z0-9-_]{4,}$/;
			if ( regId.test($(this).val()) == false ) {
				$('#id_result').text('아이디는 대문자,숫자,특수문자 -,_ 사용해서 4자 이상 입력해주세요.').addClass('no').removeClass('ok');
				idPass = false;
				return;
			}
			
			$.ajax({
				url: '/restaurant/user/idCheck',
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
	}  // end fnIdCheck
	
	// 이메일 중복체크 변수와 함수
	let emailPass = false;
	function fnEmailCheck() {
		$('#email').blur(function(){
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}$/;
			if ( regEmail.test($(this).val()) == false ) {
				alert('이메일 형식을 확인하세요.');
				emailPass = false;
				return;
			}
			$.ajax({
				url: '/restaurant/user/emailCheck',
				type: 'post',
				data: 'email=' + $(this).val(),
				dataType: 'json',
				success: function(map){
					if (map.result == null) {
						alert('가입 가능한 이메일입니다. 인증번호받기를 클릭해서 이메일 인증을 진행해 주세요.');
						emailPass = true;
					} else {
						alert('이미 사용 중인 이메일입니다. 다른 이메일을 입력하세요.');
						emailPass = false;
					}
				},
				error: function(){
					alert('이미 사용 중인 이메일입니다. 다른 이메일을 입력하세요.');
					emailPass = false;
				}
			})
		});
	}  // end fnEmailCheck
	
	// 이메일 인증코드 전송함수
	function fnSendAuthCode(){
		$('#authCode_btn').click(function(){
			if (emailPass == false) {
				alert('이메일을 확인하세요.');
				return;
			}
			$.ajax({
				url: '/restaurant/user/sendAuthCode',
				type: 'post',
				data: 'email=' + $('#email').val(),
				dataType: 'json',
				success: function(map) {
					alert('인증코드가 발송되었습니다.');
					fnVerifyAuthCode(map.authCode);
				},
				error: function() {
					alert('인증코드 전송 실패');
				}
			});
		});
	}  // end fnSendAuthCode
	
	
	
	// 회원가입 함수
	function fnJoin() {
		$('#form').submit(function(event){
			if ( idPass == false ) {
				alert('아이디를 확인하세요.');
				event.preventDefault();
				return false;
			}
			else if ( pwPass == false || pwPass2 == false ) {
				alert('비밀번호를 확인하세요.');
				event.preventDefault();
				return false;
			}
			else if ( authCodePass == false ) {
				alert('이메일 인증을 받아야 합니다.');
				event.preventDefault();
				return false;
			}
			return true;
		});
	}  // end fnJoin
	
	
	
	
	// 인증코드 검증 변수와 함수
	let authCodePass = false;
	function fnVerifyAuthCode(authCode) {
		$('#verify_btn').click(function(){
			if ( $('#authCode').val() == authCode ) {
				alert('인증되었습니다.');
				authCodePass = true;
			} else {
				alert('인증에 실패했습니다.');
				authCodePass = false;
			}
		});
	}  // end fnVerifyAuthCode
	
	
	
</script>

<style>

.radio_box{
  	border: 1px solid crimson;
  	width: 150px;
  	margin: 0 auto;
  	padding: 10px;
  	border-radius: 7px;
  	
  }
  
  .radio_box > input{
  	margin-left: 10px;
  }
  
  .check_img1{
  	display: none;
  }
  .check_img2{
  	display: none;
  }
  
  .bad{
  	display: none;
  }
  .good{
  display: inline;
  }
	.no{
		color:red;
	}
	.ok{
		color:green;
	}
	 .necessary {
            margin-right: 10px;
            color: red;
        }
        .aaa {
        	width: 600px; 
        }
        .inputForm {
        	margin: 0 auto;
        	width: 600px;
        }
        .LoginEnter {
        	width: 600px;
        	margin: 50px auto 150px;
        }
        .mainlogin {
        	width: 775px;
        	margin: 0 auto;
        }
        .header_logo {
        	width: 500px;
        }
        
</style>
    
</head>

<body>
		
<div id="root" class="root">
<!-- 맨윗부분 -->
<header class="shareit_header"> 
      <div class="header_logo">
        <a class="header-logo" href="/restaurant"><img src="/restaurant/resources/image/join/FindTableLogo.png" alt="shareit-logo"></a> 
        <a class="header-logo1" href="/restaurant"><img src="/restaurant/resources/image/join/rightaway.svg" alt="파인드테이블">&nbsp;&nbsp;메인화면으로 가기</a> 
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
<!-- 회원가입 부분 -->
   <section id="login">
   <div>
      <main class="mainlogin"> 
         <div>
            <img src="/restaurant/resources/image/join/FindTableLogo.png" alt="shareit-loginlogo">
         </div>
   
         <div class="welcomelogin">
               <div class="title">회원가입</div>
               <p>🥑🧀&nbsp;&nbsp;파인드 테이블과 함께 해주셔서 감사합니다&nbsp;&nbsp;🥑🧀</p> 
         </div>
       	<form id="form" method="post" action="/restaurant/user/insertUser">
       <div class="radio_box">
		       		<label for="user_radio">회원</label><span class="check_img1">✔</span>
		       		<input style="display: none" type="radio" name="radio" id="user_radio" value="user" checked >&nbsp;
		       		<label for="owner_radio">사업자</label><span class="check_img2">✔</span>
		       		<input style="display: none" type="radio" name="radio" id="owner_radio" value="owner">
		       	</div><br>
         <div class="tblForm inputForm">
            <table class="aaa">
                <colgroup>
                    <col style="width:300px">
                    <col style="width:400px">
                    <col style="width:400px">
                    <col class="sm-wd">
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><span class="necessary">*</span>성명</th>
                        <td colspan="3">
                            <input type="text" class="inTxt rs-w100" id="name" name="name" value="" maxlength="50" style="width:180px" title="성명 입력"> <!--  -->
                            
                            <input type="hidden" name="m_szGender" value="">
                            <input type="hidden" name="m_szDomestic" value="">
                            <input type="hidden" name="loginGbn" value="">
                            <input type="hidden" name="m_szBirthGender" value="">                            
                        
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><span class="necessary">*</span>아이디</th>
                        <td colspan="3">
                            <input type="text" class="inTxt rs-w100" id="id" name="id" maxlength="20" style="width:180px;ime-mode:disabled;" title="아이디 입력">
                            <label for="m_szId"></label>
                            <p id="id_result"></p>
                        </td>
                     </tr>
                    <tr>
                        <th scope="row"><span class="necessary">*</span><label for="m_szPwd">비밀번호</label></th>
                        <td colspan="3"><input type="password" class="inTxt rs-w100" id="pw" name="pw" maxlength="15" style="width:180px;ime-mode:disabled;" title="비밀번호">
                            <p id="pw_result"></p>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><span class="necessary">*</span><label for="m_szPwdChk">비밀번호 확인</label></th>
                        <td colspan="3" class="line2"><input type="password" class="inTxt rs-w100" id="pwCheck" name="pwCheck" maxlength="15" style="width:180px;ime-mode:disabled;" title="비밀번호 확인">
                        <p id="pw2_result"></p>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><span class="necessary">*</span><label for="birthyy">생년월일</label></th>
                        <td>
                            <span class="selectboxWrap">
                                <select class="select selectBg" id="hbd" name="hbd" title="년도 선택">
                                <option value="">년도</option>
                                <option value="2021">2021</option>
                                <option value="2020">2020</option>
                                <option value="2019">2019</option>
                                <option value="2018">2018</option>
                                <option value="2017">2017</option>
                                <option value="2016">2016</option>
                                <option value="2015">2015</option>
                                <option value="2014">2014</option>
                                <option value="2013">2013</option>
                                <option value="2012">2012</option>
                                <option value="2011">2011</option>
                                <option value="2010">2010</option>
                                <option value="2009">2009</option>
                                <option value="2008">2008</option>
                                <option value="2007">2007</option><option value="2006">2006</option><option value="2005">2005</option><option value="2004">2004</option><option value="2003">2003</option><option value="2002">2002</option><option value="2001">2001</option><option value="2000">2000</option><option value="1999">1999</option><option value="1998">1998</option><option value="1997">1997</option><option value="1996">1996</option><option value="1995">1995</option><option value="1994">1994</option><option value="1993">1993</option><option value="1992">1992</option><option value="1991">1991</option><option value="1990">1990</option><option value="1989">1989</option><option value="1988">1988</option><option value="1987">1987</option><option value="1986">1986</option><option value="1985">1985</option><option value="1984">1984</option><option value="1983">1983</option><option value="1982">1982</option><option value="1981">1981</option><option value="1980">1980</option><option value="1979">1979</option><option value="1978">1978</option><option value="1977">1977</option><option value="1976">1976</option><option value="1975">1975</option><option value="1974">1974</option><option value="1973">1973</option><option value="1972">1972</option><option value="1971">1971</option><option value="1970">1970</option><option value="1969">1969</option><option value="1968">1968</option><option value="1967">1967</option><option value="1966">1966</option><option value="1965">1965</option><option value="1964">1964</option><option value="1963">1963</option><option value="1962">1962</option><option value="1961">1961</option><option value="1960">1960</option><option value="1959">1959</option><option value="1958">1958</option><option value="1957">1957</option><option value="1956">1956</option><option value="1955">1955</option><option value="1954">1954</option><option value="1953">1953</option><option value="1952">1952</option><option value="1951">1951</option><option value="1950">1950</option><option value="1949">1949</option><option value="1948">1948</option><option value="1947">1947</option><option value="1946">1946</option><option value="1945">1945</option><option value="1944">1944</option><option value="1943">1943</option><option value="1942">1942</option><option value="1941">1941</option><option value="1940">1940</option><option value="1939">1939</option><option value="1938">1938</option><option value="1937">1937</option><option value="1936">1936</option><option value="1935">1935</option><option value="1934">1934</option><option value="1933">1933</option><option value="1932">1932</option><option value="1931">1931</option><option value="1930">1930</option><option value="1929">1929</option><option value="1928">1928</option><option value="1927">1927</option><option value="1926">1926</option><option value="1925">1925</option><option value="1924">1924</option><option value="1923">1923</option><option value="1922">1922</option><option value="1921">1921</option><option value="1920">1920</option><option value="1919">1919</option><option value="1918">1918</option><option value="1917">1917</option><option value="1916">1916</option><option value="1915">1915</option><option value="1914">1914</option><option value="1913">1913</option><option value="1912">1912</option><option value="1911">1911</option><option value="1910">1910</option><option value="1909">1909</option><option value="1908">1908</option><option value="1907">1907</option><option value="1906">1906</option><option value="1905">1905</option><option value="1904">1904</option><option value="1903">1903</option><option value="1902">1902</option><option value="1901">1901</option><option value="1900">1900</option></select>
                            </span>
                            <span class="selectboxWrap">
                                <select class="select selectBg" id="hbd" name="hbd" title="월 선택">
                                <option value="">월</option><option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option></select>
                            </span>
                            <span class="selectboxWrap" style="width:32%">
                                <select class="select selectBg" id="hbd" name="hbd" title="일 선택">
                                <option value="">일</option><option value="01">01</option><option value="02">02</option><option value="03">03</option><option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option><option value="31">31</option></select>
                            </span>
                           
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><span class="necessary">*</span><label for="phone1">휴대폰</label></th>
                        <td colspan="3" class="hp">
                            <span class="selectboxWrap">
                                <select class="select selectBg" id="tel" name="tel" title="휴대폰 번호 선택">
                                    <option value="010" selected="selected">010</option>
                                    <option value="011">011</option>
                                    <option value="016">016</option>
                                    <option value="017">017</option>
                                    <option value="018">018</option>
                                    <option value="019">019</option>
                                </select>
                            </span>
                            <span class="dash">-</span>
                            <input type="text" class="inTxt" id="tel" name="tel" maxlength="4" onkeydown="only_number(this)" style="width:80px" title="휴대폰 두번째 자리 입력">
                            <span class="dash">-</span>
                            <input type="text" class="inTxt" id="tel" name="tel" maxlength="4" onkeydown="only_number(this)" style="width:80px" title="휴대폰 세번째 자리 입력">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><span class="necessary">*</span><label for="email_01">이메일</label></th>
                        <td colspan="3" class="email">
                            <input type="hidden" name="m_szEmail">
                            <input type="text" class="inTxt rs-w40" id="email" name="email" onfocus="checkLen(this.value);" style="width:200px;ime-mode:disabled;" title="이메일 아이디 입력">
                            <span class="dash">  </span>
                      
                            <input type="button" value="인증번호받기" id="authCode_btn"  class="tbtns rs-mt5"><br>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><span class="necessary">*</span><label for="mailKey">이메일<br>인증확인</label></th>
                        <td colspan="3">
                            <input type="hidden" id="m_szCertYn" name="m_szCertYn">
                            <input type="text" class="inTxt rs-w100" id="authCode" name="authCode" style="width:180px;ime-mode:disabled;" title="이메일 인증확인 입력">
                            <input type="button" value="인증하기" id="verify_btn" class="tbtns rs-mt5"><br>
                            
                        </td>
                    </tr>                    
                </tbody>  
            </table>
        </div>
        <button type="submit" class="LoginEnter" id="LoginEn">가입하기</button>
      </form>

        </main> 
      </div>
   </section>
  </div>

</body>
</html>