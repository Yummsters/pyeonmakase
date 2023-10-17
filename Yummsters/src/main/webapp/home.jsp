<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">
<!-- Slick Carousel CSS -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<!-- jQuery (Slick Carousel dependency) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Slick Carousel JavaScript -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script>
	$(function() {
		$('.card-slider').slick({
			slidesToShow : 5, // 한 번에 보여줄 개수
			slidesToScroll : 5, // 다섯개씩 넘기며 보여주기 (총 2페이지로 구성)
			autoplay : true,
			autoplaySpeed : 2500, // 넘기는 속도
			dots : true,
		});

		// 게시글 더보기 기능
		// 초기에는 처음 5개 카드만 보이도록 설정
		$(".card-box > #card").slice(5).hide();

		// 게시글 디테일(boardDetail) 이동
		$("#card").click(function() {
			var boardId = $(this).find(".boardId").val();
			window.location.href = "boardDetail?board_id=" + boardId;
		});
	});
</script>

</head>

<body>
	<jsp:include page="header.jsp" />
	<div class="body_container">
	<div class="list_container">
		<!-- 추천 TOP10 -->
		<div class="list-title">추천 TOP 10</div>
		<!-- 카드 부분 db생기면 {data} 반복 돌리기 -->
		<div class="card-slider">
			<c:forEach var="board" items="${boardListTop10}">
				<div class="card">
					<c:if test="${not empty boardList}">
						<input type="hidden" class="boardId" value="${board.board_id}">
						<div id="recommend">♥ ${board.recommand_count}</div>
						<div class="thumbnail">
							<img src="imgView?file=${board.picture}" alt="">
						</div>
						<div id="recipe-name">${board.title}</div>
						<div id="store-name">#${board.store_category_name}</div>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- 전체 레시피 -->
	<div class="title-box">
		<div class="list-title">전체 레시피</div>
		<div class="more">
			<a href="mainlist">더보기</a>
		</div>
	</div>

	<!-- 여기는 출력만 -->
	<div class="card-box">
		<c:forEach var="board" items="${boardList}">
			<div id="card">
				<c:if test="${not empty boardList}">
					<input type="hidden" class="boardId" value="${board.board_id}">
					<div id="recommend">♥ ${board.recommand_count}</div>
					<div id="thumbnail">
						<img src="imgView?file=${board.picture}" alt="">
					</div>
					<div id="recipe-name">${board.title}</div>
					<div id="store-name">#${board.store_category_name}</div>
				</c:if>
			</div>
		</c:forEach>
	</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>

</html>