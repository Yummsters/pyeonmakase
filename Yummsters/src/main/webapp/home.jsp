<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Slick Carousel CSS -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<!-- jQuery (Slick Carousel dependency) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Slick Carousel JavaScript -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<style>
.card-slider {
	
}

/* 카드 영역 */
.card-box {
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
	margin: 0 auto;
	max-width: 1000px;
}

.card {
	margin: 10px;
	padding: 10px;
	box-sizing: border-box;
	background-color: white;
	border-radius: 10px;
	width: calc(20% - 20px);
	height: 300px;
	margin-bottom: 20px;
}

#card:nth-child(n+6) {
	display: none; /* 6번째 이후의 카드는 숨김 처리 */
}

.recommend {
	color: #00000080;
	font-size: 16px;
}

.thumbnail {
	position: relative;
}

.thumbnail img {
	max-width: 100%;
	height: auto;
	display: block;
	margin: 5px auto 30px auto;
	/* width: 90%; */
}

.store-name {
	color: gray;
	text-align: center;
	margin: 5px;
}

.recipe-name {
	text-align: center;
	font-size: 20px;
}

/* 레시피 카드 영역 끝 */

/* 타이틀 영역 */
.title-box {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 30px 10px 10px 0;
	color: #524434;
	clear: left;
	/*display: flex 사용하는게 나으려나..*/
}

.title {
	color: #524434;
	font-weight: 800;
	font-size: 1.5rem;
	margin: 30px 0 10px 10px;
}

.more {
	cursor: pointer;
	/*더보기 onclick 설정하기*/
	margin: 30px 10px 10px 10px;
}
/* 타이틀 영역 끝 */

/* 슬라이더 */
/* 슬라이더에서 버튼 표시하지 않았으나 계속해서 노출되어 따로 css 지정해줌 */
.slick-prev, .slick-next {
	display: none !important;
}

.slick-dots {
	text-align: center;
	list-style: none;
	padding: 0;
	margin: 10px 0;
}

.slick-dots li {
	display: inline-block;
	margin: 0 5px;
}

.slick-dots li button {
	border: none;
	border-radius: 50%;
	width: 15px;
	height: 15px;
	background-color: #D9D9D9;
	color: rgba(0, 0, 0, 0.01); /* 페이지 번호 숨기기 위해 투명도 0.01로 설정 */
	cursor: pointer;
}

.slick-dots li button:before {
	color: transparent !important;
}

.slick-dots li.slick-active button { /* 활성화된 버튼 배경색 */
	background-color: #EEC595;
}
</style>

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
		$(".card-box > .card").slice(5).hide();

		// 게시글 디테일(boardDetail) 이동
		$(".card").click(function() {
			var boardId = $(this).find(".boardId").val();
			window.location.href = "boardDetail?board_id=" + boardId;
		});
	});
</script>


</head>

<body>
	<jsp:include page="header.jsp" />
	<div class="container">

		<!-- 추천 TOP10 -->
		<div class="title">추천 TOP 10</div>
		<!-- 카드 부분 db생기면 {data} 반복 돌리기 -->
		<div class="card-slider">
			<c:forEach var="board" items="${boardListTop10}">
				<div class="card">
				<c:if test="${not empty boardListTop10}">
					<c:choose>
						<c:when test="${board.store_category_name ne '전체'}">
							<input type="hidden" class="boardId" value="${board.board_id}">
							<div class="recommend">♥ ${board.recommand_count}</div>
							<div class="thumbnail">
								<img src="imgView?file=${board.picture}" alt="">
							</div>
							<div class="recipe-name">${board.title}</div>
							<div class="store-name">#${board.store_category_name}</div>
						</c:when>
						<c:otherwise>
							<input type="hidden" class="boardId" value="${board.board_id}">
							<div class="recommend">♥ ${board.recommand_count}</div>
							<div class="thumbnail">
								<img src="imgView?file=${board.picture}" alt="">
							</div>
							<div class="recipe-name">${board.title}</div>
							<div class="store-name">#CU #GS25 #7Eleven #기타</div>
						</c:otherwise>
					</c:choose>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- 전체 레시피 -->
	<div class="title-box">
		<div class="title">전체 레시피</div>
		<div class="more">
			<a href="mainlist">더보기</a>
		</div>
	</div>

	<!-- 여기는 출력만 -->
	<div class="card-box">
		<c:forEach var="board" items="${boardList}">
			<div class="card">
				<c:if test="${not empty boardList}">
					<c:choose>
						<c:when test="${board.store_category_name ne '전체'}">
							<input type="hidden" class="boardId" value="${board.board_id}">
							<div class="recommend">♥ ${board.recommand_count}</div>
							<div class="thumbnail">
								<img src="imgView?file=${board.picture}" alt="">
							</div>
							<div class="recipe-name">${board.title}</div>
							<div class="store-name">#${board.store_category_name}</div>
						</c:when>
						<c:otherwise>
							<input type="hidden" class="boardId" value="${board.board_id}">
							<div class="recommend">♥ ${board.recommand_count}</div>
							<div class="thumbnail">
								<img src="imgView?file=${board.picture}" alt="">
							</div>
							<div class="recipe-name">${board.title}</div>
							<div class="store-name">#CU #GS25 #7Eleven #기타</div>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>
		</c:forEach>
	</div>

	<jsp:include page="footer.jsp" />
</body>

</html>