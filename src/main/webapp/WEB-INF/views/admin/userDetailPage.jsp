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
<link href="<c:url value="/resources/css/adminCSS/userDetail.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/index.js"/>"></script>
 <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
    	$(document).ready(function() {
    		fnReturn();
    		fnAllBookList();
    		fnChangePage();
    	})
    	
    	var page = 1;
    	var userNo = '${user.userNo}';
    	function fnAllBookList() {
    		$.ajax({
				url: '/restaurant/admin/userBookList',
				type: 'get',
				data: "page=" + page + "&userNo=" + userNo,
				dataType: 'json',
				success: function(map) {
					fnPrintBookList(map);
					fnPrintPaging(map.pageUtils);
				}
    		})
    	}  // end fnAllBookList
    	
    	function fnPrintBookList(map) {
    		$('#bookList').empty();
    		var p = map.pageUtils;
    		var endRecord = p.endRecord;
    		var beginRecord = p.beginRecord;
    		var tbody = '';
    		var addRow = '<tr><td height="30px"></td><td></td><td></td><td></td><td></td></tr>';
    		if (p.totalRecord == 0) {
    			$('<tr rowspan="5">')
    			.append( $('<td colspan="5">').text('최근 예약 식당이 없습니다.') )
    			.appendTo('#bookList');
    		} else {
    			$.each (map.bookList, function(i, book) {
	   				tbody += '<tr>'
   	    			tbody += '<td height="30px">' + book.restaurant.resName + '</td>';
   	    			tbody += '<td height="30px">' + book.restaurant.resAddress + '</td>';
   	    			tbody += '<td height="30px">' + book.bookPeople + '</td>';
   	    			tbody += '<td height="30px">' + book.bookRequest + '</td>';
   	    			tbody += '<td height="30px">' + book.bookDate + '</td>'
   	    			tbody += '</tr>';
    			});
    			
    			for (let i = 0; i < 4 - (endRecord - beginRecord) ; i++) {
    				tbody += addRow;
    			}
    			$('#bookList').append(tbody);
    			
    			
    			
    			/*
	    		if (endRecord - beginRecord == 0) {
	    			tbody += addRow; tbody += addRow; tbody += addRow; tbody += addRow;
	      	     	$('#bookList').append(tbody);
	    		} else if (endRecord - beginRecord == 1) {
	    			tbody += addRow; tbody += addRow; tbody += addRow;
	    			$('#bookList').append(tbody);
	    		} else if (endRecord - beginRecord == 2) {
	    			tbody += addRow; tbody += addRow;
	        		$('#bookList').append(tbody);
	    		} else if (endRecord - beginRecord == 3) {
	    			tbody += addRow;
	    			$('#bookList').append(tbody);
	    		} else if (endRecord - beginRecord == 4) {
	    			$('#bookList').append(tbody);
	    		}
	    		*/
    		}
    		
    	}  // end fnPrintBookList
    		
    		/*else if (p.totalRecord == 1) {
    			tbody += '<tr>';
    			tbody += '<td>' + map.bookList[0].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[0].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[0].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[0].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[0].bookDate + '</td>'
    			tbody += '</tr>';
    			tbody += '<tr><td></td><td></td><td></td><td></td><td></td></tr>'
    			tbody += '<tr><td></td><td></td><td></td><td></td><td></td></tr>'
    			tbody += '<tr><td></td><td></td><td></td><td></td><td></td></tr>'
    			tbody += '<tr><td></td><td></td><td></td><td></td><td></td></tr>'
    			$('#bookList').append(tbody);
    		} else if (p.totalRecord == 2) {
    			tbody += '<tr>'
    			tbody += '<td>' + map.bookList[0].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[0].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[0].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[0].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[0].bookDate + '</td></tr>';
    			tbody += '<tr><td>' + map.bookList[1].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[1].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[1].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[1].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[1].bookDate + '</td>'
    			tbody += '</tr>';
    			tbody += '<tr><td></td><td></td><td></td><td></td><td></td></tr>'
    			tbody += '<tr><td></td><td></td><td></td><td></td><td></td></tr>'
    			tbody += '<tr><td></td><td></td><td></td><td></td><td></td></tr>'
    			$('#bookList').append(tbody);
    		} else if (p.totalRecord == 3) {
    			$.each (map.bookList, function(i, list) {
	   				tbody += '<tr>'
   	    			tbody += '<td>' + list.restaurant.resName + '</td>';
   	    			tbody += '<td>' + list.restaurant.resAddress + '</td>';
   	    			tbody += '<td>' + list.bookPeople + '</td>';
   	    			tbody += '<td>' + list.bookRequest + '</td>';
   	    			tbody += '<td>' + list.bookDate + '</td>'
   	    			tbody += '</tr>';
   	    			tbody += '<tr><td></td><td><td></td></td><td></td><td></td></tr>'
   	     			tbody += '<tr><td></td><td></td><td></td><td></td><td></td></tr>'
   	     			$('#bookList').append(tbody);
    			})
    		} else if (p.totalRecord == 4) {
    			tbody += '<tr>'
    			tbody += '<td>' + map.bookList[0].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[0].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[0].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[0].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[0].bookDate + '</td>'
    			tbody += '</tr>';
    			tbody += '<tr>'
    			tbody += '<td>' + map.bookList[1].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[1].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[1].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[1].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[1].bookDate + '</td>'
    			tbody += '</tr>';
    			tbody += '<tr>'
    			tbody += '<td>' + map.bookList[2].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[2].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[2].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[2].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[2].bookDate + '</td>'
    			tbody += '</tr>';
    			tbody += '<tr>'
    			tobdy += '<td>' + map.bookList[3].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[3].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[3].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[3].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[3].bookDate + '</td>'
    			tbody += '</tr>';
    			tbody += '<tr><td></td><td></td><td></td><td></td><td></td></tr>'
    			$('#bookList').append(tbody);
    		} else {
    			tbody += '<tr>'
    			tbody += '<td>' + map.bookList[0].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[0].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[0].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[0].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[0].bookDate + '</td>'
    			tbody += '</tr>';
    			tbody += '<tr>'
    			tbody += '<td>' + map.bookList[1].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[1].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[1].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[1].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[1].bookDate + '</td>'
    			tbody += '</tr>';
    			tbody += '<tr>'
    			tbody += '<td>' + map.bookList[2].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[2].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[2].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[2].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[2].bookDate + '</td>'
    			tbody += '</tr>';
    			tbody += '<tr>'
    			tbody += '<td>' + map.bookList[3].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[3].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[3].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[3].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[3].bookDate + '</td>'
    			tbody += '</tr>';
    			tbody += '<tr>'
    			tbody += '<td>' + map.bookList[4].restaurant.resName + '</td>';
    			tbody += '<td>' + map.bookList[4].restaurant.resAddress + '</td>';
    			tbody += '<td>' + map.bookList[4].bookPeople + '</td>';
    			tbody += '<td>' + map.bookList[4].bookRequest + '</td>';
    			tbody += '<td>' + map.bookList[4].bookDate + '</td>'
    			tbody += '</tr>';
    			$('#bookList').append(tbody);
    		} */ 
    		
    	function fnPrintPaging(p) {
    		$('#paging').empty();
    		if (p.totalRecord == 0) {
    			$('#paging').text('');
    			return true;
    		}
    		if (page == 1) {
    			$('<span class="disable_link">&lt;&lt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		} else {
    			$('<span class="enable_link" data-page="1">&lt;&lt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		}
    		if (page <= p.pagePerBlock) {
    			$('<span class="disable_link">&lt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		} else {
    			$('<span class="enable_link" data-page="'+(p.beginPage-1)+'">&lt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		}
    		for (let i = p.beginPage; i <= p.endPage; i++) {
    			if (i == page) {
    				$('<span class="disable_link now_page">'+i+'&nbsp;&nbsp;</span>').appendTo('#paging');
    			} else {
    				$('<span class="enable_link" data-page="'+i+'">'+i+'&nbsp;&nbsp;</span>').appendTo('#paging');
    			}
    		}
    		if (p.endPage == p.totalPage) {
    			$('<span class="disable_link">&gt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		} else {
    			$('<span class="enable_link" data-page="'+(p.endPage+1)+'">&gt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		}
    		if (page == p.totalPage) {
    			$('<span class="disable_link">&gt;&gt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		} else {
    			$('<span class="enable_link" data-page="'+p.totalPage+'">&gt;&gt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		}
    	}  // end fnPrintPaging
    	
    	
    	function fnChangePage(){
    		$('body').on('click', '.enable_link', function(){
    			page = $(this).data('page');
    			fnAllBookList();
    		});
    	}  // end fnChangePage

    	
    	
    	
    	
    	function fnReturn() {
    		$('#return_btn').click(function() {
    			location.href="/restaurant/admin/userAdminPage";
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
                <li>${loginUser.id} 님 환영합니다</li>
                <li><a href="/restaurant/user/logout">LOGOUT&nbsp;&nbsp;&nbsp;/</a></li>
                <li><a href="/restaurant/admin/adminPage">ADMIN&nbsp;PAGE&nbsp;&nbsp;&nbsp;</a></li>
            </ul>
        </div>
    </header>
    <section class="userInfo">
        <p>회원정보</p>
        <table class="userInfo_table">
            <tbody>
                <tr>
                    <td>회원번호</td>
                    <td>${user.userNo}</td>
                    <td>아이디</td>
                    <td>${user.id}</td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td>${user.name}</td>
                    <td>전화번호</td>
                    <td>${user.tel}</td>
                </tr>
                <tr>
                    <td>등급</td>
                    <td>${user.grade}</td>
                    <td>가입일</td>
                    <td>${user.userDate}</td>
                </tr>
                <tr>
                    <td>생년월일</td>
                    <td>${user.hbd}</td>
                    <td>포인트</td>
                    <td>${user.point}</td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>${user.email}</td>
                    <td>로그인 횟수</td>
                    <td>${countLog}</td>
                </tr>
            </tbody>
        </table>
        <p class="book_list">최근 예약 목록</p>
        <table class="book_table">
            <thead>
                <tr>
                    <td>식당명</td>
                    <td>주소</td>
                    <td>인원 수</td>
                    <td>요청사항</td>
                    <td>예약 일자</td>
                </tr>
            </thead>
            <tbody id="bookList"></tbody>
            <tfoot>
                <tr class="paging_foot">
                    <td colspan="5" id="paging"></td>
                </tr>            
            </tfoot>
        </table>
    </section>
    <div class="return_btn">
        <input type="button" value="목록으로 돌아가기" class="btn" id="return_btn">
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
                    <img src="/restaurant/resources/image/index/projectlogo.png" class="footer_logo_image">
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