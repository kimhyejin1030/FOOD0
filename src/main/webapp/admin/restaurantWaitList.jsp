<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>restaurantWaitList</title>

<!-- css 파일 -->
<link href="./css/footer.css" rel="stylesheet">
<link href="./css/header.css" rel="stylesheet">
<link href="./css/sideMenu.css" rel="stylesheet">
<link href="./css/main.css" rel="stylesheet">


<script type="text/javascript">
	function winopen(rest_id){
		let popupX = (window.screen.width / 2) - (500 / 2);
		let popupY= (window.screen.height / 2) - (300 / 2);
		
		window.open("ApprovalCheck.ad?rest_id=" + rest_id, "", 
		"width=500,height=300,left="+ popupX + ',top='+ popupY + ',screenX='+ popupX + 
		 ',screenY= '+ popupY);
	}
</script>

</head>
<body>
		
<!-- header -->
<jsp:include page="../inc/headerDiv.jsp" />
<!-- header -->

<!-- sideMune -->
<jsp:include page="../inc/sideMenuAdmin.jsp" />
<!-- sideMune -->

<!-- main -->
<main>
<br><br>
	<table border="1">
		<tr>
			<th>No.</th>
			<th>상호명</th>
			<th>업종</th>
			<th>점주 아이디</th>
			<th>전화번호</th>
			<th>등록일</th>
			<th>승인/반려</th>
			<th>상세</th>
		</tr>
		
		<c:forEach var="dto" items="${restWaitList}" varStatus="no">
		<tr>
			<td>${no.count}</td>
			<td>${dto.name}</td>
			<td>${dto.category}</td>
			<td>${dto.owner_user_id}</td>
			<td>${dto.rest_tel}</td>
			<td>${dto.regdate}</td>
			<td>
				<button type="submit" onclick="winopen('${dto.rest_id}');">승인/반려</button>
			</td>
			<td>
				<form action="./RestaurantInfo.ad" method="post">
					<input type="hidden" name="pageNum" value="${pageNum}">
					<input type="hidden" name="rest_id" value="${dto.rest_id}">
					<input type="hidden" name="rstatus" value="no">
					<input type="submit" value="상세보기">
				</form>
			</td>
		</tr>
		</c:forEach>
	</table>
	
		<%
		int count = (int)request.getAttribute("count");
		int pageNum = Integer.parseInt((String)request.getAttribute("pageNum"));
		int pageSize = (int)request.getAttribute("pageSize");
		
		if(count != 0) {
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int pageBlock = 5;
			int startPage = ((pageNum - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			
			if(endPage > pageCount) {
				endPage = pageCount;
			}
			
			if(startPage > pageBlock) {
	%>
				<a href="./RestaurantWaitList.ad?pageNum=<%=startPage - pageBlock%>">[이전]</a>
	<%
			}
			for(int i = startPage; i <= endPage; i++) {
	%>
				<a href="./RestaurantWaitList.ad?pageNum=<%=i%>">[<%=i%>]</a>
	<%
			}
			if(endPage < pageCount) {
	%>
				<a href="./RestaurantWaitList.ad?pageNum=<%=startPage + pageBlock%>">[다음]</a>
	<%
			}
		}
	%>
</main>
<!-- main -->
	
	
<!-- footer -->
<jsp:include page="../inc/footerDiv.jsp" />
<!-- footer -->
	
	
</body>
</html>