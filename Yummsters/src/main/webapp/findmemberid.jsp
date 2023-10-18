<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">
<html>
<head>
<title>아이디 찾기</title>
<script>
    $(document).ready(function() {
        // 아이디 찾기 버튼 클릭 이벤트
        $('#findId').click(function() {
            var name = $('#name').val();
            var nickname = $('#nickname').val();
            var email = $('#email').val();

            // 입력값이 비어있는지 확인
            if (name === "" || nickname === "" || email === "") {
                alert("모든 정보를 입력해주세요.");
                return;
            }

            // 서버로 요청을 보내 아이디를 찾음
            $.ajax({
                type: 'POST',
                url: 'findmemberid', // 실제 서블릿 URL로 변경해야 함
                data: {
                    member_name: name,
                    nickname: nickname,
                    email: email
                },
                success: function(response) {
                    // 서버에서 받은 응답을 처리                   
                    $('#IdResult').text(response);
                },
                error: function() {
                    alert("서버 오류가 발생했습니다.");
                }
            });
        });
    });
</script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="body_container">
	<div class="login-box">
		<div class="mem-title">아이디 찾기</div>
		<form class="login-form">
			<div class="login-form-wrap">
				<input type="text" id="name" name="name" required placeholder="이름을 입력하세요" />
			</div>
			<div class="login-form-wrap">
				<input type="text" id="nickname" name="nickname" required placeholder="닉네임을 입력하세요">
				<span id="nicknameErr"></span><br>
			</div>
			<div class="login-form-wrap">
				<input type="email" id="email" name="email" required placeholder="이메일을 입력하세요">
			</div>
			<input type="button" value="아이디 찾기" id="findId">
		</form>
			<div class="loginSub">
				<div class="findIdPw"><a href="login">로그인</a> 하기 / <a href="findmemberpw">비밀번호</a> 찾기</div>
			</div>
			<p id="IdResult"></p>
	</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
