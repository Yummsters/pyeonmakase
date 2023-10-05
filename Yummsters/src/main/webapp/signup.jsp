<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
        .input-with-button {
            width: 80%; 
            padding: 13px 10px;
            margin: 15px auto;
            border-bottom: 3px solid #EEC595;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
        }
        .input-with-button > input {
            border: none;
            font-size: 16px;
            width: 80%;
        }
        .input-with-button > button {
            border-radius: 5px;
            border: 1px solid #EEC595;
            background: #EEC595;
            font-size: 15px;
            cursor: pointer; 
        }

        /* 가입하기 버튼 */
        .join-form > input[type="submit"] {
            display:inline-block;
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
    </style>
    
<body>
<jsp:include page="header.jsp" />
    <div class="join-box">
        <div class="title">회원가입</div>

        <form class="join-form">
            <div class="input-with-button">
            <input type="text" id="name" name="name" required placeholder="이름을 입력하세요"></div>

            <div class="input-with-button">
                <input type="text" id="nickname" name="nickname" required placeholder="닉네임을 입력하세요">
                <button type="button" id="check-nickname">중복확인</button>
            </div>

            <div class="input-with-button">
                <input type="email" id="email" name="email" required placeholder="이메일을 입력하세요">
                <button type="button" id="check-email">중복확인</button>
            </div>

            <div class="input-with-button">
            <input type="text" id="id" name="id" required placeholder="아이디를 입력하세요">
            <button type="button" id="check-id">중복확인</button>
            </div>
            
            <div class="input-with-button">
            <input type="password" id="password" name="password" required placeholder="비밀번호를 입력하세요 (숫자, 영문, 특수기호 포함 10자리 이상)"></div>

            <div class="input-with-button">
            <input type="password" id="check-password" name="check-password" required placeholder="비밀번호를 다시 입력하세요"> </div>  

            <input type="submit" value="가입하기">
        </form>
        
    </div>

<jsp:include page="footer.jsp" />
</body>
