<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">
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
			<b>회원정보수정</b>
		</div>
		
      <div class="name1" style="display: inline">
         <b>이름</b>
      </div>
      <div class="userline1"></div>
      <div class="name2">${member.member_name }</div>
      
      <form class="userForm" action="usermodify" method="post">

      <div class="input-with-btn">
         <div class="nickname1" style="display: inline">
            <b>닉네임</b>
         </div>
         <div class="userline2"></div>
         <div class="nickname2" name="nickname">${member.nickname}</div>
      </div>

      <div class="input-with-btn">
         <div class="email1" style="display: inline">
            <b>이메일</b>
         </div>
         <div class="userline3"></div>
         <input class="email2" type="text" name="email"
            value="${member.email }"> <span id="emailErr" class="emailErr"></span>
         <button class="checkDuplicate" id="confirm2" type="button"
            data-type="email" disabled="disabled">중복확인</button>
         <p id="emailInfo" class="emailInfo"></p>
      </div>
      <div class="pw" style="display: inline">
            <b>현재 비밀번호</b>
         </div>
         <div class="userline4"></div>
         <input id="password1" type="password" name="password" required="required"  placeholder="현재 비밀번호를 입력하세요">
      
      <div class="input-with-btn">
         <div class="pw1" style="display: inline">
            <b>변경할 비밀번호</b>
         </div>
         <div class="userline5"></div>
         <input name="newPassword" type="password" id="newPassword" placeholder="변경할 비밀번호를 입력하세요">
         <p id="pwInfo" class="pwInfo"></p>
      </div>
      <div class="input-with-btn">
         <input id="check_password" type="password"
            placeholder="변경할 비밀번호를 다시 입력하세요">
         <p id="pwErr" class="pwErr"></p>
      </div>
      <div class="userline6"></div>

		<!-- 버튼-->
		
			<p>
		        <div id="signupErr" class="signupErr"></div>
				<a href="user_info.jsp"><input id="user_btn1" type="submit"
					value="회원정보 저장"></a>
			</p>
		</form>
	</div>
	<br>


	<jsp:include page="footer.jsp" />
