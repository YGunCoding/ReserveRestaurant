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
<link href="<c:url value="/resources/css/adminCSS/adminRes.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/index.js"/>"></script>
 <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
	$(document).ready(function() {
		fnResList();
		fnChangePage();
		fnFind();
	})

	var page = 1;
	function fnResList() {
		$.ajax({
			url: '/restaurant/admin/selectResList',
			type: 'get',
			data: "page=" + page,
			dataType: 'json',
			success: function(map) {
				fnPrintResList(map);
				fnPrintPaging(map.pageUtils);
			}
		})
	} // end fnResList()
	
	// 검색 함수
	function fnFind() {
		$('#search_btn').click(function(event) {
			var column = $('#column').val();
			var query = $('#query').val();
			if ($('#column').val() == '') {
				alert('검색 카테고리를 선택하세요');
				return;
			} else if ($('#query').val() == '') {
				alert('검색어를 입력하세요')
				return;
			}
			$.ajax({
				url: '/restaurant/admin/findRes',
				type: 'get',
				data: 'page=' + page + '&column=' + column + '&query=' + query,
				dataType: 'json',
				success: function(map) {
					fnPrintFindResList(map);
					fnPrintPaging(map.pageUtils);
				}
			})
			// $('#search_form').attr('action', '/restaurant/admin/findRes');
			// $('#search_form').submit();
		})		
	} // end fnFind()
	
	function fnPrintFindResList(map) {
		$('#tbody').empty();
		var p = map.pageUtils;
		var endRecord = p.endRecord;
		var beginRecord = p.beginRecord;
		var tbody = '';
		var addRow = '<tr><td></td><td></td><td></td><td></td></tr>';
		if (p.totalRecord == 0) {
			$('<tr rowspan="5">')
			.append( $('<td colspan="4">').text('등록된 식당이 없습니다.') )
			.appendTo('#tbody');
		} else {
			$.each (map.list, function(i, res) {
				tbody += '<tr>'
				tbody += '<td>' + res.resName + '</td>'
				tbody += '<td>' + res.resAddress + '&nbsp;' + res.resAddressDetail + '</td>'
				tbody += '<td>' + res.resOpenTime + '&nbsp;~&nbsp;' + res.resCloseTime + '</td>'
				tbody += '<td>' + res.resTel + '</td>'
				tbody += '<tr>'
			})
			for (let i = 0; i < 4 - (endRecord - beginRecord) ; i++) {
				tbody += addRow;
			}
			$('#tbody').append(tbody);
		}
	}
	
	function fnPrintResList(map) {
		$('#tbody').empty();
		var p = map.pageUtils;
		var endRecord = p.endRecord;
		var beginRecord = p.beginRecord;
		var tbody = '';
		var addRow = '<tr><td></td><td></td><td></td><td></td></tr>';
		if (p.totalRecord == 0) {
			$('<tr rowspan="5">')
			.append( $('<td colspan="4">').text('등록된 식당이 없습니다.') )
			.appendTo('#tbody');
		} else {
			$.each (map.resList, function(i, res) {
				tbody += '<tr>'
				tbody += '<td>' + res.resName + '</td>'
				tbody += '<td>' + res.resAddress + '&nbsp;' + res.resAddressDetail + '</td>'
				tbody += '<td>' + res.resOpenTime + '&nbsp;~&nbsp;' + res.resCloseTime + '</td>'
				tbody += '<td>' + res.resTel + '</td>'
				tbody += '<tr>'
			})
			for (let i = 0; i < 4 - (endRecord - beginRecord) ; i++) {
				tbody += addRow;
			}
			$('#tbody').append(tbody);
		}
	}
	
	
	
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
		if (p.page <= p.pagePerBlock) {
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
		if (p.page == p.totalPage) {
			$('<span class="disable_link">&gt;&gt;&nbsp;&nbsp;</span>').appendTo('#paging');
		} else {
			$('<span class="enable_link" data-page="'+p.totalPage+'">&gt;&gt;&nbsp;&nbsp;</span>').appendTo('#paging');
		}
	}  // end fnPrintPaging
	
	// 페이징 링크 처리 함수(전역변수 page값을 바꾸고, fnFindAllMember() 호출)
	function fnChangePage(){
		$('body').on('click', '.enable_link', function(){
			page = $(this).data('page');
			fnResList();
		});
	}  // end fnChangePage

	
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
    <section class="res_section">
        <div class="xx">
            <span class="res_title">식당 목록</span>
        </div>
        <form id="search_form">
	        <select id="column" name="column">
	            <option value="" selected>:: 선택 ::</option>
	            <option value="RES_NAME">이름</option>
	            <option value="RES_ADDRESS">주소(시,구)</option>
	            <option value="RES_ADDRESS_DETAIL">주소(상세주소)</option>
	            <option value="RES_TEL">전화번호</option>
	        </select>
	        <input type="text" class="select_text" id="query" name="query">
	        <input type="button" value="검색" id="search_btn" class="search_btn">
        </form>
        <table class="res_list_table">
            <thead>
                <tr>
                    <td>이름</td>
                    <td>주소</td>
                    <td>영업시간</td>
                    <td>전화번호</td>
                </tr>
            </thead>
            <tbody id="tbody">
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="4" id="paging"></td>
                </tr>
            </tfoot>
        </table>
    </section>
</body>
</html>