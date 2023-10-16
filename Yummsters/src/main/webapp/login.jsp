<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">

<!-- 네이버로그인 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

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
		  	<div id="naver_id_login"></div> <!-- 네이버 -->
		</div>
	</div>

	<jsp:include page="footer.jsp" />
</body>

  <script type="text/javascript">
  	var naver_id_login = new naver_id_login("{YOUR_CLIENT_ID}", "http://localhost:8090/yum/naverLogin.jsp");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("green", 2,40);
  	naver_id_login.setDomain("login.jsp"); // 처음엔 안됐는데 왜 지금은 되는거임?
  	naver_id_login.setState(state);
  	naver_id_login.setPopup(); // 팝업형태로 callbackURL 여는 것
  	naver_id_login.init_naver_id_login();
  </script>
  

<script>
    $(function () {
        $("#loginBtn").click(function (e) {
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
                success: function (res) {
                    if (res === "fail") {
                        console.log("로그인 실패");
                        $("#loginErr").text("아이디 또는 비밀번호를 잘못 입력했습니다").css("color", "red");
                    } else {
                        $(".loginForm").submit();
                        console.log("로그인 성공");
                        history.pushState(null, null, "./");
                        window.location.reload();
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            })
        })

        // 폼 제출 전 안내 초기화
        $(".login-form").on("input", function () {
            $("#loginErr").text("");
        });
    })
</script>


<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>

<script>
    Kakao.init('${kakao.javascript.key}');

    function kakaoLogin() {
        Kakao.Auth.login({
            success: function () {
                Kakao.API.request({
                    url: '/v2/user/me',
                    success: function (response2) {
                        console.log(response2);
                        var email = response2.kakao_account.email;
                        var nickname = response2.kakao_account.profile.nickname;

                        $.ajax({
                            url: 'kakaoLogin',
                            type: 'post',
                            data: {'email': email, 'nickname': nickname},
                            dataType: 'json',
                            success: function (response) {
                                console.log("로그인 성공")
                                alert("로그인 성공");
                                if (response.signup === true) {
                                    alert("회원가입 후 로그인이 완료되었습니다.");
                                    location.href = "home";
                                    return false;
                                }
                                if (response.login === true) {
                                    alert("로그인 완료되었습니다.");
                                    location.href = "home";
                                    return false;
                                }
                            },
                            error: function (request, status, error, response) {
								console.log(response);
                                console.log(error);
                                alert("code: " + request.status + " message: " + request.responseText + " error: " + error);
                            }
                        })
                    },
                    fail: function (error) {
                        alert(JSON.stringify(error))
                    },
                })
            },
            fail: function (error) {
                alert(JSON.stringify(error))
            },
        })
    }
</script>

