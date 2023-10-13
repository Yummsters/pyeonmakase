<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>편마카세</title>
<style>

/*회원정보 버튼 */
#user_btn {
	border: none;
	width: 200px;
	height: 30px;
	font-size: 20px;
	color: white;
	background-color: #EEC595;
	border-radius: 30px;
}

.line {
	width: 100%;
	height: 3px;
	background-color: #EEC595;
}

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
	width: calc(33.33% - 20px);
	margin-bottom: 20px;
}

.recommend {
	color: #00000080;
	font-size: 20px;
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

/* 타이틀 영역 */
.title-box {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 30px 10px 0 0;
	color: #524434;
	clear: left; /*display: flex 사용하는게 나으려나..*/
}

.title {
	color: #524434;
	font-weight: 800;
	font-size: 1.5rem;
	margin: 30px 0 10px 10px;
}

.more {
	cursor: pointer; /*더보기 onclick 설정하기*/
	margin: 30px 10px 10px 10px;
}
/* 타이틀 영역 끝 */
a {
	text-decoration: none;
	color: black;
}
</style>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		$('.card-slider').slick({
			slidesToShow : 5, // 한 번에 보여줄 개수
			slidesToScroll : 5, // 다섯개씩 넘기며 보여주기 (총 2페이지로 구성)
			autoplay : true,
			autoplaySpeed : 2500, // 넘기는 속도
			dots : true,
		});

		// 게시글 더보기 기능
		// 초기에는 처음 12개 카드만 보이도록 설정
		$(".card-box > .card").slice(12).hide();
		// $(".card-box > .card").slice(0, 3).show();

		// // "더 보기" 버튼 클릭 시 추가 카드 12개를 보이도록 설정
		$(".more_btn").click(
				function() {
					// 현재 표시되고 있는 카드의 개수를 가져옵니다.
					var visibleCards = $(".card:visible").length;

					// 추가로 표시할 카드의 개수를 설정합니다.
					var cardsToShow = 12;

					// 추가로 표시할 카드가 남아있는 경우에만 처리
					if (visibleCards < $(".card").length) {
						// 다음 12개 카드를 보이도록 설정
						$(".card").slice(visibleCards,
								visibleCards + cardsToShow).fadeIn();

						// 모든 카드가 표시되면 "더 보기" 버튼 숨김
						if ($(".card:visible").length === $(".card").length) {
							$(".more_btn").hide();
						}
					}
				});

		//-------------------------------------------------------
		// 최상단으로 이동하기
		// 버튼 노출
		$(window).scroll(function() {
			if ($(this).scrollTop() > 400) {
				$('#scrollToTop').fadeIn();
			} else {
				$('#scrollToTop').fadeOut();
			}
		});

		// 버튼 클릭시 상단 스크롤
		$('#scrollToTop').click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 500);
			return false;
		});

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

	<div class="title-box">
		<div class="title">${member.nickname}마이페이지</div>
		<p>
			<a href="userinfo"><input id="user_btn" type="submit"
				value="회원정보"></a>
		</p>
	</div>

	<div class="line"></div>

	<!-- mylist  -->
	<div class="title-box">
		<div class="title">내가 작성한 레시피</div>
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
			<div class="store-name">#${board.store_category_name}</div>
			<div class="recipe-name">${board.title}</div>
		</c:if>
		</div>
	</c:forEach>
	</div>
			
			
		<!-- <div class="card" onclick="location.href={bno}"> -->
			

	<!-- wishlist  -->
	<div class="title-box">
		<div class="title">찜한 레시피</div>
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
				<div class="store-name">#${board.store_category_name}</div>
				<div class="recipe-name">${board.title}</div>
			</c:if>
			</div>
		</c:forEach>
	</div>

	<jsp:include page="footer.jsp" />
</body>
</html>