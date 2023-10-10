<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
    <style>
        /*박스*/
        .box{
            border-radius: 30px;
            margin:0 auto;
            width: 800px;
            height: 800px;
           
            background-color: #FFF8E2;

            position: relative;
        }
        /*동그라미*/
        .c1{
            float:left;
            margin : 10px;
            background-color: #EEC595;
            width : 30px;
            height: 30px;

            border-radius: 30px;
        }
        .c2{
           float:right;
            margin : 10px;
            background-color: #EEC595;
            width : 30px;
            height: 30px;
            border-radius: 30px;
        }
        .c3{   
            float:left;
            margin : 10px;
            background-color: #EEC595;
            width : 30px;
            height: 30px;
            border-radius: 30px;
            position: absolute;
            bottom: 0;
        }
        .c4{ 
            position: absolute;
            bottom: 0;
            right: 0;
            
            margin : 10px;
            background-color: #EEC595;
            width : 30px;
            height: 30px;
            border-radius: 30px;
        }
        /*회원정보*/
        .title {
            position: absolute;
            top :10%;
            left : 35%;
            font-size: 70px;
            line-height: 0px;
            -webkit-text-stroke: 4px #524434;
            color: white;
        }
        .img{
            position: absolute;
            top :1%;
            left : 17%;
            width:150px;
            height: 120px;
        }

        .name1{
           position: absolute;
           color: #524434;
           font-size: 25px;
           top : 35%;
           left : 12%;
        }
        .name2{
            position: absolute;
           color: #524434;
           font-size: 25px;
           top : 35%;
           left : 20%;

        }
        .nickname1{
            position: absolute;
           color: #524434;
           font-size: 25px;
           top : 45%;
           left : 10%;
        }
        .nickname2{
            position: absolute;
           color: #524434;
           font-size: 25px;
           width: 500px;
           top : 45%;
           left : 20%;

        }
        .email1{
            position: absolute;
           color: #524434;
           font-size: 25px;
           top : 55%;
           left : 10%;
        }
        .email2{
            position: absolute;
           color: #524434;
           font-size: 25px;
           width: 500px;
           top : 55%;
           left : 20%;

        }
        .pw1{
            text-align: center;
            position: absolute;
           color: #524434;
           font-size: 25px;
           top : 65%;
           left : 7%;
           

        }
        .pw2{
            position: absolute;
           color: #524434;
           font-size: 25px;
           top : 65%;
           left : 20%;
           width: 590px;

        }
        /*버튼*/
        #confirm1{
            font-family: NanumSquareRound;
            position: absolute;
            top:360px;
            right :5%;
            border: none;
            padding: 5px 20px;
            border-radius: 10px;
            font-size: 20px;
           
            color: #524434;
            box-shadow: 0 10px 320px rgba(0, 0, 0, 0.2);
            background-color: #EEC595;

        }
        #confirm2{
            font-family: NanumSquareRound;
            position: absolute;
            top: 440px;
            right :5%;
            border: none;
            padding: 5px 20px;
            border-radius: 10px;
            font-size: 20px;
         
            color: #524434;
            box-shadow: 0 10px 320px rgba(0, 0, 0, 0.2);
            background-color: #EEC595;
        }
        #user_btn1{
            position: absolute;
            left:35%;
            bottom: 10%;
            border: none;
            width: 250px;
            height: 30px;
            font-size: 20px;
            color: #524434;
            background-color: #EEC595;
            border-radius: 30px;
         }
         
    </style>
</head>
<body>
     <!-- header  -->
     <jsp:include page="header.jsp" />
    </div>
     <!-- 박스-->
     <br>
    <div class="box" style="border:3px solid#EEC595"> 
    <!-- 원-->
    <div class="c1" style="display:inline" ></div>
    <div class="c2" ></div>
    <div class="c3" ></div>
    <div class="c4"></div>
 
    <!-- 회원정보-->
    <img class="img" src="imgView?file=로고.png" alt="">
    <div class="title"><b>회원정보</b></div>

    <div class="name1" style="display:inline"><b>이름</b></div>
    <div class="name2">${member.member_name }</div>


    <div class="nickname1"  style="display:inline"><b>닉네임</b></div>
    <input class="nickname2" type="text" value="${member.nickname}" name="nickname">
    <p><input id = "confirm1" type="submit" value="확인"></p>


    <div class="email1" style="display:inline"><b>이메일</b></div>
    <input class="email2" type="text" value="${member.email }" name="email">
    <p><input id = "confirm2" type="submit" value="확인"></p>


    <div class="pw1" style="display:inline"><b>비밀번호<br>수정</b></div>
    <input class="pw2" type="text" value="${member.member_pw }" name="pw">
    

    <!-- 버튼-->
    <p><a href="user_info.jsp"><input id = "user_btn1" type="submit" value="회원정보 저장"></a></p>
    


    </div><br>


    <jsp:include page="footer.jsp" />
</body>
<script>
	$ajax({
		url:"getUserInfo",
		type:"get",
		dataType:"json",
		success:function(user){
			$(".nickname").val(user.nickname);
			$(".email").val(user.email);
			$(".member_pw").val(user.member_pw);
		},
		erro: function(err) {
			console.log(err);
		}
	});
	
	
	
	//수정확인 누르면..
	$("#user_btn1").click(function() {
    var newNickname = $(".nickname2").val();
    $.ajax({
        url: "userModify", // 수정할 서블릿 주소
        type: "post", // POST 방식으로 요청
        data: {
            // 수정할 데이터를 전달
            originalNickname: "${member.nickname}", // 기존 닉네임
            updatedNickname: newNickname // 수정된 닉네임
            originalEmail: "${member.email}",
            updatedEmail: newEmail
            originalPassword:"${member.member_pw}",
            updatedPassword : newPassword
        },
        dataType: "json",
        success: function (result) {
            console.log(result);
        },
        error: function (err) {
            console.log(err);
        }
    });
});
</script>