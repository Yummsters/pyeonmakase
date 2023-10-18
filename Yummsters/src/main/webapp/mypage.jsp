<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {	
	// 게시글 디테일(boardDetail) 이동 -------------------------------------------------------
	$(document).on("click", ".card", function() {
	    var boardId = $(this).find(".boardId").val();
	    window.location.href = "boardDetail?board_id=" + boardId;
	});
});
</script>
<body>
	<jsp:include page="header.jsp" />
	<div class="body_container">
	<div class="title-box">
		<div class="list-title">${member.nickname} 셰프님 마이페이지</div>
		<p>
			<a href="userinfo"><input id="user_btn" type="submit"
				value="회원정보"></a>
		</p>
	</div>

	<div class="line"></div>

	<!-- mylist  -->
	<div class="title-box">
		<div class="list-title">내가 작성한 레시피</div>
		<div class="more">
			<a href="mylist">더보기</a>
		</div>
	</div>
	<div class="line"></div>
	<div class="card-box">
	<c:forEach var="board" items="${myList}">
		<div class="card">
		<c:if test="${not empty myList}">
			<input type="hidden" class="boardId" value="${board.board_id}">
			<div class="recommend">♥ ${board.recommand_count}</div>
			<div class="thumbnail">
				<img src="imgView?file=${board.picture}" alt="">
			</div>
			<div class="recipe-name">${board.title}</div>
			<div class="store-name">#${board.store_category_name}</div>
		</c:if>
		</div>
	</c:forEach>
	</div>
						
	<!-- wishlist  -->
	<div class="title-box">
		<div class="list-title">찜한 레시피</div>
		<div class="more">
			<a href="wishlist">더보기</a>
		</div>
	</div>

	<div class="line"></div>
	<div class="card-box">
		<c:forEach var="board" items="${wishList}">
			<div class="card">
			<c:if test="${not empty wishList}">
				<input type="hidden" class="boardId" value="${board.board_id}">
				<div class="recommend">♥ ${board.recommand_count}</div>
				<div class="thumbnail">
					<img src="imgView?file=${board.picture}" alt="">
				</div>
				<div class="recipe-name">${board.title}</div>
				<div class="store-name">#${board.store_category_name}</div>
			</c:if>
			</div>
		</c:forEach>
	</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>