<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">
<head>
    <!-- TOAST UI Editor CDN URL(CSS) -->
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css"/>

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
        $(function() {
            var store_num = 0;
            var food_num = 0;
            $("#register").submit(function (e) {
                store_num = $("input[name='store']:checked").length;
                food_num = $("input[name='food']:checked").length;


                if(store_num===0){
                    alert('편의점을 하나 이상 선택해주세요.')
                    e.preventDefault();
                    return false;
                }
                if(food_num===0) {
                    alert('카테고리를 하나 이상 선택해주세요.')
                    e.preventDefault();
                    return false;
                }

                var content = editor.getHTML();
                content=content.replaceAll(' ','');
                console.log(content);
                if(content == "<p><br></p>"||content == "<p></p>"||content ==""||content == null) {
                    alert("내용을 입력해 주세요");
                    e.preventDefault();
                    return false;
                }

                $("#editorContent").val(editor.getHTML());
                return true;
            })

        })
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

            if(store_num===0){
                alert('편의점을 하나 이상 선택해주세요.')
                return false;
            }
            if(food_num===0){
                alert('카테고리를 하나 이상 선택해주세요.')
                return false;
            }
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
<div class="body_container">
<form name="recipe_register" enctype="multipart/form-data" id="register" action="register" method="post" >
    <div class="title_picture">
        <!-- 제목 입력 및 취소/저장 버튼 -->
        <div class="register_title" style="font-size:20px">
            레시피명 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input id="title" type="text" name=board_title placeholder="대표 제목을 입력하세요.(30자 이내)" maxlength='30' required> &nbsp;
            <button class="red" id="cancel" name="cancel" onclick="location.href='mainlist'">
                취소
            </button>
            <button class="green" type="submit" id="registerButton" name="register" >
                등록
            </button>
        </div>
        <br>

        <!-- 썸네일 선택 -->
        <div class="picture" style="font-size:20px">
            썸네일 선택 &nbsp;
            <input type="file" name="board_picture" required>
        </div>
    </div>
    <br>

    <!-- 편의점 선택 -->
    <div class="store_category">
        &nbsp;&nbsp; 편의점 선택 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
        <input type="checkbox" name="store" id="all" value="1">
        <label for="all">전체</label>
        <input type="checkbox" name="store" id="cu" value="2">
        <label for="cu"><img src="imgView?file=cu.png" alt=""></label>
        <input type="checkbox" name="store" id="gs" value="3">
        <label for="gs"><img src="imgView?file=gs.png" style="height:30px" alt=""></label>
        <input type="checkbox" name="store" id="seven" value="4">
        <label for="seven"><img src="imgView?file=seven.png" alt=""></label>
        <input type="checkbox" name="store" id="etc" value="5">
        <label for="etc">기타</label>
    </div>

    <!-- 카테고리 선택 -->
    <div class="food_category">
        &nbsp;&nbsp;카테고리 선택 &nbsp;&nbsp;
        <input type="checkbox" name="food" id="meal" value="1">
        <label for="meal">식사류</label>
        <input type="checkbox" name="food" id="desert" value="2">
        <label for="desert">간식류</label>
        <input type="checkbox" name="food" id="drink" value="3">
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
            height: '600px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
            initialEditType: 'wysiwYg',            // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
            initialValue: '레시피를 작성해주세요.',     // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
            previewStyle: 'vertical'
            // 마크다운 ß프리뷰 스타일 (tab || vertical)
        });

        console.log(editor.getHTML());
    </script>

    <!-- 토스트 에디터에 작성한 내용 디비 저장을 위한 div -->
    <input type="hidden" name="editorContent" id="editorContent" value="">

</form>
</div>
<jsp:include page="footer.jsp"/>
</body>