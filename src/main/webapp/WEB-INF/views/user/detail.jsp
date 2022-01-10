<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.css" integrity="sha512-4wfcoXlib1Aq0mUtsLLM74SZtmB73VHTafZAvxIp/Wk9u1PpIsrfmTvK0+yKetghCL8SHlZbMyEcV8Z21v42UQ==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<link href="<c:url value="/resources/css/userCSS/detail.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/js/userJS/detail.js"/>" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    

<script>
	$(document).ready(function() {
		fnFindAllMenu();
		fnSelectHour();
		fnSelectBookingList();
		fnFindAllReview();
	    fnhover();
	    fnQuickMenu();
	    fnBooking();
	    fnHourCheck();
	    fnCartList();
	    fnObligation();
		fnInit();
		fnQna();
	
	  	  $('#exampleModalCenteredScrollable').modal('hide');
	  	  $('#exampleModalCenteredScrollable').modal('show');
	  	  $('#exampleModalCenteredScrollable').modal('hide');
	  	  
	  	 
	  
		
	    // input 상자 눌러서 인원수 늘리기
      	$('#bookPeople').on({
      		"click" : function(){
      			var number = ($(this).attr('value'));
      			if(number==100){ // 숫자가 9이상이라면 초기화
      				$(this).attr('value', '0');
      			}else{
      				var plus_num = parseInt(number) + 1;
      				$(this).attr('value', plus_num);
      			}
      		}
	});  
	    //달력
      	$("#datepicker").datepicker();
  	  
    	$.datepicker.setDefaults({
    	    dateFormat: 'yy-mm-dd',
    	    prevText: '이전 달',
    	    nextText: '다음 달',
    	    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    	    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    	    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    	    showMonthAfterYear: true,
    	    yearSuffix: '년',
    	    showOn : 'button',
    	    minDate: 0
    	});
    	
    	$("#booking_radio, #owner_radio").click(function(event){
 			if(this.value == "3") {
				$('.check_img1').addClass('good').removeClass('bad');
				$('.check_img2').addClass('bad').removeClass('good');
				$('#qnaState').val(3);	
			} else if (this.value == "2") {
				$('.check_img2').addClass('good').removeClass('bad');
				$('.check_img1').addClass('bad').removeClass('good');
				$('#qnaState').val(2);
			}
		});
		
 });// Pageload 끝
 
	    
	
 
	function fnQuickMenu() {
	    var currentPosition = parseInt($(".quickmenu").css("top"));
	    $(window).scroll(function() {
	        var position = $(window).scrollTop();
	        $(".quickmenu").stop().animate({ "top": position + currentPosition + "px" }, 1000);
	    });
	}  //QuickMenu 끝
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
	}  // hover 끝
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//시간 선택
	 var hour = 0;
	
	// 예약패스
	var bookingpass = false;
	 function fnSelectHour() {
		 $('.bookHours').on('click', function(){
				hour = $(this).data('hour');
				let result = $(this).val();
				$('#date_result').text(result+ '시를 선택하셨습니다.');
			});
	 }
	//예약 등록하기
	function fnBooking() {
		$('#booking_btn').click(function(){
			if( $('#userNo').val() == null ){
				alert('로그인 후 이용해주세요');
				location.href='/restaurant/user/loginPage';
			} else if(bookingpass= false){
				fnObligation();	
				alert('예약 정보를 확인해주세요');
				return false;
			} else{
				alert('예약 하시겠습니까?');
			}
			let booking = JSON.stringify({
				bookDate : $('#datepicker').val(),
				bookPeople : $('#bookPeople').val(),
			    bookHours : hour,
				bookType : $('input:radio[name="bookType"]:checked').val(),
				bookRequest : $('#bookRequest').val(),
				userNo : $('#userNo').val(),
				resNo : $('#resNo').val(),
				resOrigin : $('#resOrigin').val(),
				resSaved : $('#resSaved').val(),
				resPath :$('#resPath').val()
			});
			$.ajax({
				url : '/restaurant/book/booking',
				type : 'post',
				data : booking,
				contentType : 'application/json',
				dataType : 'json',
				success : function (map) {
					if(map.result > 0 && bookingpass == true){
						alert( $('#datepicker').val() +'/ 오후'+ hour+'시에 예약 되었습니다.');
						$('#exampleModalCenteredScrollable').modal('hide');
						fnInit();
					} else{
						
					}
				},
				error : function (xhr) {
					
				}
			});
		});
	} // booking 끝
	//사업자 문의 등록하기
	function fnQna() {
		$('#qna_btn').click(function(){
			if( $('#qnaState').val() == '' ){
				alert('문의 유형을 골라주세요');
				return false;
			} else if($('#qnaContent').val() == ''){
				alert('문의 하실 내용을 입력해주세요.');	
				return false;
			} else if( $('#userNo').val() ==null ){
				alert('로그인 후 이용해주세요');
				location.href='/restaurant/user/loginPage';
			} else{
				if(confirm('문의 하시겠습니까?'));
			}
				
			let qna = JSON.stringify({
			   	qnaState : $('#qnaState').val(),
			   	qnaContent : $('#qnaContent').val(),
			   	qnaWriter : $('#qnaWriter').val(),
			   	qnaTitle : $('#qnaTitle').val(),
			   	resNo : $('#resNo').val()
			});
			$.ajax({
				url : '/restaurant/user/qnaAsk',
				type : 'post',
				data : qna,
				contentType : 'application/json',
				dataType : 'json',
				success : function (map) {
					if(map.result > 0){
						alert('문의 되었습니다. 문의 내역은 마이페이지에서 확인해주세요.');
						 $('#myModal').modal('hide');
					} else{
						alert('실패');
					}
				},
				error : function (xhr) {
					alert('서버실패');
				}
			});
		});
	} // booking 끝
	
	function fnSelectBookingList() {
		$('#myBooking').click(function(){
			$('#f2').attr('action', '/restaurant/book/selectBookingList?userNo='+$('#userNo').val());
			$('#f2').submit();
		});
	}//selectbookinglist끝
	
	let hourPass = false;
	function fnHourCheck() {
	      $('.bookHours').on('click', function(){
    		let bookingCheck = JSON.stringify({
				bookDate : $('#datepicker').val(),
			    bookHours : hour,
			});
			$.ajax({
				url: '/restaurant/book/hourCheck',
				type: 'post',
				data: bookingCheck,
				contentType : 'application/json',
				dataType: 'json',
				success: function(map){
						if(map.result != null){
							alert('선택하신 날짜에 해당 시간은 이미 예약 되어있습니다');
							bookingpass = false;
							return false;
						} 
				},
				error: function(xhr){
					alert('실패');
				}
			});
	      });
	}  // end fnIdCheck
	
	
	function fnFindAllMenu() {
		$.ajax({
			url: '/restaurant/user/FindMenuList',
			type: 'get',
			data : 'resNo='+$('#resNo').val(),
			dataType: 'json',
			success: function(map){
				fnPrintMenuList(map);
			}
		});
	}  // end fnFindAllMenu
	function fnPrintMenuList(map){
		// 목록 초기화
		$('#menu_list').empty();
		// 목록 만들기
		if (map.list == null) {
			$('<div>')
			.append( $('<div>').text('등록된 메뉴가 없습니다.') )
			.appendTo( '#menu_list' );
		} else {
			$.each(map.list, function(i, menu){
				$('#menu_list').empty();
				$('<div class="menu_box">')
				.append($('<div>').text('메뉴번호  No.'+menu.menuNo))
				.append($('<div>').text('음식' + menu.menuName))
				.append($('<div>').text('가격 ' + menu.menuPrice + '원'))
				.append($('<div>').text('할인율 ' + menu.menuDiscount + '%'))
				.appendTo('#menu_list');
			});
		}
	}  // end fnPrintMemberList
	
	function fnFindAllReview() {
		$.ajax({
			url: '/restaurant/user/FindReviewList',
			type : 'get',
			data : 'resNo='+$('#resNo').val(),
			dataTye: 'json',
			success : function (map) {
				console.log(map.list);
				fnPrintReviewList(map);
			}
		});
	}// end of fnFindAllReview
	
	 

	function fnPrintReviewList(map){
		// 목록 초기화
		$('#review_list').empty();
		// 목록 만들기
		if (map.list == null) {
			$('<div class="swiper-slide" role="group" aria-label="1 / 9" style="width: 150px; margin-right: 30px;">')
			.append( $('<p>').text('등록된 리뷰가 없습니다.') )
			.appendTo( '#review_list' );
		} else {
			$.each(map.list, function(i, review){
				$('<div class="swiper-slide" role="group" aria-label="1 / 9" style="width: 150px; margin-right: 30px;" style="justify-content: center;">')
				.append($('<a href="#"><img src="/restaurant/'+review.reviewPath+'/'+review.reviewSaved+'" style="width: 150px; height:150px;"></a>'))
				.append($('<p>').text(review.reviewWriter))
				.append($('<p>').text(review.reviewContent))
				.appendTo('#review_list');
			});
		}
	}  // end fnPrintReviewList
	

	
	function fnInit() {
		$('#datepicker').val('');
		$('#bookRequest').val('');
		$('#date_result').text('');
		$('input:radio[name="bookType"]:checked').prop('checked', false);
	}
	
	function fnObligation() {
		$('#booking_btn').on('click', function () {
			if( $('#datepicker').val() == '' ){
				alert('날짜 입력 정보를 확인해주세요');
				bookingpass = false;
				return false;
			} else if ( $('input:radio[name="bookType"]:checked').val() == ''){
				alert('식당 타입 입력 정보를 확인하세요.');
				bookingpass = false;
				return false;
			} else if( $('#bookPeople').val() == ''){
				alert(' 인원을 입력해주세요.');
				bookingpass = false;
				return false;
			} else if($('#bookRequest').val() == '' ){
				alert('요청사항 입력 정보를 확인하세요.');
				bookingpass = false;
				return false;
			} else if($('#bookHours').val() == ''){
				alert('예약하실 시간을 선택해주세요');
			} else {
				bookingpass = true;
			}
		});
	}// end of fnObligation
	
	//예약 등록하기
	function fnCartList() {
		$('#cart_btn').click(function(){
			alert('찜 목록에 추가하시겠습니까?');
			$.ajax({
				url : '/restaurant/user/goCartRes',
				type : 'post',
				data : 'resNo='+$('#resNo').val(),
				dataType : 'json',
				success : function(map) {
					    $('#exampleModalCenteredScrollable').modal('hide');
					if(map.result > 0){
						alert('찜 목록에 추가 되었습니다.');
						fnInit();
					}
				},
				error : function (xhr) {
					alert('찜 실패');
					fnInit();
				}
			});
		});
	} // end of fnCartList 
	
	 
	
 </script>
 
 <style>
	 /* modal 박스 css시작*/
	 a{
	 	color: black;	
	 	text-decoration: none;
	 	font-weight: normal
	 }
	 label{
	 	cursor: pointer;
	 }
	 #request{
	 	outline: none;
	 	border: 1px solid silver;
	 	border-radius: 5px;
	 }
	.reserve_div{
		margin-bottom: 30px;
	}
	.reserve_text{
		font-family: nanumsquare;
		font-size: 19px;
		font-weight: bold;
	}
	.bookHours{
		margin: 3px 3px;
	}
	.check_img1{
		display: none;
		margin-right: 20px;
	}
	.ok{
		display: inline;
	}
	.reviewbox{
		display:flex;
	}
	.reviewimg{
		width:200px;
		height:250px;
	}
	.reviewmultiple{
		width:300px;
		
	}
	.reviewdaterate span{
		font-size:14px;
		font-weight:400;
	}
	
