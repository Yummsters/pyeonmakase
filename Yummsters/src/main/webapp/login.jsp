<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">

<!-- 네이버로그인 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<body>
	<jsp:include page="header.jsp" />
	<div class="body_container">
	<div class="login-box">
		<div class="mem-title">로그인</div>

		<form class="login-form">
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

			<div class="loginSub">
				<div class="join"><a href="signup">회원가입</a> | <a href="findmemberid">아이디찾기</a> | <a href="findmemberpw">비밀번호찾기</a></div>
			</div>
		</form>

		<div class="social-title">소셜 로그인/회원가입</div>
		<div class="social-box">
			 <div id="naver_id_login"></div> <!-- 네이버 -->
			 <a href="javascript:kakaoLogin()"><img src="imgView?file=kakao_logo.png" id="kakaoLogo"></a> <!-- 카카오 -->
		</div>
	</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>

  <script type="text/javascript">
  	var naver_id_login = new naver_id_login("${client_id}", "http://localhost:8090/naverLogin.jsp");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("green", 1, 50);
  	naver_id_login.setDomain("login.jsp"); 
  	naver_id_login.setState(state);
  	naver_id_login.setPopup();
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
                data: { id: id, password: password}, // 서버로 보낼 데이터
                success: function (res) {
                    if (res === "fail") {
                        $("#loginErr").text("아이디 또는 비밀번호를 잘못 입력했습니다").css("color", "red");
                    } else {
                        $(".loginForm").submit();
                        history.pushState(null, null, "./");
                        window.location.reload();
                    }
                },
                error: function (err) {
                	swal({
						title: '서버 오류가 발생했습니다 \n 관리자에게 문의하세요',
						icon: 'error',
						buttons: {
							confirm: {
								text: '확인',
								value: true,
								visible: true,
								className: 'swal-custom' // 사용자 정의 클래스 추가
							}
						}
					})
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
    Kakao.init('${kakao.script.key}'); // commit 할 때는 얘 제외하고 하기
    function kakaoLogin() {
        Kakao.Auth.login({
            success: function () {
                Kakao.API.request({
                    url: '/v2/user/me',
                    success: function (response2) {
                        var email = response2.kakao_account.email;
                        var nickname = response2.kakao_account.profile.nickname;
                        $.ajax({
                            url: 'kakaoLogin',
                            type: 'post',
                            data: {'email': email, 'nickname': nickname},
                            dataType: 'json',
                            success: function (response) {
                                console.log("로그인 성공")
                                if (response.signup === true) {
                                	swal({
                                        title: '회원가입 후 로그인이 완료되었습니다.',
                                           icon: 'success',
                                           buttons: {
                                               confirm: {
                                                   text: '확인',
                                                   value: true,
                                                   visible: true,
                                                   className: 'swal-custom' // 사용자 정의 클래스 추가
                                               }
                                           }
                                       }).then((result) => {
                                           if (result) {
                                               location.href = "home";
                                           }
                                       });
                                      return false;
                                  }
                                if (response.login === true) {
                                	swal({
                                        title: '로그인이 완료되었습니다.',
                                           icon: 'success',
                                           buttons: {
                                               confirm: {
                                                   text: '확인',
                                                   value: true,
                                                   visible: true,
                                                   className: 'swal-custom' // 사용자 정의 클래스 추가
                                               }
                                           }
                                       }).then((result) => {
                                           if (result) {
                                               location.href = "home";
                                           }
                                       });
                                      return false;
                                  }
                            },
                            error: function (request, status, error, response) {
                            	swal({
        							title: '서버 오류가 발생했습니다 \n 관리자에게 문의하세요',
        							icon: 'error',
        							buttons: {
        								confirm: {
        									text: '확인',
        									value: true,
        									visible: true,
        									className: 'swal-custom' // 사용자 정의 클래스 추가
        								}
        							}
        						})
                            }
                        })
                    },
                    fail: function (error) {
                    	swal({
							title: '서버 오류가 발생했습니다 \n 관리자에게 문의하세요',
							icon: 'error',
							buttons: {
								confirm: {
									text: '확인',
									value: true,
									visible: true,
									className: 'swal-custom' // 사용자 정의 클래스 추가
								}
							}
						})
                    },
                })
            },
            fail: function (error) {
            	swal({
					title: '서버 오류가 발생했습니다 \n 관리자에게 문의하세요',
					icon: 'error',
					buttons: {
						confirm: {
							text: '확인',
							value: true,
							visible: true,
							className: 'swal-custom' // 사용자 정의 클래스 추가
						}
					}
				})
            },
        })
    }
</script>

