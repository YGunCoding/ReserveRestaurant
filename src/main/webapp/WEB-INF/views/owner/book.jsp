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
	<link href="<c:url value="/resources/css/main.css"/>" rel="stylesheet">
	<script src="<c:url value="/resources/js/index.js"/>"></script>
	<script src="<c:url value="/resources/js/owner.js"/>"></script>
	<script src="<c:url value="/resources/js/main.js"/>"></script>
	
<!--    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js'></script> 
 -->
	
<!-- 	<link href='/assets/demo-to-codepen.css' rel='stylesheet' /> -->
	
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
		  var calendarEl = document.getElementById('calendar');
		
		  var calendar = new FullCalendar.Calendar(calendarEl, {
		    headerToolbar: {
		      left: 'prev,next today',
		      center: 'title',
		      right: 'dayGridMonth,listYear'
		    },
			navLinks: true,
			selectable: true,
			selectMirror: true,
		
			eventClick: function(info) {
		    alert('예약자 성함 : ' + info.event.title + '시'
		    		);
		  },
		    editable: true,
		    dayMaxEvents: true,
		    events: function(info, successCallback, failureCallback) {
	    		var data = ${list_json};
				successCallback(data);
			}
		  });
		
			calendar.render();
		});
			  				
</script>
	
	
	
	
	<style>
	
 	    html, body {
	      margin: 0;
	      padding: 0;
	    }
	
	    #calendar {
	      max-width: 1100px;
	      margin: 40px auto;
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
               	<li><a href="/restaurant/owner/logout" style="font-weight: 400;">LOGOUT</a></li>
                <li><a href="/restaurant/owner/bookPage"style="font-weight: 400;">MYPAGE</a></li>
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
                    <h4 class="ing_title">예약 관리</h4>
                </div>
                <hr>
                  <div class="containers">
                    <div class="row">     
                      <div class="col-sm-9">
                        <div class="row">
                          <div class="col-8 col-sm-6">
                          
  							<div id='calendar'></div>
 
                         	<%-- <c:if test="${empty list}">
                         		<div class="empty_content">  
                         			예약이 없습니다.
                         		</div>
                         	</c:if>
                         	
                         	<c:if test="${not empty list}">
                        		<input type="hidden" name="resNo" value="${restaurant.resNo}"/>
                         		<div class="list_table">
		                         	<c:forEach var="book" items="${list}">
                         				<div>
                         					<p>${book.get("RES_NAME")}</p>
                         				
							          		<p>예약자 성함 : ${book.get("NAME")}</p>
							          		<p>예약번호 : ${book.get("BOOK_NO")}  , 홀 / 룸 : ${book.get("BOOK_TYPE")}, 인원수:${book.get("BOOK_PEOPLE")}, 예약시간 : ${book.get("BOOK_HOURS")}, 예약날짜: ${book.get("BOOK_DATE")}</p>
							          	</div>
								     </c:forEach>
								</div>
                         	</c:if> --%>
                      </div>
                    </div>
                  </div>
                 </div>
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
