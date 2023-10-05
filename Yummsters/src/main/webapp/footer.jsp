<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        * {
            /* margin:0 auto; */
            font-family: 'NanumSquareRound', sans-serif;
        }
        a {
            text-decoration: none;
        } 

        body {
            margin: 0 auto;
/*             background-color: #EEC595; */
            width: 1000px;
            height: 300px;
        }

        .footer {
           background-color: #EEC595;
            position: relative;
            display: flex;
            align-items: center;
        }

        .foot_logo {
            display: inline;
            align-items: center;
        }

        .foot_logo a span {
            color: rgba(255, 45, 0, 1);
            font-weight: 900;
            -webkit-text-stroke: 1.5px #FFE4C3;
            font-size: 3em;
            text-align: center;
            align-items: center;
            margin-right: 150px;
            position: absolute;
            transform: translate(-105%, 200%);
        }

        .foot_logo img {
            width: 200px;
            height: 200px;
            vertical-align: middle;
        }

        .sns {
            display: inline;
            flex-grow: 1;
            font-weight: 900;
            color: #524434;
            margin-left: 50px;
        }

        .sns a {
            font-weight: 900;
            color: #524434;
        }

        .sns img {
            width: 20px;
            height: 20px;
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="footer">
            <div class="foot_logo">
                <img src="imgView?file=foot_market.png" alt="My Image">
                <a href=""><span>편마카세</span></a>
            </div>
            <div class="sns">
                김희진&nbsp;&nbsp;&nbsp;
                <img src="imgView?file=github-icon.png" alt="My Image">
                <a href="">github Link</a> | 
                <img src="imgView?file=paperclip.png" alt="My Image">
                <a href="">velog Link</a> | 
                <img src="imgView?file=mail.png" alt="My Image">
                khj4209kk@gmail.com <br><br>
                서혜리&nbsp;&nbsp;&nbsp;
                <img src="imgView?file=github-icon.png" alt="My Image">
                <a href="">github Link</a> | 
                <img src="imgView?file=paperclip.png" alt="My Image">
                <a href="">velog Link</a> | 
                <img src="imgView?file=mail.png" alt="My Image">
                hye_dam_2@naver.com |
                <img src="imgView?file=instagram.png" alt="My Image">
                <a href="">hyedam_0214</a><br><br>
                조수빈&nbsp;&nbsp;&nbsp;
                <img src="imgView?file=github-icon.png" alt="My Image">
                <a href="">github Link</a> | 
                <img src="imgView?file=paperclip.png" alt="My Image">
                <a href="">velog Link</a> | 
                <img src="imgView?file=mail.png" alt="My Image">
                tnqls3807@naver.com &nbsp;&nbsp;|
                <img src="imgView?file=instagram.png" alt="My Image">
                <a href="">soobin_432</a><br><br>
                허선진&nbsp;&nbsp;&nbsp;
                <img src="imgView?file=github-icon.png" alt="My Image">
                <a href="">github Link</a> | 
                <img src="imgView?file=paperclip.png" alt="My Image">
                <a href="">velog Link</a> | 
                <img src="imgView?file=mail.png" alt="My Image">
                seonjin.dev@gmail.com
            </div>
        </div>
    </div>
</body>
</html>