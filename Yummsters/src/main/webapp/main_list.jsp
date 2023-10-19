<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
// 체크박스 전체선택, 해제
$(function() {
	// 체크박스 전체선택, 해제
	$("#all").click(function() {
		// 전체 하위 체크박스들을 선택 또는 해제
		$("input[name='store']").prop("checked", $(this).prop("checked"));
	});

	// 하위 체크박스들 중 하나라도 선택 취소되면 "전체 선택" 체크박스도 선택 취소
	$("input[name='store']").click(function() {
		if ($("input[name='store']:checked").length === $("input[name='store']").length) {
			$("#all").prop("checked", true);
		} else {
			$("#all").prop("checked", false);
		}
	});

	// 하위 체크박스들을 모두 선택하면 "전체 선택" 체크박스도 선택
	$("input[name='store']").change(function() {
		if ($("input[name='store']:checked").length === $("input[name='store']").length - 1) {
			$("#all").prop("checked", true);
		}
	});
	
	// 체크박스 선택값 서버로 전송
	$("input[type='checkbox']").change(function() {
		// 현재 url의 파라미터 값 추출
		var storeNames = [];
		var urlParam = new URLSearchParams(window.location.search);
		
		var foodId = urlParam.get("foodId");
		var keyword = urlParam.get("keyword");
		
		var data = {storeNames:storeNames}; // 기본 전달 데이터
		
		if(foodId !== null) { // url 파라미터 foodId 있는 경우 data 함께 전달
			data.foodId = foodId;
		}
		if(keyword !== null) { // url 파라미터 keyword 있는 경우 data 함께 전달
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
</head>

<body>
	<jsp:include page="header.jsp" />
	<div class="body_container">

		<!-- 편의점 카테고리 선택 -->
		<div class="category">
			<input type="checkbox" name="store" id="all" value="전체" checked>
			<label for="all">전체</label>
			<input type="checkbox" name="store" id="cu" value="CU" checked> 
			<label for="cu"><img src="imgView?file=cu.png" alt=""></label> 
			<input type="checkbox" name="store" id="gs" value="GS" checked> 
			<label for="gs"><img src="imgView?file=gs.png" alt="" style="height:30px;"></label> 
			<input type="checkbox" name="store" id="seven" value="SEVEN" checked> 
			<label for="seven"><img src="imgView?file=7eleven.png" alt="" style="width:130px; height:45px;"></label>
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
