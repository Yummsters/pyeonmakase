<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">
<script>
$(document).ready(function() {
    // 회원정보 수정 버튼 이벤트 핸들러
    $('#userRegister').click(function() {
        location.href = "user_modify.jsp";
    });
               
    // 회원탈퇴 버튼 이벤트 핸들러
    $('#userDelete').click(function() {
        var message = prompt("정말 탈퇴하시겠습니까? \n 탈퇴하시면 회원정보를 되돌릴 수 없습니다.", "비밀번호를 입력하세요.");
               
        if (message) {
          var memberNickname = "${sessionScope.member.nickname}";
          var memberPw = "${sessionScope.member.member_pw}";
                         
          if(memberPw == message) {
                $.ajax({
                    url: 'memberdelete',
                    type: 'POST',
                    data: {
                        nickname: memberNickname,
                        password: memberPw
                    },
                    success: function(response) {
                           alert("회원 탈퇴가 완료되었습니다.");
                           location.href = "home"; // 탈퇴 후 리다이렉트할 페이지
                    },
                    error: function() {
                       alert("서버 오류가 발생했습니다.");
                    }
                });
             
          } else {
                 alert("비밀번호가 일치하지 않습니다.");
                 console.log("password: " + password)
          }
       };
   });
    $('#socialDelete').click(function() {
        var message = confirm("정말 탈퇴하시겠습니까? \n 탈퇴하시면 회원정보를 되돌릴 수 없습니다.");
	    $.ajax({
	        url: "naverDelete",
	        type: "POST",
	        success: function (response) {
	            alert("탈퇴통신성공");
                $.ajax({
                    url: 'memberdelete',
                    type: 'POST',
                    data: {
                        nickname: "${sessionScope.member.nickname}",
                        password: "${sessionScope.member.member_pw}"
                    },
                    success: function(response) {
                           alert("회원 탈퇴가 완료되었습니다.");
                    },
                    error: function() {
                       alert("서버 오류가 발생했습니다.");
                    }
                });
	            location.href = "home";
	        },
	        error: function (res) {
	            alert("탈퇴통신실패");
	        }
	    });
    });
});
</script>

</head>
<body>
	<jsp:include page="header.jsp" />
	<!-- 박스-->
	<br>
	<div class="box" style="border: 3px solid #EEC595">
		<!-- 원-->
		<div class="c1" style="display: inline"></div>
		<div class="c2"></div>
		<div class="c3"></div>
		<div class="c4"></div>

		<!-- 회원정보-->
		<img class="img" src="imgView?file=로고.png" alt="">
		<div class="user-title">
			<b>회원정보</b>
		</div>

		<div class="name1" style="display: inline">
			<b>이름</b>
		</div>
		<div class="name2">${member.member_name }</div>
		<div class="nickname1" style="display: inline">
			<b>닉네임</b>
		</div>
		<div class="nickname2">${member.nickname }</div>
		<div class="email1" style="display: inline">
			<b>이메일</b>
		</div>
		<div class="email2">${member.email }</div>

      <!-- 버튼-->
      <p><button id="userRegister">회원정보 수정</button></p>

      <p><button id="userDelete">회원탈퇴</button></p>
      
      <p><button id="socialDelete">소셜로그인 회원탈퇴</button></p>

	</div>
	<br>

	<jsp:include page="footer.jsp" />
</body>
