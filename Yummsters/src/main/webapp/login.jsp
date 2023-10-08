<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
        /* form 전체 틀 */
        .join-box {
            border-radius: 20px;
            border: 5px solid #EEC595;
            background: #FFF;
            width: 800px;
            margin: 100px auto;
            text-align: center;
        }

        /* form 제목 */
        .title {
            font-size: 20px;
            color: #524434;
            font-weight: bold;
            margin: 20px auto;
        }

        /* input 태그 */
        #id, #password, #check-password {
            width: 80%; 
            padding: 10px; 
            margin: 10px auto;
            border: none;
            border-bottom: 3px solid #EEC595;
            font-size: 16px;
        }

        /* 로그인 버튼 */
		.join-form #loginBtn {
            margin: 30px auto;
            width: 75%;
            height: 30px;
            border-radius: 5px;
            border: 1px solid #EEC595;
            background: #EEC595;
            color: #FFF;
            text-align: center;
            font-size: 17px;
        }

        /* input 태그 클릭 시 테두리 표시되지 않도록 설정 */
        .join-form > input:focus {outline: none;}

        /* join 페이지 이동 */
        .join, .join>a {
            text-align: right;
            margin: 0 30px 30px 0;
            color: #524434;
        }
		.join>a {
            text-decoration: underline;
        }
        /* 소셜 로그인 */
        .social-title {
            color: #524434;
            text-align: center;
            font-size: 17px;
        }
    </style>

<body>
<jsp:include page="header.jsp" />
<div class="join-box">
    <div class="title">로그인</div>

    <form class="join-form" method="post">
        <input type="text" id="id" name="id" required placeholder="아이디를 입력하세요">
        
        <input type="password" id="password" name="password" required placeholder="비밀번호를 입력하세요">

        <input type="submit" value="로그인" id="loginBtn">
        
        <div class="join">회원이 아니신가요? <a href="signup">회원가입</a></div>
    </form>

    <div class="social-title">소셜 로그인 / 회원가입<br>추후 구현</div>
</div>

    <jsp:include page="footer.jsp" />
</body>
</html>