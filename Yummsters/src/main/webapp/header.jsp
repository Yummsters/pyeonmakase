<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
     <style>
        * {
            /* margin:0 auto; */
            font-family: 'NanumSquareRound', sans-serif;
        }
        a {
            text-decoration: none;
        } 
        /* 모든 링크 요소의 밑줄을 제거 */

        body {
            margin: 0 auto;
            background-color: #FBF9F3;
            width: 1000px;
            height: 200px;
        }

        nav ul {
            display: flex;
            justify-content: flex-end;
        }
        /* 내비게이션 목록을 가로로 나열하고 가운데 정렬 */
        
        nav ul li {
            width: 80px;
            height: 80px;
            display: flex; /* 방향을 정할 수 있음 */
            justify-content: center; /* 정렬된 기준 중앙정렬 */
            align-items: center; /* 정렬된 기준의 반대로 중앙정렬 */
            background-color: #EEC595;
            border-radius: 50px;
            margin: 10px;
            text-align: center;
        }
        /* 내비게이션 목록 항목의 패딩과 너비를 설정 */

        li a {
            color: #524434;
            font-weight: bold;
            font-size: 20px;
        }

        .header {
            width: 100%;
            height: 150px;
            display: flex;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .logo a span {
            color: rgba(255, 45, 0, 1);
            font-weight: 900;
            -webkit-text-stroke: 1.5px #EEC595;
            font-size: 3em;
            opacity: 1;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-right: 50px;
        }

        .logo img {
            width: 50px;
            height: 50px;
            margin-right: 10px;
        }

        .search {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            flex: 1;
            height: 100%;
            width: 500px;
        }

        .search input {
            border-style: solid;
            border-width: 5px;
            border-color: #EEC595;
            border-radius: 50px;
            width: 100%;
            height: 40px;
            overflow: auto;
            font-size: 20px;
            outline: none;
            box-sizing: content-box;
            padding-left: 20px;
        }

        .search img {
            position: absolute;
            width: 20px;
            height: 20px;
            right: 20px;
        }

        .foodCategory ul {
            display: flex;
        }

        .foodCategory ul li {
            width: 80px;
            height: 0px;
            display: flex; /* 방향을 정할 수 있음 */
            justify-content: center; /* 정렬된 기준 중앙정렬 */
            align-items: center; /* 정렬된 기준의 반대로 중앙정렬 */
            font-size: 20px;
            margin: 10px auto;
        }

        .foodCategory ul li :hover {
            color: coral;
            transition: 0.5s;
        }
        
        .foodCategory hr {
            border: 0;
            height: 5px;
            background-color: #EEC595;
        }

    </style>
    <script>
    $(function() {
    	$("#searchBtn").click(function() {
		var keyword = $("#search").val().trim(); // 값을 추출하여 앞뒤 공백제거 후 저장
        if (keyword.length < 2 || /^\s+$/.test(keyword)) { // 2글자 이상 입력, 공백 입력 방지
        	$("#search").val("").attr("placeholder", "검색어를 2글자 이상 입력해주세요.");
            return;
        }
		window.location.href = "search?keyword=" + keyword;
    	});
	});
	</script>
</head>

<body>
<div class="container">
    <div class="header">
        <div class="logo">
            <img src="imgView?file=market.png" alt="My Image">
            <a href="./" style="display: inline;"><span>편마카세</span></a>
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
</body>
</html>
