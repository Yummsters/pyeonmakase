<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">

<body>
<div class="body_container">
<jsp:include page="header.jsp" />
    <div class="join-box">
        <div class="mem-title">회원가입</div>

        <form class="join-form" method="post" action="signup">
            <div class="input-with-button">
	            <input type="text" id="name" name="name" required placeholder="이름을 입력하세요">
            	<p id="nameInfo"></p>
            </div>

            <div class="input-with-button">
                <input type="text" id="nickname" name="nickname" required placeholder="닉네임을 입력하세요">
            	<span id="nicknameErr"></span>
                <button type="button" class="checkDuplicate" data-type="nickname">중복확인</button>
	            <p id="nicknameInfo"></p>
            </div>

            <div class="input-with-button">
                <input type="email" id="email" name="email" required placeholder="이메일을 입력하세요">
            	<span id="emailErr"></span>
                <button type="button" class="checkDuplicate" data-type="email">중복확인</button>
                <p id="emailInfo"></p>
            </div>

            <div class="input-with-button">
	            <input type="text" id="id" name="id" required placeholder="아이디를 입력하세요">
	            <span id="idErr"></span>
	            <button type="button" class="checkDuplicate" data-type="id">중복확인</button>
	            <p id="idInfo"></p>
            </div>
            
            <div class="input-with-button">
            	<input type="password" id="password" name="password" required placeholder="비밀번호를 입력하세요">
           		<p id="pwInfo"></p>
           	</div>

            <div class="input-with-button">
            	<input type="password" id="checkPassword" name="checkPassword" required placeholder="비밀번호를 다시 입력하세요"> 
            	<span id="pwErr"></span>
            </div>  

            <div id="signupErr"></div>
            <input type="submit" name="signup" value="가입하기">
        </form>
    </div>
    </div>

<jsp:include page="footer.jsp" />
</body>

