<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>

        /* 제목 영역 설정*/
        .content_title {
            background-color: bisque;
            width: 1000px;
            height: 70px;
            display: table-cell;
            vertical-align: middle;
            border-top: 2px solid #EEC595;
            border-right: 2px solid #EEC595;
            border-left: 2px solid #EEC595;
        }

        .title {
            font-size: 1.5rem;
            font-weight: 800;
            float: left;
            display: flex;
            align-items: center;
        }

        .title_store {
            margin-left: 10px;
        }

        .recommand_date {
            display: flex;
            text-align: right;
            float: right;
        }

        /* 내용 영역 설정*/
        .picture {
            margin-top: 10px;
            text-align: center;
        }

        .content_detail {
            border: 2px solid #EEC595;
        }

        .picture_text {
            display: flex;
            align-items: center;
        }

        /* 수정/삭제 버튼 관련 스타일 적용 */
        .mod_del {
            position: relative;
            border: none;
            padding: 5px 20px;
            border-radius: 10px;
            font-family: "paybooc-Light", sans-serif;
            box-shadow: 0 10px 320px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            font-weight: 400;
            transition: 0.25s;
            float: right;
            background-color: #EEC595;
            margin-right: 5px;
        }

        /* 좋아요 찜 버튼 스타일 적용 */
        @font-face {
            font-family: 'Material Icons';
            font-style: normal;
            font-weight: 400;
            src: url(https://example.com/MaterialIcons-Regular.eot); /* For IE6-8 */
            src: local('Material Icons'),
            local('MaterialIcons-Regular'),
            url(https://example.com/MaterialIcons-Regular.woff2) format('woff2'),
            url(https://example.com/MaterialIcons-Regular.woff) format('woff'),
            url(https://example.com/MaterialIcons-Regular.ttf) format('truetype');
        }

        .heart_btn {
            background: #FBF9F3;
            outline: none;
            border: none;
        }

        .star_btn {
            background: #FBF9F3;
            color: black;
            outline: none;
            border: none;
        }

        /* 댓글 관련 스타일 적용 */
        .all_reply {
            width: 1000px;
            height: 500px;
            border: 2px solid #EEC595;

        }

        .reply_register {
            width: 800px;
            height: 100px;
            border: 2px solid #EEC595;
            margin: 40px 0px 0px 100px;

        }

        .reply {
            position: relative;
        }

        .reply_bnt {
            position: absolute;
            right: 10px;
            top: 80px;
            border: none;
            padding: 5px 20px;
            border-radius: 10px;
            font-family: "paybooc-Light", sans-serif;
            box-shadow: 0 10px 320px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            font-weight: 400;
            transition: 0.25s;
            background-color: #EEC595;
            margin-right: 5px;
        }

        .reply_content {
            position: relative;
        }

        .reply_one {
            padding: 10px;
            border: 2px solid #EEC595;
            border-radius: 20px;

            background-color: white;
            width: 785px;
            height: 20px;
            margin: 20px 0px 0px 100px;
        }

        .reply_del {
            position: absolute;
            right: 10px;
            top: 10px;
            border: none;
            padding: 5px 20px;
            border-radius: 10px;
            font-family: "paybooc-Light", sans-serif;
            box-shadow: 0 10px 320px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            font-weight: 400;
            transition: 0.25s;
            background-color: #EEC595;
            margin-right: 5px;
        }

        .reply_one label {
            margin-left: 10px;
            margin-right: 40px;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript">
        // 추천하기 버튼 클릭 시
        $(function(){
            $('#recommand_bnt').click(function (){
                $.ajax({
                    url : 'recommand',
                    type : 'post',
                    dataType : 'json',
                    data : {'board_id': '<c:out value="${board.board_id}"/>'},
                    success:function (response){
                        console.log(response.recommand_select);
                        console.log(response.recommandCount);
                        if(response.recommand_select){
                            $("#recommand_bnt").attr("src", "imgView?file=heart_fill.png")
                        }else{
                            $("#recommand_bnt").attr("src", "imgView?file=heart_empty.png")
                        }
                        $("#recommandCount").text(response.recommandCount);
                    },
                    error:function (error){
                        console.log(error)
                    }
                })
            })
        })
    </script>

    <script type="text/javascript">
        // 찜하기 버튼 클릭 시
        $(function(){
            $('#wish_bnt').click(function (){
                $.ajax({
                    url : 'wish',
                    type : 'post',
                    dataType : 'json',
                    data : {'board_id': '<c:out value="${board.board_id}"/>'},
                    success:function (response){
                        console.log(response.wish_select);
                        if(response.wish_select){
                            $("#wish_bnt").attr("src", "imgView?file=star_fill.png")
                        }else{
                            $("#wish_bnt").attr("src", "imgView?file=star_empty.png")
                        }
                    },
                    error:function (error){
                        console.log(error)
                    }
                })
            })
        })
    </script>
</head>
<body>
<jsp:include page="header.jsp"/>

    <div class="all_content">
        <!-- 제목, 조회수, 추천수 -->
        <div class="content_title">
            <div class="title_store" style="display: inline-block;">
                <div class="title">${board.title} </div> <!-- TODO css 깨지는 부분 수정 필요 -->
                <div class="store"> 편의점 : ${store_category_name}</div> <!-- TODO 편의점 카테고리 관련 정보 가져오는 로직 추가 필요 -->
            </div>
            <table class="recommand_date">
                <tr>
                    <td>
                         추천수 : <span  id = "recommandCount">${board.recommand_count}</span>
                    </td>
                </tr>
                <tr>
                    <td>${board.regdate} &nbsp; ${board.nickname}</td> <!-- TODO 날짜 형식 수정 필요 -->
                </tr>
            </table>
        </div>
    </div>

    <!-- 내용 -->
    <div class="content_detail">
        <div class="picture"><img src="imgView?file=${board.picture}" alt="" style="width:350px"></div>
        <br>
        <!-- TODO : 토스트 에디터 데이터 저장 및 가져오기 해결 후 로직 변경 -->
        <div class="content">
            <div  style="text-align: center">
            ${board.content}
            </div>
            <!--
            <div style="text-align : center;"> 재료 : 오감자, 체다치즈, 스트링치즈</div>
            <br><br>
            <div class="picture_text"><img src="imgView?file=mirro.jpg" alt="" style="padding-left: 20%;">1. 오감자를 접시에
                얹어준다.
            </div>
            <br>
            <div class="picture_text"><img src="imgView?file=mirro.jpg" alt="" style="padding-left: 20%;">2. 체다치즈와
                스트링치즈를 찢어서 얹는다
            </div>
            <br>
            <div class="picture_text"><img src="imgView?file=mirro.jpg" alt="" style="padding-left: 20%;">3. 전자레인지에 1분
                정도 돌리면 완성
            </div>
            <br>

            <br>
            <div style="text-align : center;">
                이것만큼 맛있는 안주는 없었다. 이것은 그라탕인가 오감자인가<br>
                오감자치즈후라이로 불금 어떠신가요??
            </div>
        -->
         <br><br>
        </div>
        <!-- 추천하기 버튼 -->
        <button class="heart_btn" style="margin-left:43%"  name="recommand">
        <c:choose>
            <c:when test="${recommand_select == true}">
                   <img id = "recommand_bnt" src="imgView?file=heart_fill.png" width="60px" height="60px" alt=""/>
                    <div>추천하기</div>
            </c:when>
            <c:otherwise>
                    <img id="recommand_bnt" src="imgView?file=heart_empty.png" width="60px" height="60px" alt=""/>
                    <div>추천하기</div>
            </c:otherwise>
        </c:choose>
        </button>
        <!-- 찜하기 버튼 -->
        <button class="star_btn" id="wish" name="wish_bnt">
            <c:choose>
                <c:when test="${wish_select == true}">
                    <img id = "wish_bnt" src="imgView?file=star_fill.png" width="60px" height="60px" alt=""/>
                </c:when>
                <c:otherwise>
                    <img id="wish_bnt" src="imgView?file=star_empty.png" width="60px" height="60px" alt=""/>
                </c:otherwise>
            </c:choose>
            <div>찜하기</div>
        </button>
        <br><br>
    </div>

    <!-- 수정, 삭제 버튼 -->
    <!-- 각 페이지로 이동하는 링크 추가 필요 -->
    <form name="modify_delete">
    <br>
        <c:if test="${member.nickname eq board.nickname}">
            <button class="mod_del" type="submit" id="board_modify" name="board_id" value="${board.board_id}" formaction="board_modify?" formmethod="get">
                수정
            </button>
            <button class="mod_del" type="submit" id="board_delete" name="board_id" value="${board.board_id}" formaction="board_delete?"
                    formmethod="get"> 삭제
            </button>
        </c:if>
    <br><br><br>
    </form>

    <div class="all_reply">
        <div class="reply">
            <textarea class="reply_register" placeholder="댓글을 입력하세요."></textarea>
            <button class="reply_bnt" type="submit" id="reply_register" name="reply_register" formaction="reply"
                    formmethod="post"> 등록
            </button>
        </div>
        <div class="reply_content">
            <div class="reply_one">
                <div style="display: inline-block;"><label>닉네임 </label></div>
                <div style="display: inline-block;"> 너무 맛있어 보여요~~</div>
            </div>
            <button class="reply_del" type="submit" id="reply_delete" name="reply_delete" formmethod="get"
                    formaction="reply"> 삭제
            </button>
        </div>
        <div class="reply_content">
            <div class="reply_one">
                <div style="display: inline-block;"><label>닉네임 </label></div>
                <div style="display: inline-block;"> 너무 맛있어 보여요~~</div>
            </div>
            <button class="reply_del" type="submit"> 삭제</button>
        </div>
        <div class="reply_content">
            <div class="reply_one">
                <div style="display: inline-block;"><label>닉네임 </label></div>
                <div style="display: inline-block;"> 너무 맛있어 보여요~~</div>
            </div>
            <button class="reply_del" type="submit"> 삭제</button>
        </div>
        <div class="reply_content">
            <div class="reply_one">
                <div style="display: inline-block;"><label>닉네임 </label></div>
                <div style="display: inline-block;"> 너무 맛있어 보여요~~</div>
            </div>
            <button class="reply_del" type="submit"> 삭제</button>
        </div>
        <div class="reply_content">
            <div class="reply_one">
                <div style="display: inline-block;"><label>닉네임 </label></div>
                <div style="display: inline-block;"> 너무 맛있어 보여요~~</div>
            </div>
            <button class="reply_del" type="submit"></button>
        </div>
    </div>


<jsp:include page="footer.jsp"/>

</body>