/*modal 박스 css 끝*/
  .input_box{
	  	width: 120px;
	  	height: 50px;
	  	border: 1px solid silver;
	  	border-radius: 5px;
	  	outline: none;
	  	font-size: 13px;
	  	text-align: center;
	  	margin-bottom: 30px;
	  	cursor: pointer;
  }
  .dateinput{
  	border:none;
  	outline:none;
  }
  .menu_box{
  
  	border: 1px solid #f1f1f1;
  	margin-bottom:5px;
  	padding: 10px;
  	border-radius: 2px;
  	width: 200px;
  	font-family: nanumsquare;
  	font-size: 16px;
  }
   .wrapper{ width: 400px; height: 400px; border: 1px solid red; position: relative; overflow: hidden; } .wrapper img{ width: 400px; position: absolute; top: 0; transition: left 0.4s ease-out; } .wrapper img:nth-child(1){ left: 0; } .wrapper img:nth-child(2){ left: 400px; } .wrapper img:nth-child(3){ left: 800px; } .wrapper img:nth-child(4){ left: 1200px; } .wrapper img:nth-child(5){ left: 1600px; }

/*캐러셀 슬라이드*/ 

.window {
/* overflow: hidden;  /*check out container's movement : command + / */ 
  position: relative;
  top: 20%;
  left: 50%;
  transform: translateY(-50%);
  transform: translateX(-50%);
  height: 250px;
  width: 130px;
}