<script>
$(function() {
    // 중복체크 여부
    let nicknameCheck = false;
    let emailCheck = false;
    let idCheck = false;
    // 비밀번호 일치 여부
    let pwCheck = false;
    // 유효성 충족 여부
    let validName = false;
    let validNickname = false;
    let validEmail = false;
    let validId = false;
    let validPw = false;
    
    // 중복체크 동일 코드 함수화
    function updateCase(dataType, msg, color) {
        if (dataType === "nickname" && validNickname) {
            nicknameCheck = true;
        } else if (dataType === "email" && validEmail) {
            emailCheck = true;
        } else if (dataType === "id" && validId) {
            idCheck = true;
        }
        var errMsg = "#" + dataType + "Err";
        $(errMsg).text(msg).css("color", color);
	}
    
    // 중복체크 여부 ajax
    $(".checkDuplicate").click(function() {
        var dataType = $(this).data("type");
        var inputValue = $("#" + dataType).val();
        
        // input에 값이 입력되지 않았을 때
        if (!inputValue) {
            $("#" + dataType + "Err").text(""); return;
        }
        
        $.ajax({
            url: "duplicateCheck", // 서블릿 주소
            type: "post", // method 타입
            data: { // 서버로 보낼 데이터
                type: dataType, // type이라는 이름으로 dataType 값을, 
                value: inputValue // value라는 이름으로 inputValue 값을 지정
            },
            dataType: 'json', // JSON 형식의 응답을 받기 위해 dataType을 설정
            success: function(res) {
                var infoType = (dataType === "nickname" ? "닉네임" : dataType === "email" ? "이메일" : "아이디");
                if (res[dataType] == "notexist") { // 사용 가능한 경우
                    if ((dataType === "nickname" && validNickname) || (dataType === "email" && validEmail) || (dataType === "id" && validId)) {
                    	updateCase(dataType, "사용가능한 " + infoType + "입니다", "green");
                    } else {
                    	updateCase(dataType, infoType + " 형식을 확인해 주세요", "red");
                    }
                } else { // 중복되는 경우
                	updateCase(dataType, "중복된 " + infoType + "입니다", "red");
                }
            },
            error: function(err) {
                alert("에러발생");
            }
        })
    })
    
    // 비밀번호 일치 여부
    $("#checkPassword").on("input", function() {
        let pw = $("#password").val();
        let checkPw = $("#checkPassword").val();    
        if (!validPw) {
            $("#pwErr").text("비밀번호 형식을 확인해 주세요").css("color", "red");
        } else {
	        if (pw === checkPw) {
	            $("#pwErr").text("비밀번호가 일치합니다").css("color", "green");
	            pwCheck = true;
	        } else {
	            $("#pwErr").text("비밀번호가 불일치합니다").css("color", "red");
	            pwCheck = false;
	        }
        }     
    })
    
    // 입력값이 변할 때 안내문구 사라짐
    $("#nickname").on("input", function() {
        if ($("#nickname").val()) {
            nicknameCheck = false;
            $("#nicknameErr").text("");
        }
    });
    
    $("#email").on("input", function() {
        if ($("#email").val()) {
            emailCheck = false;
            $("#emailErr").text("");
        }
    });
    
    $("#id").on("input", function() {
        if ($("#id").val()) {
            idCheck = false;
            $("#idErr").text("");
        }
    });
    
    $("#password").on("input", function() {
        if ($("#password").val()) {
            pwCheck = false;
            $("#pwErr").text("비밀번호가 불일치합니다").css("color", "red");
        }
    });
    
    // 폼 제출 전 안내 초기화
    $(".join-form").on("input", function() {
        $("#signupErr").text("");
    });
    
    // 중복확인 및 비밀번호 유효성 확인 여부에 따른 form 제출 핸들러
    // 체크여부가 하나라도 false인 경우 폼 제출 방지
    $(".join-form").submit(function(e) {
        if (!nicknameCheck || !emailCheck || !idCheck || !pwCheck || !validName || !validPw) {
            e.preventDefault();
            $("#signupErr").text("입력 형식 또는 중복확인 여부를 확인해 주세요").css("color", "red");
        }
    });
    
    // 유효성 검사 관련
    // 이름 유효성 검사 (2글자 이상 한글)
    $("#name").on("blur", function() {
        const name = $(this).val();
        if (!/^[A-Za-z가-힣]{2,}$/.test(name) && name!=null) {
            $("#nameInfo").text("⚠️ 2자 이상의 한글만 입력 가능합니다");
            validName = false;
            console.log("이름유효성"+validName);
        } else {
            $("#nameInfo").text("");
            validName = true; // 조건 통과한 경우에만 중복확인이 가능하게 하기 위해 사용
            console.log("이름유효성"+validName)
        }
    });
    
    // 닉네임 유효성 검사 (2글자 이상 영문 소문자, 한글, 숫자)
    $("#nickname").on("blur", function() {
        const nickname = $(this).val();
        if (!/^[A-Za-z가-힣0-9]{2,5}$/.test(nickname) && nickname!=null) {
            $("#nicknameInfo").text("⚠️ 2~8자의 영소문자, 한글, 숫자만 입력 가능합니다");
            validNickname = false;
            console.log("닉네임유효성"+validNickname);
        } else {
            $("#nicknameInfo").text("");
            validNickname = true; 
            console.log("닉네임유효성"+validNickname)
        }
    });
    
    // 이메일 유효성 검사 (@를 포함하는 이메일 형식)
    $("#email").on("blur", function() {
        const email = $(this).val();
        if (!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email) && email!=null) {
            $("#emailInfo").text("⚠️ '@과 .'을 포함하는 이메일 형식만 입력 가능합니다");
            validEmail = false;
            console.log("이메일유효성"+validEmail);
        } else {
            $("#emailInfo").text("");
            validEmail = true;
            console.log("이메일유효성"+validEmail);
        }
    });
    
    // 아이디 유효성 검사 (5~10자 영문 소문자와 숫자)
    $("#id").on("blur", function() {
        const id = $(this).val();
        if (!/^[a-z0-9]{5,12}$/.test(id) && id!=null) {
            // 유효하지 않은 아이디 형식
            $("#idInfo").text("⚠️ 5~12자의 영소문자, 숫자만 입력 가능합니다");
            validId = false;
            console.log("아이디유효성"+validEmail);
        } else {
            $("#idInfo").text("");
            validId = true;
            console.log("아이디유효성"+validEmail)
        }
    });
    
    // 비밀번호 유효성 검사 (8~16자 영문 소문자, 숫자, 특수문자)
    $("#password").on("blur", function() {
        const password = $(this).val();
        if (!/^[a-zA-Z0-9!@#$%^&*()_+{}[\]:;<>,.?~\\-]{8,16}$/.test(password) && password!=null) {
            $("#pwInfo").text("⚠️ 8~16자의 영문 소문자, 숫자, 특수문자만 입력 가능합니다");
            validPw = false;
            console.log("비밀번호유효성"+validEmail);
        } else {
            $("#pwInfo").text("");
            validPw = true;
            console.log("비밀번호유효성"+validEmail)
        }
    });
});

</script>