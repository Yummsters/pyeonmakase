<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script type="text/javascript">
$(function() {	
	// 게시글 더보기 기능 -------------------------------------------------------
	$(".card-box > .card").slice(12).hide();
    if ($(".card:visible").length === $(".card").length) { // 모든 카드가 출력되어 있는 경우 더보기 버튼 숨기기
        $(".more_btn").hide();
    }
	$(".more_btn").click(function() {
	    var visibleCards = $(".card:visible").length;
	    var cardsToShow = 12;
	
	    if (visibleCards < $(".card").length) {
	        $(".card").slice(visibleCards, visibleCards + cardsToShow).fadeIn();
	    }
	});

	// 최상단으로 이동하기 -------------------------------------------------------
	$(window).scroll(function() { // 버튼 노출
		if ($(this).scrollTop() > 500) {
			$('#scrollToTop').fadeIn();
		} else {
			$('#scrollToTop').fadeOut();
		}
	});

	$('#scrollToTop').click(function() { // 버튼 클릭시 상단 스크롤
		$('html, body').animate({scrollTop : 0}, 500);
		return false;
	});
	
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

        <!-- 전체 레시피 -->
        <div class="title-box">
            <div class="list-title">찜한 레시피</div>
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
        <div class="more_btn">더보기</div>
        <a class="scroll-to-top" id="scrollToTop">↑</a>

    </div>
    <jsp:include page="footer.jsp" />
</body>