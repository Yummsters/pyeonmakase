<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>편마카세</title>
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
        /*버튼*/
        #user_btn1{
            position: absolute;
            left:15%;
            bottom: 10%;
            border: none;
            width: 250px;
            height: 30px;
            font-size: 20px;
            
            -webkit-text-stroke: 0.07px white;
            color: #524434;
            background-color: #EEC595;
            border-radius: 30px;
         }
         #user_btn2{
            position: absolute;
            right:15%;
            bottom: 10%;
            border: none;
            width: 250px;
            height: 30px;
            font-size: 20px;
            
            -webkit-text-stroke: 0.07px white;
            color: #524434;
            background-color: #EEC595;
            border-radius: 30px;
         }


    </style>
</head>
<body>
<jsp:include page="header.jsp" />
     <!-- 박스-->
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
    <div class="name2">오지윤</div>
    <div class="nickname1" style="display:inline"><b>닉네임</b></div>
    <div class="nickname2">떠뽀끼킬러</div>
    <div class="email1" style="display:inline"><b>이메일</b></div>
    <div class="email2">yoon345@gmail.com</div>

    <!-- 버튼-->
    <p><a href="usermodify"><input id = "user_btn1" type="submit" value="회원정보 수정"></a></p>
    <p><input id = "user_btn2" type="submit" value="회원 탈퇴"></p>


    </div>


<jsp:include page="footer.jsp" />
</body>
</html>