</body>
<script>
$(function() {
	// 중복체크 여부
	let nicknameCheck = true;
	let emailCheck = true;
	// 비밀번호 일치 여부
	let pwCheck = true;
	// 유효성 충족 여부
	let validNickname = true;
	let validEmail = true;
	let validPw = true;		

	// 닉네임을 변경하는 경우 중복확인 버튼 활성화 후 중복확인 및 유효성 검사 실시
	$(".nickname2").on("input", function() {
	    nicknameCheck = false;
	    $("#confirm1").prop("disabled", false);
	    $(".nickname2").on("blur", function() { // 닉네임 유효성 검사
	        const nickname = $(this).val();
	        if (!/^[A-Za-z가-힣0-9]{2,5}$/.test(nickname) && nickname != null) {
	            $("#nicknameInfo").text("⚠️ 2~8자의 영소문자, 한글, 숫자만 입력 가능합니다");
	            validNickname = false;
	            console.log("닉네임 유효성: " + validNickname);
	        } else {
	            $("#nicknameInfo").text("");
	            validNickname = true;
	            console.log("닉네임 유효성: " + validNickname);
	        }
	    });
	});
	
	$(".email2").on("input", function() {
		emailCheck = false;
		$("#confirm2").prop("disabled", false);
		$(".email2").on("blur",function() { // 이메일 유효성 검사 (@를 포함하는 이메일 형식)
			const email = $(this).val();
			if (!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email)&& email != null) {
				$("#emailInfo").text("⚠️ '@과 .'을 포함하는 이메일 형식만 입력 가능합니다");
				validEmail = false;
				console.log("이메일유효성" + validEmail);
			} else {
				$("#emailInfo").text("");
				validEmail = true;
				console.log("이메일유효성" + validEmail);
			}
		});
	});
	
	// 새 비밀번호 유효성 검사 및 일치 여부
	$("#newPassword, #check_password").on("input", function() {
	    const newPassword = $("#newPassword").val();
	    const check_password = $("#check_password").val();

	    if (!/^[a-zA-Z0-9!@#$%^&*()_+{}[\]:;<>,.?~\\-]{8,16}$/.test(newPassword) && newPassword != null) {
	        $("#pwInfo").text("⚠️ 8~16자의 영문 소문자, 숫자, 특수문자만 입력 가능합니다");
	        validPw = false;
	    } else {
	        $("#pwInfo").text("");
	        validPw = true;
	    }

	    if (newPassword === check_password) {
	        $("#pwErr").text("비밀번호가 일치합니다").css("color", "green");
	        pwCheck = true;
	    } else {
	        $("#pwErr").text("비밀번호가 불일치합니다").css("color", "red");
	        pwCheck = false;
	    }
	});
	
	// 중복체크 결과 업데이트 함수
	function updateCheckResult(dataType, msg, color, validCheck) {
		if (validCheck) {
			if ((dataType === "nickname" && validNickname) || (dataType === "email" && validEmail)) {
				$("#" + dataType + "Err").text(msg).css("color", color);
			} else {
				$("#" + dataType + "Err").text("형식을 확인해 주세요").css("color","red");
			}
		} else {
			$("#" + dataType + "Err").text(msg).css("color", color);
		}
	}

	// 중복체크 여부 ajax
	$(".checkDuplicate").click(function() {
		console.log("클릭됨");
		var dataType = $(this).data("type");
		var inputValue = $("." + dataType + "2").val();

		// input에 값이 입력되지 않았을 때
		if (!inputValue) {
			$("#" + dataType + "Err").text("");
			return;
		}
		$.ajax({
			url : "duplicateCheck",  // 서블릿 주소
			type : "post", // method 타입
			data : { // 서버로 보낼 데이터
				type : dataType, // type이라는 이름으로 dataType 값을, 
				value : inputValue
			// value라는 이름으로 inputValue 값을 지정
			},
			dataType : "json", // JSON 형식의 응답을 받기 위해 dataType을 설정
			success : function(res) {
				 var infoType = (dataType === "nickname" ? "닉네임" : "이메일");
                if (res[dataType] == "notexist") {
                    updateCheckResult(dataType, "사용가능한 " + infoType + "입니다", "green", true);
                    // 중복확인 성공 시 해당 변수를 true로 설정
                    if (dataType === "nickname") {
                        nicknameCheck = true;
                    } else if (dataType === "email") {
                        emailCheck = true;
                    }
                } else {
                    updateCheckResult(dataType, "중복된 " + infoType + "입니다", "red", false);
                    // 중복확인 실패 시 해당 변수를 false로 설정
                    if (dataType === "nickname") {
                        nicknameCheck = false;
                    } else if (dataType === "email") {
                        emailCheck = false;
                    }
                }
            },
            error: function(err) {
                console.log(err);
            }
        });
    });
	
	 // 폼 제출 버튼 클릭 이벤트 핸들러
    $("#user_btn1").click(function(e) {
    	if("${sessionScope.member.member_pw}" == $('#password1').val()) {
    	    if ($("#password1").val() && !$("#newPassword").val()) {
    	        $("#newPassword").val($("#password1").val()); // 새 비밀번호 입력하지 않은 경우 현재 비밀번호 값 복사.
    	        console.log($("#password1").val());
    	    }
	        // 중복확인 여부 및 기타 유효성 검사를 확인하여 폼 제출 여부 결정
	        if (nicknameCheck && emailCheck && pwCheck && validPw) { // 유효할 경우 폼을 제출
	            $(".userForm").submit();
	        } else { // 유효하지 않을 경우 에러 메시지 표시 등 추가 로직 수행

	            $("#signupErr").text("입력 형식 또는 중복확인 여부를 확인해 주세요").css("color", "red");
                e.preventDefault();
                return false;
	        }
    	} else {
    		$("#signupErr").text("비밀번호가 틀렸습니다").css("color", "red");
            e.preventDefault();
            return false;
    	}
    });
	 
    // 폼 제출 안내 초기화
    $("#user_btn1").on("input", function() {
        $("#signupErr").text("");
    });
});
</script>