<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">

<body>
	<jsp:include page="header.jsp" />
	<div class="login-box">
		<div class="mem-title">로그인</div>

		<form class="login-form" method="post" action="login">
			<div class="login-form-wrap">
				<input type="text" id="id" name="id" required
					placeholder="아이디를 입력하세요" />
			</div>
			<div class="login-form-wrap">
				<input type="password" id="password" name="password" required
					placeholder="비밀번호를 입력하세요">
			</div>
			<div id="loginErr"></div>
			<input type="submit" value="로그인" id="loginBtn">

			<div class="join">
				회원이 아니신가요? <a href="signup">회원가입</a>
			</div>
		</form>

		<div class="social-title">
			소셜 로그인 / 회원가입<br>추후 구현
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>
<script>
$(function() {
    $("#loginBtn").click(function(e) {
        e.preventDefault(); // 폼 제출 방지
        var id = $("#id").val();
        var password = $("#password").val();
        
    	$.ajax({
    		url: "login", // 서블릿 주소
            type: "post", // method 타입
            data: { // 서버로 보낼 데이터
				id: id,
				password: password
            },
            success: function(res) {
            	if(res === "fail") {
            		console.log("로그인 실패");
	        		$("#loginErr").text("아이디 또는 비밀번호를 잘못 입력했습니다").css("color", "red");
            	} else {
            		$(".loginForm").submit();
            		console.log("로그인 성공");
            		history.pushState(null, null, "./");
            		window.location.reload();
            	}
			},
            error: function(err) {
            	console.log(err);
            }
    	})
    })
    
    // 폼 제출 전 안내 초기화
    $(".login-form").on("input", function() {
        $("#loginErr").text("");
    });
})
</script>
</html>