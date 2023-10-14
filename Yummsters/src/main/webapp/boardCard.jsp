<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="board-box">
	<div class="title-box">
		<div class="title">
			<c:choose>
				<c:when test="${foodId eq 1}">식사류 레시피</c:when>
				<c:when test="${foodId eq 2}">간식류 레시피</c:when>
				<c:when test="${foodId eq 3}">음료 레시피</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${param.keyword != null}">"${param.keyword}" 검색 결과</c:when>
						<c:otherwise>전체 레시피</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</div>
		<a href="register"><button class="registerBtn">레시피 등록</button></a>
	</div>

	<div class="card-box">
		<c:choose>
			<c:when test="${not empty boardList}">
				<c:forEach items="${boardList}" var="board">
					<div class="card">
						<input type="hidden" name="foodId"
							value="${board.food_category_id}"> <input type="hidden"
							class="boardId" value="${board.board_id}">
						<div class="recommend">♥ ${board.recommand_count}</div>
						<div class="thumbnail">
							<img src="imgView?file=${board.picture}" alt="">
						</div>
						<div class="recipe-name">${board.title}</div>
						<div class="store-name">#${board.store_category_name}</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<p id="emptyboard">게시글이 없습니다.</p>
			</c:otherwise>
		</c:choose>
	</div>
</div>