<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>편마카세</title>
    <style>
        
         .line{
            width:100%;
            height:3px;
            background-color: #EEC595;

         }
        
         .card {
            width: 30%;
            margin: 10px;
            float: left;
            padding: 10px;
            box-sizing: border-box;
            background-color: white;
            border-radius: 10px;
        }
        .recommend {
            color:#00000080;
            font-size: 16px;
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
       
        /* 타이틀 영역 끝 */

    </style>
</head>
<body>
<jsp:include page="header.jsp" />
   
    <div class="title-box">
        <div class="title">찜한 레시피</div>
    </div>
    <div class="line"></div>
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

<jsp:include page="footer.jsp" />
</body>
</html>