<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>네이버 로그인</title>
</head>
<body>
<script type="text/javascript">
  var naver_id_login = new naver_id_login("${client_id}", "http://localhost:8090/naverLogin.jsp");
  // 접근 토큰 값 (naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  
  function naverSignInCallback() {
    let id = naver_id_login.getProfileData('id'); // 네이버 자체에서 고유값 줌
    let name = naver_id_login.getProfileData('name');
    let nickname = naver_id_login.getProfileData('nickname');
    let email = naver_id_login.getProfileData('email');
    let token = naver_id_login.oauthParams.access_token;

    $.ajax({
    	url: "naverlogin",
    	type: "POST",
    	data: {id:id, name:name, nickname:nickname, email:email, token:token},
    	success: function(res) {
    		if(res == "signupAndLoginSuccess") {
                swal({
                    title: '회원가입 후 로그인이 완료되었습니다',
                    icon: 'success',
                    buttons: {
                        confirm: {
                            text: '확인',
                            value: true,
                            visible: true,
                            className: 'swal-custom' // 사용자 정의 클래스 추가
                        }
                    }
                })
    		} else if (res = "loginSuccess") {
                swal({
                    title: '로그인 완료되었습니다',
                    icon: 'success',
                    buttons: {
                        confirm: {
                            text: '확인',
                            value: true,
                            visible: true,
                            className: 'swal-custom' // 사용자 정의 클래스 추가
                        }
                    }
                })
    		} else {
                swal({
                    title: '회원가입 또는 로그인에 실패했습니다',
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
   			window.opener.location.href = "home";
	        window.close();
    	},
    	error: function() {
    		aswal({
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
    });
  }
</script>
</body>
</html>