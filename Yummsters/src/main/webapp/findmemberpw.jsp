<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    $(document).ready(function() {
        // 아이디 찾기 버튼 클릭 이벤트
        $('#findPw').click(function() {
            var name = $('#name').val();
            var nickname = $('#nickname').val();
            var email = $('#email').val();
            var member_id = $('#member_id').val();

            // 입력값이 비어있는지 확인
            if (name === "" || nickname === "" || email === "" || member_id === "") {
                alert("모든 정보를 입력해주세요.");
                return;
            }

            // 서버로 요청을 보내 아이디를 찾음
            $.ajax({
                type: 'POST',
                url: 'findmemberpw', // 실제 서블릿 URL로 변경해야 함
                data: {
                    member_name: name,
                    nickname: nickname,
                    email: email,
                    member_id: member_id
                },
                success: function(response) {
                    // 서버에서 받은 응답을 처리
                   
                    $('#PwInfo').text(response);
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
    <div id="name1" style="display: inline">
        <b>이름</b>
    </div>
    <input id="name" type="text" name="name" required placeholder="이름을 입력하세요."><br>

    <div id="nickname1" style="display: inline">
        <b>닉네임</b>
    </div>
    <input id="nickname" type="text" name="nickname" required placeholder="닉네임을 입력하세요."><br>

    <div id="email1" style="display: inline">
        <b>이메일</b>
    </div>
    <input id="email" type="text" name="email" required placeholder="이메일을 입력하세요."><br>
    
     <div id="member_id1" style="display: inline">
        <b>아이디</b>
    </div>
    <input id="member_id" type="text" name="member_id" required placeholder="아이디를 입력하세요.">
    <p>회원님의 비밀번호는:</p><p id="PwInfo"></p>

    <button class="findPw" id="findPw" type="button" style="display: inline">비밀번호찾기</button>
</body>
</html>
