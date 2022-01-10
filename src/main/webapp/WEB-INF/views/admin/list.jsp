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
<link href="<c:url value="/resources/css/adminCSS/adminUser.css"/>" rel="stylesheet">
<script src="<c:url value="/resources/js/index.js"/>"></script>
 <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
</head>
<body>
    <section class="result_section">
        <p class="comment">총 ${totalRecord}명의 회원이 검색되었습니다.</p>
        <table class="result_table">
            <thead>
                <tr>
                    <td>회원번호</td>
                    <td>아이디</td>
                    <td>이름</td>
                </tr>
            </thead>
            <tbody>
            	<c:if test="${empty list}">
   	        		<tr>
   	        			<td>${ownerList[0].ownerNo}</td>
   	        			<td>
   	        				<a href="/restaurant/admin/ownerDetailPage?ownerNo=${ownerList[0].ownerNo}">${ownerList[0].id}</a>
   	        			</td>
   	        			<td>${ownerList[0].name}</td>
   	        		</tr>
   	        		<tr>
   	        			<td>${ownerList[1].ownerNo}</td>
   	        			<td>
   	        				<a href="/restaurant/admin/ownerDetailPage?ownerNo=${ownerList[1].ownerNo}">${ownerList[1].id}</a>
   	        			</td>
   	        			<td>${ownerList[1].name}</td>
   	        		</tr>
   	        		<tr>
   	        			<td>${ownerList[2].ownerNo}</td>
   	        			<td>
   	        				<a href="/restaurant/admin/ownerDetailPage?ownerNo=${ownerList[2].ownerNo}">${ownerList[2].id}</a>
   	        			</td>
   	        			<td>${ownerList[2].name}</td>
   	        		</tr>
   	        		<tr>
   	        			<td>${ownerList[3].ownerNo}</td>
   	        			<td>
   	        				<a href="/restaurant/admin/ownerDetailPage?ownerNo=${ownerList[3].ownerNo}">${ownerList[3].id}</a>
   	        			</td>
   	        			<td>${ownerList[3].name}</td>
   	        		</tr>
   	        		<tr>
   	        			<td>${ownerList[4].ownerNo}</td>
   	        			<td>
   	        				<a href="/restaurant/admin/ownerDetailPage?ownerNo=${ownerList[4].ownerNo}">${ownerList[4].id}</a>
   	        			</td>
   	        			<td>${ownerList[4].name}</td>
   	        		</tr>
    	        	<c:if test="${empty list}">
	    	        	<c:if test="${not empty paging}">
		            		<tfoot>
				                <tr>
				                    <td colspan="4" class="paging_row">${paging}</td>
				                </tr>
		            		</tfoot>
	            		</c:if>    	        	
    	        	</c:if>
            	</c:if>
            	<c:if test="${empty ownerList}">
            		<tr>
   	        			<td>${list[0].userNo}</td>
   	        			<td>
   	        				<a href="/restaurant/admin/userDetailPage?userNo=${list[0].userNo}">${list[0].id}</a>
   	        			</td>
   	        			<td>${list[0].name}</td>
   	        		</tr>
            		<tr>
   	        			<td>${list[1].userNo}</td>
   	        			<td>
   	        				<a href="/restaurant/admin/userDetailPage?userNo=${list[1].userNo}">${list[1].id}</a>
   	        			</td>
   	        			<td>${list[1].name}</td>
   	        		</tr>
            		<tr>
   	        			<td>${list[2].userNo}</td>
   	        			<td>
   	        				<a href="/restaurant/admin/userDetailPage?userNo=${list[2].userNo}">${list[2].id}</a>
   	        			</td>
   	        			<td>${list[2].name}</td>
   	        		</tr>
            		<tr>
   	        			<td>${list[3].userNo}</td>
   	        			<td>
   	        				<a href="/restaurant/admin/userDetailPage?userNo=${list[3].userNo}">${list[3].id}</a>
   	        			</td>
   	        			<td>${list[3].name}</td>
   	        		</tr>
            		<tr>
   	        			<td>${list[4].userNo}</td>
   	        			<td>
   	        				<a href="/restaurant/admin/userDetailPage?userNo=${list[4].userNo}">${list[4].id}</a>
   	        			</td>
   	        			<td>${list[4].name}</td>
   	        		</tr>
    	        	<c:if test="${empty ownerList}">
	    	        	<c:if test="${not empty paging}">
		            		<tfoot>
				                <tr>
				                    <td colspan="4" class="paging_row">${paging}</td>
				                </tr>
		            		</tfoot>
	            		</c:if>    	        	
    	        	</c:if>
            	</c:if>
            </tbody>
        </table>
    </section>
</body>
</html>