
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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<style>
		#image_container img{
			width:100px;
			height:70px;
			padding:3px;
		}
		.btn-add{
		    background-color: white;
		    border: none;
		}
	</style>
</head>
<script>

	
	
</script>

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
                    <h4 class="ing_title">사업장 등록 하기</h4>
                </div>
                <hr>
                <div class="formtable">
                    <form id="f" method="POST" enctype="multipart/form-data" action="addRestaurant" >
                        <table class="addtable">
                            <tbody>
		                        <tr>
		                            <td>사업장 이름</td>
		                            <td>
		                            	<input type="hidden" name="ownerNo" value="${loginUser.ownerNo}">
		                                <input type="text" name="s_name" id="s_name" placeholder="사업장 이름을 입력하세요">
		                            </td>
		                        </tr>
		                         <tr>
		                             <td>운영시간</td>
		                            <td>
		                                 <select name="open_time" id="open_time">
		                                     <option value="">--오픈 시간--</option>
		                                 </select> ~
		                                 <select name="close_time" id="close_time">
		                                     <option value="">--마감 시간--</option>
		                                     
		                                 </select>
		                             </td>
		                         </tr>
		                         <tr>
		                             <td>전화번호</td>
		                             <td>
		                                 <input type="text" name="tel" id="tel" placeholder="ex) 000-0000-0000">
		                             </td>
		                         </tr>
		                         <tr>
                                    <td> 식당위치</td>
                                    <td>
	                                    <div class="address_box">
	                                    	<label class="address">주소</label>
	                                       <input type="text" id="address_kakao" name="address" placeholder="주소입력시 클릭하세요" readonly />
	                                    </div>
	                                    <div class="address_box">
	                                   		<label>상세주소</label>
                                       		<input type="text" name="address_detail" placeholder="상세주소를 입력해주세요"/>
	                                    </div>
                                    </td>
                                </tr>
		                          <tr>
		                              <td>사진 등록</td>
		                              <td>
										<button type="button" class="btn-add" id="file_add"><i class="fas fa-plus"></i>&nbsp;사진 추가하기</button> 
 		                                   <input type="file" name="files" id="multi-add" accept="image/*" style="display:none;" onchange="setThumbnail(event);" multiple/> 
		                               	
		                                 <div id="image_container"></div>  
		                                 <!-- click event -->
		                                 <script> 
		                                  $("#file_add").on('click',function(){ $('#multi-add').click(); }); 
		                                  
		                                	function setThumbnail(event) {
		                                  		for (var image of event.target.files) {
		                                  			var reader = new FileReader(); reader.onload = function(event) {
		                                  				var img = document.createElement("img"); img.setAttribute("src", event.target.result);
		                                  				document.querySelector("div#image_container").appendChild(img); 
		                                  				};
		                                  				console.log(image);
		                                  				reader.readAsDataURL(image); 
		                                  			}
		                                  		}  
		                                  </script>
		                                  <!-- ------------ -->
		                              </td>
		                           </tr>
		                             <tr>
		                                 <td>메뉴 등록하기</td>
		                                 <td class="menu">
		                                     <div class="menu_input">
		                                         <div class="menu_input_box default">
		                                             <input type="text" name="menu" placeholder="메뉴명"/><input type="text" name="price" placeholder="가격 (원)"/>
		                                         </div>
		                                     </div>
		                                     <button class="plus_btn">
		                                         <i class="far fa-plus-square" ></i>
		                                     </button>
		                                 </td>
		                             </tr>
		                             <tr>
		                                 <td>추가 옵션</td>
		                                 <td>
		                                     <input type="checkbox" name="additional_option" value="corkage" id="corkage">
		                                     <label for="corkage">콜키지</label>
		                                     <input type="checkbox" name="additional_option" value="night" id="night">
		                                     <label for="night">심야 영업</label>
		                                     <input type="checkbox" name="additional_option" value="babyseat" id="babyseat">
		                                     <label for="babyseat">아기 의자</label>
		                                     <input type="checkbox" name="additional_option" value="nokids" id="nokids">
		                                     <label for="nokids">노 키즈존</label><br>
		                                     <input type="checkbox" name="additional_option" value="group" id="group">
		                                     <label for="group">단체석</label>
		                                     <input type="checkbox" name="additional_option" value="parking" id="parking">
		                                     <label for="parking">주차 가능</label>
		                                     <input type="checkbox" name="additional_option" value="wifi" id="wifi">
		                                     <label for="wifi">와이파이</label>
		                                 </td>
		                             </tr>
		                             <tr>
		                                 <td>상세 설명</td>
		                                 <td><textarea name="content" rows="5" cols="48" placeholder="상세 설명을 입력하세요"></textarea></td>
		                             </tr>
	                            </tbody>
	                            <tfoot>
	                                <tr>
	                                    <td colspan="2">
	                                        <input type="submit" value="사업장 등록하기" class="add_btn">
	                                    </td>
	                                </tr>
                            </tfoot>

                        </table>
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
</body>
</html>
