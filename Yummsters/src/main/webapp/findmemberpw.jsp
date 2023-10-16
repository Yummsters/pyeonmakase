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
        $('#findPw').click(function() {
            var name = $('#name').val();
            var nickname = $('#nickname').val();
            var email = $('#email').val();
            var member_id = $('#member_id').val();

            // �Է°��� ����ִ��� Ȯ��
            if (name === "" || nickname === "" || email === "" || member_id === "") {
                alert("��� ������ �Է����ּ���.");
                return;
            }

            // ������ ��û�� ���� ���̵� ã��
            $.ajax({
                type: 'POST',
                url: 'findmemberpw', // ���� ���� URL�� �����ؾ� ��
                data: {
                    member_name: name,
                    nickname: nickname,
                    email: email,
                    member_id: member_id
                },
                success: function(response) {
                    // �������� ���� ������ ó��
                   
                    $('#PwInfo').text(response);
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
    <input id="nickname" type="text" name="nickname" required placeholder="�г����� �Է��ϼ���."><br>

    <div id="email1" style="display: inline">
        <b>�̸���</b>
    </div>
    <input id="email" type="text" name="email" required placeholder="�̸����� �Է��ϼ���."><br>
    
     <div id="member_id1" style="display: inline">
        <b>���̵�</b>
    </div>
    <input id="member_id" type="text" name="member_id" required placeholder="���̵� �Է��ϼ���.">
    <p>ȸ������ ��й�ȣ��:</p><p id="PwInfo"></p>

    <button class="findPw" id="findPw" type="button" style="display: inline">��й�ȣã��</button>
</body>
</html>