.container {
  position: absolute;
  height: 230px;
  width: 930px;
  left:-400px;
  overflow: hidden;
}

.cell {
  font-size: 13px;
  text-decoration: none;
  list-style: none;
  text-align: center;
  width: 150px;
  height: 150x;
  border: 1px solid silver;
  border-radius: 10px;
  display: inline-block;
  margin: 10px 10px;
  padding-top: 30px
}
.cell_1 {
  font-size: 13px;
  text-decoration: none;
  list-style: none;
  text-align: center;
  width: 150px;
  height: 150x;
  border: 1px solid silver;
  border-radius: 10px 10px 2px 2px;
    background-color: rgb(243, 239, 239);
  display: inline-block;
  margin: 10px 10px;
  padding-top: 50px;
}

.a {
  font-size: 13px;
  height: 40px;
  width: 70px;
  margin-left: 130px;
  cursor: pointer;
}

button:hover {
  background-color: #E3B854;
}

.button-container {
  
  position: relative;
  margin: 0;
  left: 500px;
  transform: translateY(-50%);
  transform: translateX(-50%);
}
 /*캐러셀 슬라이드 끝*/
 
 /*모달 라디오 css*/
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
  /*모달 라디오 css 끝*/
  .pic_td{
  	overflow:hidden;
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
            <ul style="text-align: center;">
                <li><a href="/restaurant/user/search"> 식당검색  </a></li>
                <li><a href="식당검색페이지">할인되는식당</a></li>
                <li><a href="/restaurant/user/reserve"> 신규 오픈 </a></li>
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
 
	
    <section class="rest_section">
   
       
        <img src="/restaurant/${rest.resPath}/${rest.resSaved}" class="main_image" style="width: 500px;" style="height: 500px;"/>
        <div class="rest_detail">
            <p>${rest.resName}</p>
            <span>★4.5</span> &nbsp;<span>(45)</span><br><br>
            <p>영업시간 : ${rest.resOpenTime} ~ ${rest.resCloseTime}</p>
            <p>전화번호 : ${rest.resTel}</p>
            <div class="comment_box">
				주인장이 남기는 말<br>            
	            <p>${rest.resContent}</p>
            </div>
            
            <!--******************************************* 예약하기********************************************** -->
           
			<div   class="modal" id="exampleModalCenteredScrollable" tabindex="-1" aria-labelledby="exampleModalCenteredScrollable" style="display: hidden;" aria-modal="true" role="dialog">
			  <div class="modal-dialog modal-dialog-scrollable">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalCenteredScrollable">${rest.resName} 예약하기</h5>
			        <input type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="fnInit();">
			      </div>
			      <div class="modal-body">
			      	<form id="f" method="post">
			      		<div class="reserve_div">
							 <span class="reserve_text">날짜 선택 </span>			      		
				      		 <input type="text" id="datepicker" name="bookDate" class="input_box"> 
			      		</div>
			      		<hr>
			      		<div class="reserve_div">
                        	<span class="reserve_text">&nbsp;&nbsp;&nbsp;인원 &nbsp;&nbsp;&nbsp;&nbsp;</span>
                       	   	<input type="text" name="bookPeople" id="bookPeople" class="input_box" value="1">&nbsp;&nbsp;명 
                             <br>
                       	</div>
                       	<hr>
                       	<div class="reserve_div">
	                        	<span class="reserve_text">예약시간 </span><span id="date_result" style="color: green">&nbsp;:  </span><br>
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="12" value="오후12:00">
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="13" value="오후13:00">
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="14" value="오후14:00">
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="15" value="오후15:00">
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="16" value="오후16:00">
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="17" value="오후17:00">
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="18" value="오후18:00">
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="19" value="오후19:00">
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="20" value="오후20:00">
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="21" value="오후21:00">
	                        	<input class="bookHours btn btn-danger" name="bookHours"  type="button" data-hour="22" value="오후22:00">
                        </div>
                        <hr>
                        <div class="reserve_div">
                        <span class="reserve_text">예약타입 </span>	 
                        	<br><br>
                        	&nbsp;<label for="hall">홀</label><span class="check_img1"></span>
                        	<input name="bookType" type="radio" value="홀" id="hall"  >
                        	&nbsp;<label for="room">룸</label><span class="check_img1"></span>
                        	<input name="bookType" type="radio" value="룸" id="room" >
                        	&nbsp;<label for="booth">부스</label><span class="check_img1"></span>
                        	<input name="bookType" type="radio" value="부스테이블" id="booth" >
                        	&nbsp;<label for="bar">바</label><span class="check_img1"></span>
                        	<input name="bookType" type="radio" value="바" id="bar" >
                         
                        </div>
                        <hr>
                        
                        <div class="reserve_div">
                        	<span class="reserve_text">요청사항 </span><br>	 
                        	<textarea rows="5" cols="50" name="bookRequest" id="bookRequest"></textarea>
                        </div>
			      		
			      	</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			        <input type="button" class="btn btn-danger" id="booking_btn" value="${rest.resName}으로 정했습니다." >
			      </div>
			    </div>
			  </div>
			</div>
		      <div class="bd-example">
				  <button id="gobooking" type="button" class="fade show btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModalCenteredScrollable">
				    예약하기
				  </button>
				  <p></p>
				  <c:if test="${not empty loginUser}">
					 <form id="f2" method="post">
						  <input type="button" id="myBooking"class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModalCenteredScrollable" value="나의 예약 현황보기">
						  <input type="button" id="cart_btn"class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModalCenteredScrollable" value="찜하기">
						  <input type="hidden" id="userNo" name="userNo" value="${loginUser.userNo}">
					 </form>
				  </c:if><br>
				     <a href="/restaurant/user/findMenuList?resNo=${rest.resNo}"id="menu_btn" class="btn btn-danger" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight" >${rest.resName}의 대표메뉴를 확인해보세요!</a>
						<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
						  <div class="offcanvas-header">
						    <h5 id="offcanvasRightLabel">${rest.resName}의 메뉴를 확인해보세요 !</h5>
						    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
						  </div>
						  <div class="offcanvas-body" id="menu_list">
						  		
						  </div>
						</div>
				</div>
				<!-- *****************************************************예약하기끝 ******************************************************************** -->
        </div>
            <input type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#myModal" value="문의하기" style="position: absolute; top: 15px;">
        
    </section>
    
    
    <!-- ---------------------- 리뷰에서 받아오는 -------------------------->
    
    <section class="review_section">
	    <div class="review_title">한 줄 방문자 리뷰!
	            <a href="/restaurant/user/moreReview">더 보기 >> </a>
	        </div>
	        <div class="review_aver">
	            <span><%-- ${avgReview} --%></span>
	            <span class="total_review"><%-- ${totalCount} --%></span>
	            
	        </div>
	        <div >
	        	<c:if test="${empty reviewList}">작성된 리뷰가 없습니다.</c:if>
	        </div>
		    <div class="window">
		    <ul class="container">
		     	 <c:if test="${not empty reviewList}">
		            	<c:forEach var="review" items="${reviewList}">
		            		<c:if test="${review.reviewPath == null}">
				                  <li class="cell_1">
				                  <p>이미지가</p>
				                  <p>없는 리뷰입니다.</p>
				                  <hr>
		                      	  <span style="padding-bottom: 0;">${review.reviewWriter}</span>
						          <p>${review.reviewContent}</p>
						          <br>
				                  </li>
		            		</c:if>
		            		<c:if test="${review.reviewPath !=null}">
			                  <li class="cell">
						     <a href="#"><img src="/restaurant/${review.reviewPath}/${review.reviewSaved}" class="d-block w-100" style="width: 160px; height:150px;" alt="이미지 없는 리뷰입니다."></a>
	                      	  <span style="padding-bottom: 0;">${review.reviewWriter}</span>
					          <p>${review.reviewContent}</p>
			                  </li>
		            		</c:if>
		            	</c:forEach>
		          </c:if>
		    </ul>
		  </div>
		  <div class="button-container">
		    <button class="btn btn-danger a prev">previous</button>
		    <button class="btn btn-danger a next">next</button>
		  </div>
    </section>
    
    <section class="review_section">
        <!-- 해당 이미지를 누르면 해당 리뷰로 이동한다 -->
        <div class="picture_title"> 식당 내부 사진</div>
        <table class="image_table" style="width: 600px">
            <tbody class="review_image_table">
            	 <c:if test="${not empty pic}">
		            	<c:forEach var="pic" items="${pic}">
	                        <a href="">
	                            <img src="/restaurant/${pic.path}/${pic.uuid}" width="200px" height="200px" class="review_image_header">
	                        </a>
	                	</c:forEach>
		          </c:if>
            </tbody>
        </table>
    </section>
    
	  <script>
		  const container = document.querySelector(".container");
		  const prevBtn = document.querySelector(".prev");
		  const nextBtn = document.querySelector(".next"); 
		
		  (function addEvent(){
		    prevBtn.addEventListener('click', translateContainer.bind(this, 1));
		    nextBtn.addEventListener('click', translateContainer.bind(this, -1));
		  })();
		
		  function translateContainer(direction){
		    const selectedBtn = (direction === 1) ? 'prev' : 'next';
		    container.style.transitionDuration = '500ms';
		    container.style.transform = `translateX(${direction * (100 / 5)}%)`;
		    container.ontransitionend = () => reorganizeEl(selectedBtn);
		  }
		
		  function reorganizeEl(selectedBtn) {
		    container.removeAttribute('style');
		    (selectedBtn === 'prev') ? container.insertBefore(container.lastElementChild, container.firstElementChild): container.appendChild(container.firstElementChild);
		  }
	  </script>
	
	
	    <section class="icon_section">
		    <div class="picture_title">오시는 길</div>
				 <p style="margin-top:-12px">
			    <em class="link">
			        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
			            혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요.
			        </a><br>
			    </em>
				</p>
				<div id="map" style="width:100%;height:350px;"></div>
				<div id="clickLatlng" style="display: none;"></div>
		 </section>
		 
	
    <section class="icon_section">
        <div class="icon_title"></div>
        <table class="icon_table">
            <tbody>      <!-- 해당 식당 옵션 받아오기 -->
                <tr>
                    <td>
                        <i id="corkage"></i>
                        <p id="Optiontext1"></p>
                    </td>
                    <td>
                        <i id="night"></i>
                        <p id="Optiontext2"></p>
                    </td>
                    <td>
                        <i id="babyseat"></i>
                        <p id="Optiontext3"></p>
                    </td>
                    <td>
                        <i id="group"></i>
                        <p id="Optiontext4"></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <i id="parking"></i>
                        <p id="Optiontext5"></p>
                    </td>
                    <td>
                        <i id="wifi"></i>
                        <p id="Optiontext6"></p>
                    </td>
                    <td>
                        <i id="nokids"></i>
                        <p id="Optiontext7"></p>
                    </td>
                </tr>
            </tbody>
        </table>
    </section>
	    <input type="hidden" id="resOption" value="${rest.resOption}">
	    <input type="hidden" id="menu" value="${menu.menuName}">
    
    <script>
    
    var str = $('#resOption').val();
   
    if(str.indexOf('corkage') >=  0){
    	$('#corkage').addClass('fas fa-wine-glass-alt');
    	$('#Optiontext1').text('콜키지 가능');
    }
    if(str.indexOf('night') >= 0 ){
    	$('#night').addClass('fas fa-moon');
    	$('#Optiontext2').text('심야 영업');
    }
    if(str.indexOf('babyseat') >= 0){
    	$('#babyseat').addClass('fas fa-baby');
    	$('#Optiontext3').text('아기 의자');
    }
    if(str.indexOf('group') >= 0 ){
    	$('#group').addClass('fas fa-users');
    	$('#Optiontext4').text('단체석 가능');
    }
    if(str.indexOf('parking') >= 0 ){
    	$('#parking').addClass('fas fa-parking');
    	$('#Optiontext5').text('주차 가능');
    }
    if(str.indexOf('wifi') >= 0){
    	$('#wifi').addClass('fas fa-wifi');
    	$('#Optiontext6').text('무료 와이파이');
    }
    if(str.indexOf('nokids') >= 0){
    	$('#nokids').html('<img style="width: 100px; height: 100px;" src="https://hrcopinion.co.kr/wp-content/uploads/2021/11/nokids.png"></img>');
    	$('#Optiontext7').text('노 키즈 존');
    }
    </script>
    
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
    
    	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b0a3823d468d0cf274b39863a66eb42c&libraries=services"></script>
       <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b0a3823d468d0cf274b39863a66eb42c"></script>
    <script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
    	
    	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다  //해당식당 주소를 변수로 넣을예정..?
		geocoder.addressSearch( '${rest.resAddress}'+'${rest.resAddressDetail}' , function(result, status) {
			console.log(geocoder);
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				var message = 'latlng: new kakao.maps.LatLng(' + result[0].y + ', ';
				message += result[0].x + ')';
				
				var resultDiv = document.getElementById('clickLatlng'); 
				resultDiv.innerHTML = message;
				
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">${rest.resName}</div>'
		        });
		        infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});    
    </script>
    
    	<div class="modal" id="myModal" tabindex="-1" aria-labelledby="exampleModalCenteredScrollable" style="display: hidden;" aria-modal="true" role="dialog" >
		      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
		  <div class="modal-content">
		    <div class="modal-header">
		      <h5 class="modal-title" id="myModal">${rest.resName}에 문의하기</h5>
		      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    </div>
		    <div class="modal-body">
		      <form id="askForm" class="form-floating">
		      	
		      	<div class="reserve_div" style="border-radius: 5px; height: 30px;"> 
                	<label for="booking_radio" style="margin-left: 140px;">예약문의</label><span style= "margin: 0"class="check_img1">✔</span>
		       		<input style="display: none" type="radio" name="radio" id="booking_radio" value="3" checked >&nbsp;
		       		<label for="owner_radio" style="margin-left: 20px;">식당문의</label><span class="check_img2">✔</span>
		       		<input style="display: none" type="radio" name="radio" id="owner_radio" value="2">
                </div>
                <hr>
		        <span class="reserve_text">작성자</span><br>	 
		        <input type="text" class="form-control" id="qnaWriter" name="qnaWriter" value="${loginUser.name}"  style="width: 200px; height: 50px;">
		        <hr>
		        <span class="reserve_text">제목</span><br>	 
		        <input type="text" class="form-control" id="qnaTitle" name="qnaTitle" style="width: 300px;">
		        <hr>
                <div class="reserve_div">
                	<span class="reserve_text">문의사항 </span><br>	 
                	<textarea rows="5" cols="50" name="qnaContent" id="qnaContent"></textarea>
                </div>
		      <input type="hidden" name="qnaState" id="qnaState">
		      <input type="hidden" id="resNo" name="resNo" value="${rest.resNo}">
		      
		      </form>
		    </div>
		    <div class="modal-footer">
		      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		      <input type="button" class="btn btn-danger" value="문의완료" id="qna_btn">
		    </div>
		  </div>
		</div>
		</div>
    
    
  
   
    
	    <input type="hidden" id="resNo" name="resNo" value="${rest.resNo}">
	    <input type="hidden" id="rest" value="${rest.resAddress}">
		<input type="hidden" id="resAddress" value="${rest.resAddress}">
		<input type="hidden" id="resAddressDetail" value="${rest.resAddressDetail}">
		<input type="hidden" id="resOrigin" value="${rest.resOrigin}">
		<input type="hidden" id="resSaved" value="${rest.resSaved}">
		<input type="hidden" id="resPath" value="${rest.resPath}">
    
		
	
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
</body>
</html>