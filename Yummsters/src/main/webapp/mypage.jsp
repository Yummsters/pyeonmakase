<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>편마카세</title>
    <style>

         /*회원정보 버튼 */
         #user_btn{
            border: none;
            width: 200px;
            height: 30px;
            font-size: 20px;
            
            color : white;
            background-color: #EEC595;
            border-radius: 30px;
         }
         .line{
            width:100%;
            height:3px;
            background-color: #EEC595;

         }
        .card-box {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            margin: 0 auto;
            max-width: 1000px;
        }
        
        .card {
            margin: 10px;
            padding: 10px;
            box-sizing: border-box;
            background-color: white;
            border-radius: 10px;
            width: calc(33.33% - 20px);
            margin-bottom: 20px;
        }
        .recommend {
            color:#00000080;
            font-size: 20px;
        }
        .thumbnail {
            position: relative;
        }
        .thumbnail img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 5px auto 30px auto;
            /* width: 90%; */
        }
        .store-name {
            position: absolute;
            bottom: 0;
            right: 0;
            background-color: rgba(0, 0, 0, 0.7);
            color: #fff;
            padding: 5px;
            font-size: 16px;
        }
        .recipe-name {
            text-align: center;
            font-size: 20px;
        }

          /* 타이틀 영역 */
          .title-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 30px 10px 0 0;
            color: #524434;
            clear: left; /*display: flex 사용하는게 나으려나..*/
        }
        .title {
            color: #524434;
            font-weight: 800;
            font-size: 1.5rem;
            margin: 30px 0 10px 10px;
        }
        .more {
            cursor: pointer; /*더보기 onclick 설정하기*/
            margin: 30px 10px 10px 10px;
        }
        /* 타이틀 영역 끝 */
        
        a {
           text-decoration: none;
           color: black;
        }

    </style>
</head>
<body>
<jsp:include page="header.jsp" />

    <div class="title-box">   
        <div class="title">${member.nickname } 셰프님 마이페이지</div>  
        <p><a href="userinfo"><input id = "user_btn" type="submit" value="회원정보"></a></p>
    </div>

    <div class="line"></div>

    <!-- mylist  -->
    <div class="title-box">
        <div class="title">내가 작성한 레시피</div>
        <div class="more"><a href="mylist">더보기</a></div>
    </div>
    <div class="line"></div>
     <div class="card-box">
    <div class="card" onclick="location.href={bno}">
        <div class="recommend">♥ 123</div>
        <div class="thumbnail">
            <img src="imgView?file=mirro.jpg" alt="">
            <div class="store-name">{편의점 명}</div>
        </div>
        <div class="recipe-name">{레시피명}</div>
    </div>
    <div class="card" onclick="location.href={bno}">
        <div class="recommend">♥ 123</div>
        <div class="thumbnail">
            <img src="imgView?file=mirro.jpg" alt="">
            <div class="store-name">{편의점 명}</div>
        </div>
        <div class="recipe-name">{레시피명}</div>
    </div>
    <div class="card" onclick="location.href={bno}">
        <div class="recommend">♥ 123</div>
        <div class="thumbnail">
            <img src="imgView?file=mirro.jpg" alt="">
            <div class="store-name">{편의점 명}</div>
        </div>
        <div class="recipe-name">{레시피명}</div>
    </div>
    </div>


    <!-- wishlist  -->
    <div class="title-box">
        <div class="title">찜한 레시피</div>
        <div class="more"><a href="wishlist">더보기</a></div>
    </div>

    <div class="line"></div>
     <div class="card-box">
    <div class="card" onclick="location.href={bno}">
        <div class="recommend">♥ 123</div>
        <div class="thumbnail">
            <img src="imgView?file=mirro.jpg" alt="">
            <div class="store-name">{편의점 명}</div>
        </div>
        <div class="recipe-name">{레시피명}</div>
    </div>
    <div class="card" onclick="location.href={bno}">
        <div class="recommend">♥ 123</div>
        <div class="thumbnail">
            <img src="imgView?file=mirro.jpg" alt="">
            <div class="store-name">{편의점 명}</div>
        </div>
        <div class="recipe-name">{레시피명}</div>
    </div>
    <div class="card" onclick="location.href={bno}">
        <div class="recommend">♥ 123</div>
        <div class="thumbnail">
            <img src="imgView?file=mirro.jpg" alt="">
            <div class="store-name">{편의점 명}</div>
        </div>
        <div class="recipe-name">{레시피명}</div>
    </div>
    </div>

<jsp:include page="footer.jsp" />
</body>
</html>