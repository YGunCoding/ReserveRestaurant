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
<link href="<c:url value="/resources/css/adminCSS/adminOwner.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/index.js"/>"></script>
 <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
    	$(document).ready(function() {
    		fnReturn();
    		fnAllOwnerResList();
    		fnChangePage();
    	})
    	
    	// 전체 목록 함수 + page 전역변수
    	var page = 1;
    	var ownerNo = '${owner.ownerNo}';
    	function fnAllOwnerResList() {
    		$.ajax({
				url: '/restaurant/admin/ownerResList',
				type: 'get',
				data: "page=" + page + "&ownerNo=" + ownerNo,
				dataType: 'json',
				success: function(map) {
					fnPrintResList(map);
					fnPrintPaging(map.pageUtils);
				}
    		})
    	}  // end fnAllOwnerResList
    	
    	// 식당목록만 출력하는 함수
    	function fnPrintResList(map) {
    		$('#resList').empty();
    		// 페이지 처리 모든 정보를 변수 p에 저장
    		var p = map.pageUtils;
    		var endRecord = p.endRecord;
    		var beginRecord = p.beginRecord;
    		var tbody = '';
    		var addRow = '<tr><td height="30px"></td><td></td><td></td><td></td></tr>';
    		// 목록 만들기
    		if (p.totalRecord == 0) {
    			$('<tr rowspan="5">')
    			.append( $('<td colspan="5">').text('등록한 사업장이 없습니다.') )
    			.appendTo('#resList');
    		} else {
    			$.each (map.resList, function(i, rest) {
	   				tbody += '<tr>'
   	    			tbody += '<td height="30px">' + rest.resName + '</td>';
   	    			tbody += '<td height="30px">' + rest.resAddress + '&nbsp;' + rest.resAddressDetail + '</td>';
   	    			tbody += '<td height="30px">' + rest.resOpenTime + '&nbsp;<span>~</span>&nbsp;' + rest.resCloseTime + '</td>';
   	    			tbody += '<td height="30px">' + rest.resTel + '</td>';
   	    			tbody += '</tr>';
    			});
    			
    			for (let i = 0; i < 3 - (endRecord - beginRecord) ; i++) {
    				tbody += addRow;
    			}
    			$('#resList').append(tbody);
    		}
    		
    	}  // end fnPrintResList
    		
    	// 페이징 출력 함수
    	function fnPrintPaging(p) {
    		// 페이징 영역 초기화
    		$('#paging').empty();
    		if (p.totalRecord == 0) {
    			$('#paging').text('');
    			return true;
    		}
    		// 1페이지로 이동
    		if (page == 1) {
    			$('<span class="disable_link">&lt;&lt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		} else {
    			$('<span class="enable_link" data-page="1">&lt;&lt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		}
    		// 이전 블록으로 이동
    		if (page <= p.pagePerBlock) {
    			$('<span class="disable_link">&lt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		} else {
    			$('<span class="enable_link" data-page="'+(p.beginPage-1)+'">&lt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		}
    		// 페이지 번호
    		for (let i = p.beginPage; i <= p.endPage; i++) {
    			if (i == page) {
    				$('<span class="disable_link now_page">'+i+'&nbsp;&nbsp;</span>').appendTo('#paging');
    			} else {
    				$('<span class="enable_link" data-page="'+i+'">'+i+'&nbsp;&nbsp;</span>').appendTo('#paging');
    			}
    		}
    		// 다음 블록으로 이동
    		if (p.endPage == p.totalPage) {
    			$('<span class="disable_link">&gt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		} else {
    			$('<span class="enable_link" data-page="'+(p.endPage+1)+'">&gt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		}
    		// 마지막 페이지로 이동
    		if (page == p.totalPage) {
    			$('<span class="disable_link">&gt;&gt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		} else {
    			$('<span class="enable_link" data-page="'+p.totalPage+'">&gt;&gt;&nbsp;&nbsp;</span>').appendTo('#paging');
    		}
    	}  // end fnPrintPaging
    	
    	// 페이징 링크 처리 함수(전역변수 page값을 바꾸고, fnFindAllMember() 호출)
    	function fnChangePage(){
    		$('body').on('click', '.enable_link', function(){
    			page = $(this).data('page');
    			fnAllOwnerResList();
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
    <section class="ownerInfo">
        <p>사업자회원 정보</p>
        <table class="ownerInfo_table">
            <tbody>
                <tr>
                    <td>회원번호</td>
                    <td>${owner.ownerNo}</td>
                    <td>전화번호</td>
                    <td>${owner.tel}</td>
                </tr>
                <tr>
                    <td>아이디</td>
                    <td>${owner.id}</td>
                    <td>이름</td>
                    <td>${owner.name}</td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>${owner.email}</td>
                    <td>등록 사업장 수</td>
                    <td>${count}</td>
                </tr>
            </tbody>
        </table>
        <p class="rest_list">등록 사업장</p>
        <table class="rest_table">
            <thead style="height: 30px;">
                <tr>
                    <td class="rest_name">이름</td>
                    <td class="rest_address">주소</td>
                    <td class="rest_time">영업시간</td>
                    <td class="rest_tel">전화번호</td>
                </tr>
            </thead>
            <tbody id="resList"></tbody>
            <tfoot>
                <tr class="paging_foot">
                    <td colspan="4" id="paging"></td>
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