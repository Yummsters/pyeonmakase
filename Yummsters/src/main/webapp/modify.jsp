<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>레시피 수정 페이지</title>
    <style>

        .title_picture {
            margin: 0 auto;
            margin-left: 200px;
        }


        /* 레시피명 입력칸 관련 스타일 적용 */
        #title {
            width: 500px;
            height: 30px;
            background-color: white;
            border: 3px solid #EEC595;
            border-radius: 10px;
        }

        /* 버튼 관련 스타일 적용 */
        button {
            position: relative;
            border: none;
            display: inline-block;
            padding: 5px 20px;
            border-radius: 10px;
            font-family: "paybooc-Light", sans-serif;
            box-shadow: 0 10px 320px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            font-weight: 400;
            transition: 0.25s;
        }

        .red {
            border-style: solid;
            border-color: #EEC595;
            background-color: rgb(252, 101, 101);
        }

        .green {
            border-style: solid;
            border-color: #EEC595;
            background-color: rgb(83, 227, 83);
        }

        /* 카테고리 관련 스타일 적용 */
        /* 편의점 카테고리 */
        .store_category {
            background: #EEC595;
            margin: 10px auto;
            padding: 10px;
            display: flex;
            flex-direction: row;
            align-items: center;
            /* 수직 가운데 정렬*/
            justify-content: space-between;
            /* 수평 정렬*/
            height: 30px;
            width: 600px;
            border-radius: 10px;
        }

        .store_category img {
            width: 30px;
            height: 20px;
        }

        .store_category label {
            display: inline-block;
            margin-right: 20px;
        }

        /* 음식 카테고리 */
        .food_category {
            background: #FAE3C8;
            margin: 10px auto;
            padding: 10px;
            display: flex;
            flex-direction: row;
            align-items: center;
            /* 수직 가운데 정렬*/
            justify-content: space-between;
            /* 수평 정렬*/
            height: 30px;
            width: 600px;
            border-radius: 10px;
        }

        .food_category label {
            display: inline-block;
            margin-right: 20px;
        }


        input[type="checkbox"] {
            width: 15px;
            height: 15px;
        }

    </style>
    <!-- jQuery CDN -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- jQuery UI CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <!-- jQuery UI CSS CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>
    <!-- codemirror CDN URL -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>

    <!-- TOAST UI Editor CDN URL(CSS) -->
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css"/>

    <!-- TOAST UI Editor CDN URL(JS) -->
    <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript">
        $(function() {
            // 체크박스 전체선택, 해제
            $("#all").click(
                function () {
                    // 전체 하위 체크박스들을 선택 또는 해제
                    $("input[name='store']").prop("checked",
                        $(this).prop("checked"));
                });

            // 하위 체크박스들 중 하나라도 선택 취소되면 "전체 선택" 체크박스도 선택 취소
            $("input[name='store']").click(
                function () {
                    if ($("input[name='store']:checked").length === $("input[name='store']").length) {
                        $("#all").prop("checked", true);
                    } else {
                        $("#all").prop("checked", false);
                    }
                });

            // 하위 체크박스들을 모두 선택하면 "전체 선택" 체크박스도 선택
            $("input[name='store']").change(
                function () {
                    if ($("input[name='store']:checked").length === $("input[name='store']").length - 1) {
                        $("#all").prop("checked", true);
                    }
                }
            );
        });
    </script>

    <script>
        // 편의점 및 음식 카테고리를 한 개 이상 선택
        function categoryCheck(form){
            var arr_store = document.getElementsByName('store');
            var arr_food = document.getElementsByName('food');

            var store_num = 0;
            var food_num = 0;

            // 체크 개수 확인
            for(var i=0; i<arr_store.length; i++){
                if(arr_store[i].checked){
                    store_num++;
                }
            }

            for(var i=0; i<arr_food.length; i++){
                if(arr_food[i].checked){
                    food_num++;
                }
            }

            if(!store_num && !food_num){
                alert('편의점 및 카테고리를 하나 이상 선택해주세요.')
                return false;
            }else if(!store_num){
                alert('편의점을 하나 이상 선택해주세요.')
                return false;
            }else{

            }alert('카테고리를 하나 이상 선택해주세요.')
            return false;
        }
    </script>

    <script>
        // 음식 카테고리 한 개만 선택 가능
        function foodCheckboxGroup(currentCheckbox) {
            const checkboxes = document.getElementsByName("food");
            let checkedCount = 0;

            for (let i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    checkedCount++;
                    if (checkboxes[i] !== currentCheckbox) {
                        checkboxes[i].checked = false;
                    }
                }
            }

            if (checkedCount === 0) {
                currentCheckbox.checked = true;
            }
        }
    </script>

</head>

<body>
<jsp:include page="header.jsp"/>

