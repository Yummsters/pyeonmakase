<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<script>
$(function() {
   	$("#searchBtn").click(function() {
	var keyword = $("#search").val().trim(); // 값을 추출하여 앞뒤 공백제거 후 저장
       // 2글자 이상 입력, 공백 입력 방지
       if (keyword.length < 2 || /^\s+$/.test(keyword)) {
       	$("#search").val("").attr("placeholder", "검색어를 2글자 이상 입력해주세요.");
           return;
       }
	window.location.href = "mainlist?keyword=" + keyword;
   	});
});
</script>
<div class="header_container">
    <div class="header">
        <div class="logo">
            <img src="imgView?file=market.png" alt="My Image" id="market">
            <a href="./" style="display: inline;"><img src="imgView?file=편마카세 로고.png" alt="My Image" id="편마카세"></a>
        </div>
        <div class="search">
            <input type="text" id="search" name="search" placeholder="레시피 검색">
            <img src="imgView?file=searching.png" id="searchBtn" alt="My Image">
        </div>
        <nav>
        <c:choose>
        	<c:when test="${member eq empity}">
	            <ul>
	                <li><a href="signup">회원<br>가입</a></li>
	                <li><a href="login">로그인</a></li>
	            </ul>
            </c:when>
            <c:otherwise>            
	            <ul>
	                <li><a href="mypage">마이<br>페이지</a></li>
	                <li><a href="register">레시피<br>등록</a></li>
	                <li><a href="logout">로그<br>아웃</a></li>
	            </ul>
            </c:otherwise>
        </c:choose>
        </nav>
    </div>
    <div class="foodCategory">
        <ul>
            <li><a href="mainlist?foodId=1">식사류</a></li>
            <li><a href="mainlist?foodId=2">간식류</a></li>
            <li><a href="mainlist?foodId=3">음료</a></li>
        </ul>
        <hr>
    </div>
</div>