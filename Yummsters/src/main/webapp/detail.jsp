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
                        console.log(response);
                        console.log(response.recommand_select);
                        console.log(response.recommandCount);
                        if(response.login === false){
                            alert("로그인 후 이용해 주세요.");
                            location.href="login";
                            return false;
                        }
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
                        console.log(response);
                        console.log(response.wish_select);

                        if(response.login === false){
                            alert("로그인 후 이용해 주세요.");
                            location.href="login";
                            return false;
                        }
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

    <script type="text/javascript">
        function boardDeleteCheck(){
            return confirm("정말 삭제 하시겠습니까?");
        }

    </script>

    <script type="text/javascript">
        var member = {
            nickname: '<c:out value="${member.nickname}"/>'
        };
        $(function(){

            // 페이지 로딩 시 초기 데이터 가져오기
            $(document).ready(function() {
                loadInitReply();
            });

            function loadInitReply(){
                /* $.ajax({
                    url : 'reply_init',
                    type : 'get',
                    dataType : 'json',
                    data : {'board_id': '<c:out value="${board.board_id}"/>'},
                    success:function(response){
                        console.log(response.replyList);
                        reloadReply(response.replyList);
                    },
                    error:function (request, status, error){
                        console.log(error);
                        alert("code: " + request.status + " message: " + request.responseText + " error: " + error);
                    }
                })  */
            	getList(1);
            }

            // 등록 버튼 클릭 시 실행
            $('.reply_bnt').click(function (){
                $.ajax({
                    url : 'reply',
                    type : 'post',
                    dataType: 'json',
                    data : {'board_id': '<c:out value="${board.board_id}"/>', 'content': $("#reply_contents").val()},
                    success:function (response){
                        console.log(response);
                        console.log(response.register);
                        console.log(response.replyList);

                        if(response.login === false){
                            alert("로그인 후 이용해 주세요.");
                            location.href="login";
                            return false;
                        }
                        reloadReply(response.replyList);
                    },
                    error:function (request, status, error){
                        console.log(error);
                        alert("code: " + request.status + " message: " + request.responseText + " error: " + error);
                    }
                });
                $('#reply_contents').val('')
            });


            // 삭제 버튼 클릭 시 실행
            $(".reply_del").click(function (){
                var replyId = $(this).data('reply-id'); // data-reply-id에서 reply_id 값을 읽어옴

                deleteReply(replyId);
            });

        });
        // 댓글 등록 로직
        function reloadReply(replyList) {
            var nickname = member.nickname;

            var commentSection = $("#commentSection");
            commentSection.empty();

            $.each(replyList, function (index, reply) {
                // 댓글 컨테이너 생성
                var commentDiv = $('<div class="reply_content"></div>');

                // 댓글 정보 가져오기 댓글
                var commentText = $('<div class="reply_one"><div style="display: inline-block;"><label>'
                    + reply.nickname + '</label></div><div style="display: inline-block;">'
                    + reply.content + '</div></div>');
                commentDiv.append(commentText);

                // 회원에 따라 삭제 버튼을 추가
                if (reply.nickname === nickname) {
                    var deleteButton = $('<button class="reply_del" type="button" id="delete_button_' + reply.reply_id + '"> 삭제 </button>');
                    commentDiv.append(deleteButton);

                    // 삭제 버튼 클릭 이벤트 처리
                    deleteButton.click(function () {
                        var replyId = reply.reply_id;
                        deleteReply(replyId);
                    });
                }
                // 생성한 댓글 컨테이너 화면에 추가
                commentSection.append(commentDiv);
            });
        }

        // 댓글 삭제 로직
        function deleteReply(replyId){
            $.ajax({
                url : 'reply',
                type : 'get',
                dataType: 'json',
                data : {'reply_id': replyId},
                success:function (response){
                    console.log(response.delete);
                    console.log(response.replyList);
                    reloadReply(response.replyList);
                },
                error:function (request, status, error){
                    console.log(error);
                    alert("code: " + request.status + " message: " + request.responseText + " error: " + error);
                }
            });
        }
    </script>
    
    </script>
    <!-- 혜리 작성 부분. 댓글 infinite scroll 구현 -->
    <script type="text/javascript">
        var curPage = 1; //페이지 초기값
        var isLoading = false; //현재 페이지가 로딩중인지 여부

        $(window).on("scroll", function() { //scroll 이벤트 발생 시 실행됨
        	if (isLoading) return;
        	var scrollTop = $(window).scrollTop(); //위로 스크롤된 길이
        	var windowsHeight = $(window).height(); //웹브라우저의 창의 높이
        	var isBottom = scrollTop + windowsHeight >= commentSection.offsetTop + commentSection.offsetHeight; //바닥에 갔는지 여부
        	//숫자 10은 약간의 여유 여백. 사용자가 스크롤을 더 아래로 내릴 때 추가 데이터를 로드하는 동작이 보다 자연스럽게 동작
        	
        	if(isBottom) {
        		//만일 현재 마지막 페이지라면
        		if(curPage >= ${totPage}) {
        			return false; //함수 종료
        		} else {
        			curPage++; //현재 페이지 1 증가
        			getList(curPage); //추가로 받을 리스트 ajax 처리
        		}
        	}
        });
        
        //댓글 리스트 불러오기 함수
        function getList(curPage) {
        	if (isLoading) return;
     		isLoading = true; //위에서 종료되지 않으면 로딩 상태를 true로 변경
        	$.ajax({
        		type: "get",
        		url: "infinitescrollreply",
        		data: {"board_id" :  ${board_id},
        			"curPage" : curPage},
        		success:function(data) {
        			//서버에서 전송된 데이터를 reply_one에 추가하기
        			$(".reply_one").append(data);
        			isLoading = false; //로딩여부를 false로 변경
        		}
        	});
        }
    </script>

</head>
<body>
<jsp:include page="header.jsp"/>

    <div class="all_content">
        <!-- 제목, 조회수, 추천수 -->
        <div class="content_title">
            <div class="title_store" style="display: inline-block;">
                <div class="title">${board.title} </div> <!-- TODO css 깨지는 부분 수정 필요 -->
                <div class="store"> 편의점 : ${board.store_category_name}</div>
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

        <div class="content">
            <div  style="text-align: center">
            ${board.content}
            </div>

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
            <button class="mod_del" id="board_delete" type="submit" name="board_id" value="${board.board_id}" formaction="board_delete?"
                    formmethod="get"
                    onclick="return boardDeleteCheck();"> 삭제
            </button>
        </c:if>
    <br><br><br>
    </form>

    <div class="all_reply" >
        <div class="reply">
            <textarea class="reply_register" id="reply_contents" placeholder="댓글을 입력하세요."></textarea>
            <button class="reply_bnt" type="submit" id="reply_register" data-reply-member="${member.nickname}" name="reply_register"> 등록 </button>
        </div>
        <br>

        <div class="reply_content" id="commentSection" style="height: 320px;  overflow:auto;">
                <!-- <div class="reply_one"> -->
                    <!--<div style="display: inline-block;"><label> ${reply.nickname} </label></div>
                    <div style="display: inline-block;"> ${reply.content} </div>-->
                <!-- </div> -->
                <!-- <c:if test="${reply.nickname eq member.nickname}">
                    <button class="reply_del" type="button" data-reply-id="${reply.reply_id}" data-reply-member="${member.nickname}"> 삭제 </button>
                </c:if>-->
        </div>
    </div>

<jsp:include page="footer.jsp"/>

</body>