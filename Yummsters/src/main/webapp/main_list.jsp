<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>

/* 카드 영역 */
.card-box {
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
	margin: 0 auto 100px auto;
	max-width: 1000px;
}
#emptyboard {
	text-align: center;
	margin: 60px auto;
	color: #524434;
	font-weight: 800;
	font-size: 30px;
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

.recipe-name {
	text-align: center;
	font-size: 25px;
}

.store-name {
	margin-top: 10px;
	text-align: center;
	font-size: 15px;
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
}

.title {
	color: #524434;
	font-weight: 800;
	font-size: 30px;
	margin: 30px 0 10px 10px;
}

.register {
	cursor: pointer;
	margin: 30px 10px 10px 10px;
	padding: 10px;
	border-radius: 20px;
	border: 0.5px solid #FFF;
	background: #EEC595;
	font-size: 20px;
	color: #524434;
	font-weight: bold;
}
.register > a {
	text-decoration: none;
	color: #524434;
}

/* 타이틀 영역 끝 */

/* 카테고리 영역 */
.category {
	background: #EEC595;
	margin: 100px auto 30px auto;
	padding: 0 30px;
	display: flex;
	flex-direction: row;
	align-items: center;
	/* 수직 가운데 정렬 */
	justify-content: space-between;
	/* 수평 정렬*/
	height: 100px;
	font-size: 20px;
	border-radius: 10px;
}

.category img {
	height: 40px;
}

.category label {
	display: inline-block;
	margin-right: 50px;
}

input[type="checkbox"] {
	width: 30px;
	height: 30px;
}

/* 더보기 버튼 */
.more_btn {
	text-align: center;
	margin: 20px auto;
	display: block;
	cursor: pointer;
	padding: 10px 20px;
	background: #EEC595;
	border: 0.5px solid #FFF;
	border-radius: 20px;
	font-size: 20px;
	color: #524434;
	font-weight: bold;
	width: 150px;
	height: 20px;
}

/* 최상단 버튼 */
.scroll-to-top {
	display: none; /* 초기에는 숨김 상태 */
	position: fixed;
	bottom: 30px;
	right: 50px;
	background-color: #EEC595;
	color: #524434;
	border: 1px solid #FFF;
	border-radius: 50%;
	padding: 20px 30px;
	font-size: 40px;
	cursor: pointer;
}
</style>

<script>
// 체크박스 전체선택, 해제
$(function() {
	// 체크박스 전체선택, 해제
	$("#all").click(
			function() {
				// 전체 하위 체크박스들을 선택 또는 해제
				$("input[name='store']").prop("checked",
						$(this).prop("checked"));
			});

	// 하위 체크박스들 중 하나라도 선택 취소되면 "전체 선택" 체크박스도 선택 취소
	$("input[name='store']")
			.click(
					function() {
						if ($("input[name='store']:checked").length === $("input[name='store']").length) {
							$("#all").prop("checked", true);
						} else {
							$("#all")
									.prop("checked", false);
						}
					});

	// 하위 체크박스들을 모두 선택하면 "전체 선택" 체크박스도 선택
	$("input[name='store']")
			.change(
					function() {
						if ($("input[name='store']:checked").length === $("input[name='store']").length - 1) {
							$("#all").prop("checked", true);
						}
					});
	
	// 체크박스 선택값 서버로 전송
	$("input[type='checkbox']").change(function() {
		// 현재 url의 파라미터 값 추출
		var storeNames = [];
		var currentURL =  window.location.href;
		var urlParam = new URLSearchParams(window.location.search);
		
		var foodId = urlParam.get("foodId");
		var keyword = urlParam.get("keyword");
		
		var data = {storeNames:storeNames}; // 기본 전달 데이터
		
		if(foodId !== null) { // url 파라미터 foodId 있는 경우 data 함께 전달.
			data.foodId = foodId;
		}
		if(keyword !== null) { // url 파라미터 keyword 있는 경우 data 함께 전달.
			data.keyword = keyword;
		}
		
		$("input[name='store']:checked").each(function() {
			storeNames.push($(this).val());
		});
		
		$.ajax({
			url: "mainlist",
			type:"post",
			data: data, // 조건부로 구성된 data 전송
			success: function(data) {
				$(".reloading").find(".board-box").html(data);
				console.log("ajax 요청 성공, foodId: " + ", storeNames: " + storeNames);
			},
			error: function(error) {
				console.log("ajax 요청 실패 : " + error);
			}
		});

	});

	//-------------------------------------------------------
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
				$(".card").slice(
						visibleCards,
						visibleCards
								+ cardsToShow)
						.fadeIn();

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
	})
});
</script>
</head>

<body>
	<jsp:include page="header.jsp" />
	<div class="container">

		<!-- 편의점 카테고리 선택 -->
		<div class="category">
			<input type="checkbox" name="store" id="all" value="전체" checked>
			<label for="all">전체</label>
			<input type="checkbox" name="store" id="cu" value="CU" checked> 
			<label for="cu"><img src="imgView?file=cu.png" alt=""></label> 
			<input type="checkbox" name="store" id="gs" value="GS25" checked> 
			<label for="gs"><img src="imgView?file=gs.png" alt="" style="height:30px;"></label> 
			<input type="checkbox" name="store" id="seven" value="SEVEN" checked> 
			<label for="seven"><img src="imgView?file=seven.png" alt=""></label>
			<input type="checkbox" name="store" id="etc" value="기타" checked>
			<label for="etc">기타</label>
		</div>
		
        <div class="reloading">
            <jsp:include page="boardCard.jsp" />
        </div>
<div class="more_btn">더보기</div>
		<div class="scroll-to-top" id="scrollToTop">↑</div>

	</div>
	<jsp:include page="footer.jsp" />
</body>

</html>