<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���̵� ã��</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    $(document).ready(function() {
        // ���̵� ã�� ��ư Ŭ�� �̺�Ʈ
        $('#findId').click(function() {
            var name = $('#name').val();
            var nickname = $('#nickname').val();
            var email = $('#email').val();

            // �Է°��� ����ִ��� Ȯ��
            if (name === "" || nickname === "" || email === "") {
                alert("��� ������ �Է����ּ���.");
                return;
            }

            // ������ ��û�� ���� ���̵� ã��
            $.ajax({
                type: 'POST',
                url: 'findmemberid', // ���� ���� URL�� �����ؾ� ��
                data: {
                    member_name: name,
                    nickname: nickname,
                    email: email
                },
                success: function(response) {
                    // �������� ���� ������ ó��
                   
                    $('#IdInfo').text(response);
                },
                error: function() {
                    alert("���� ������ �߻��߽��ϴ�.");
                }
            });
        });
    });
</script>
</head>
<body>
    <div id="name1" style="display: inline">
        <b>�̸�</b>
    </div>
    <input id="name" type="text" name="name" required placeholder="�̸��� �Է��ϼ���."><br>

    <div id="nickname1" style="display: inline">
        <b>�г���</b>
    </div>
    <input id="nickname" type="text" name="nickname" required placeholder="�г����� �Է��ϼ���."> <span id="nicknameErr"></span><br>

    <div id="email1" style="display: inline">
        <b>�̸���</b>
    </div>
    <input id="email" type="text" name="email" required placeholder="�̸����� �Է��ϼ���.">
    <p>ȸ������ ���̵��:</p><p id="IdInfo"></p>

    <button class="findId" id="findId" type="button" style="display: inline">���̵�ã��</button>
</body>
</html>
