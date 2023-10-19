<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="reply" items="${replyList}">
	<c:if test="${not empty reply}">
		<div class="reply_box">
			<div class="reply_one">
				<input type="hidden" class="replyId" value="${reply.reply_id}">
				<div class="replyNickname">${reply.nickname}</div>
				<div class="replyContent">${reply.content}</div>
			</div>
			<c:if test="${member.nickname eq reply.nickname}">
				<button class="reply_del" type="button"
					id="delete_button_${reply.reply_id}" onclick="deleteReply(${reply.reply_id}, event)">삭제</button>
			</c:if>
			<div class="replyRegdate">
				<fmt:formatDate value="${reply.regdate}" pattern="yyyy-MM-dd HH:mm:ss" />
			</div>
		</div>
	</c:if>
</c:forEach>

