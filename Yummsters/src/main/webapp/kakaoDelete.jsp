<%--
  Created by IntelliJ IDEA.
  User: gmlwls
  Date: 2023/10/16
  Time: 9:00 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script>
        // 탈퇴 시 디비에서 정보 삭제하는 로직 추가 필요
        Kakao.init('${kakao.javascript.key}');

        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("kakaoDeleteLink").addEventListener("click", function (event) {
                event.preventDefault(); // 기본 링크 동작 방지

                var nickname = this.getAttribute('data-member-id');
                console.log(nickname);

                Kakao.API.request({
                    url: '/v1/user/unlink'
                }).then(function (response) {
                    console.log(response);
                    alert("회원 탈퇴가 완료되었습니다.")
                    var param = "kakaoDelete?nickname=" + nickname;
                    location.href = param;
                }).catch(function (error) {
                    console.log(error);
                });
            });
        });
    </script>
</head>
<body>
<a href="#" id="kakaoDeleteLink" data-member-id="${member.nickname}">
    <img src="imgView?file=kakao_login.png" style="width: 200px">
</a>
</body>
</html>