<form name="recipe_modify" onsubmit="return categoryCheck(this)">
    <input type="hidden" name="board_id" value="${board.board_id}">
    <div class="title_picture">
        <!-- 제목 입력 및 취소/저장 버튼 -->
        <div class="register_title">
            레시피명 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input id="title" type="text" name=board_title value="${board.title}"> &nbsp;
            <button class="red" type="submit" id="cancel" name="cancel" formaction="modify" formmethod="get">
                취소
            </button>
            <button class="green" type="submit" id="modify" name="modify" formaction="modify" formmethod="post"> 수정
            </button>
        </div>
        <br>

        <!-- 썸네일 선택 -->
        <div class="picture">
            썸네일 선택 &nbsp;
            <input type="file" name="board_picture">
        </div>
    </div>
    <br>

    <!-- 편의점 선택 -->
    <div class="store_category">
        &nbsp;&nbsp; 편의점 선택 &nbsp&nbsp;&nbsp; &nbsp;&nbsp;
        <!-- TODO : 이미 선택되어 있는 편의점들 가져와서 체크표시 -->
        <c:out value="${board.store_category_name}"/>
        <c:set var = "store_category_name" value="${board.store_category_name}"/>
        <c:choose>
            <c:when test="${fn:contains(store_category_name,'all')}">
                <input type="checkbox" name="store" id="all" value="1" checked>
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="store" id="all" value="1">
            </c:otherwise>
        </c:choose>
        <label for="all">전체</label>

        <c:choose>
            <c:when test="${fn:contains(store_category_name,'CU')}">
                <input type="checkbox" name="store" id="cu" value="2" checked>
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="store" id="cu" value="2">
            </c:otherwise>
        </c:choose>
        <label for="cu"><img src="imgView?file=cu.png" alt=""></label>

        <c:choose>
            <c:when test="${fn:contains(store_category_name,'GS25')}">
                <input type="checkbox" name="store" id="gs" value="3" checked>
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="store" id="gs" value="3">
            </c:otherwise>
        </c:choose>
        <label for="gs"><img src="imgView?file=gs.png" alt=""></label>

        <c:choose>
            <c:when test="${fn:contains(store_category_name,'SevenEleven')}">
                <input type="checkbox" name="store" id="seven" value="4" checked>
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="store" id="seven" value="4">
            </c:otherwise>
        </c:choose>
        <label for="seven"><img src="imgView?file=seven.png" alt=""></label>

        <c:choose>
            <c:when test="${fn:contains(store_category_name,'기타')}">
                <input type="checkbox" name="store" id="etc" value="5" checked>
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="store" id="etc" value="5">
            </c:otherwise>
        </c:choose>
        <label for="etc">기타</label>
    </div>

    <!-- 카테고리 선택 -->
    <div class="food_category">
        &nbsp;&nbsp;카테고리 선택 &nbsp;&nbsp;
        <c:choose>
            <c:when test="${board.food_category_id == 1}">
                <input type="checkbox" name="food" id="meal" value="1" checked onchange="foodCheckboxGroup(this)">
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="food" id="meal" value="1" onchange="foodCheckboxGroup(this)">
            </c:otherwise>
        </c:choose>
        <label for="meal">식사류</label>

        <c:choose>
            <c:when test="${board.food_category_id == 2}">
                <input type="checkbox" name="food" id="desert" value="2" onchange="foodCheckboxGroup(this)" checked>
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="food" id="desert" value="2" onchange="foodCheckboxGroup(this)">
            </c:otherwise>
        </c:choose>
        <label for="desert">간식류</label>

        <c:choose>
            <c:when test="${board.food_category_id == 3}">
                <input type="checkbox" name="food" id="drink" value="3" onchange="foodCheckboxGroup(this)" checked>
            </c:when>
            <c:otherwise>
                <input type="checkbox" name="food" id="drink" value="3" onchange="foodCheckboxGroup(this)">
            </c:otherwise>
        </c:choose>
        <label for="drink">음료</label>
    </div>
    <br>

    <!-- 토스트 에디터 넣기 -->
    <div id="content"></div>
    <!-- TUI 에디터 JS CDN -->
    <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

    <script>
        // 에터 객체 생성
        const editor = new toastui.Editor({
            el: document.querySelector('#content'), // 에디터를 적용할 요소 (컨테이너)
            height: '500px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
            initialEditType: 'wysiwyg',            // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
            previewStyle: 'vertical'//,                // 마크다운 ß프리뷰 스타일 (tab || vertical)

            // 이미지가 Base64 형식으로 입력되는 것 가로채주는 옵션
            // 추후 jsp 파일로 바꾼 이후 서블릿의 메서드를 이용해 매핑하여 업로드 이미지를 처리할 컨트롤러 생성 필요
            /*hooks: {
                addImageBlobHook: (blob, callback) => {
                    // blob : Java Script 파일 객체
                    console.log(blob);

                    // 에디터에 업로드한 이미지를 FormData 객체에 저장
                    const formData = new FormData();
                    formData.append('image', blob);

                    let url = '/images/';
                    $.ajax({ // 이미지 업로드 시 로직 처리 필요s
                        type: 'POST',
                        enctype: 'multipart/form-data',
                        url: '/ImageUploadServlet', // 매핑할 서블릿 경로 설정하여 호출 진행
                        dasta: formData,
                        dataType: 'json',
                        processData: false,
                        contentType: false,
                        cache: false,
                        timeout: 600000,
                        success: function (data) {
                            //console.log('ajax 이미지 업로드 성공');
                            url += data.filename;

                            // callback : 에디터(마크다운 편집기)에 표시할 텍스트, 뷰어에는 imageUrl 주소에 저장된 사진으로 나옴
                            // ImageUploadServlet을 실행해서 나온 결과값을 callback 함수를 통해 url을 추출해 이미지를 삽입 (서블릿에서 설정한 키의 값으로 불러와야 함)
                            // 형식 : ![대체 텍스트](주소)
                            callback(url, '사진 대체 텍스트 입력');
                        },
                        error: function (e) {
                            //console.log('ajax 이미지 업로드 실패');
                            //console.log(e.abort([statusText]));

                            callback('image_load_fail', '사진 대체 텍스트 입력');
                        }
                    });
                }
            }*/
        });
        console.log('${board.content}');
        editor.setHTML('${board.content}');

        //editor.getHtml()을 사용해서 에디터 내용 수신
        //document.querySelector('#contents').insertAdjacentHTML('afterbegin', editor.getHTML());
        // 콘솔창에 표시(브라우저에서 content 값 확인)
        // console.log(editor.getHTML());
    </script>
</form>
<jsp:include page="footer.jsp"/>
</body>