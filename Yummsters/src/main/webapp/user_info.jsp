<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"  %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="<c:url value='/css/mainStyle.css'/>">
<script>
$(document).ready(function() {
    // 회원정보 수정 버튼 이벤트 핸들러
    $('#userRegister').click(function() {
        location.href = "usermodify";
    });
               
 // 회원탈퇴 버튼 이벤트 핸들러
    $('#userDelete').click(function() {
            var modalBackground = $('<div class="modal-background"></div>');
            // 모달 배경 표시
            $('body').append(modalBackground);
            var modal = $('<div class="modal">' +
            	    '<p>정말 탈퇴하시겠습니까? <br> 탈퇴하시면 회원 정보를 되돌릴 수 없습니다.</p>' +
            	    '<input type="password" id="passwordInput" placeholder="비밀번호 입력">' +
            	    '<br><br><button id="confirmButton2">취소</button>' + '<button id="confirmButton1">확인</button>' +
            	    '</div>');
            $('body').append(modal);
            // 모달 표시
            modal.show();
            modalBackground.show();

            // 확인 버튼 클릭 이벤트
            $('#confirmButton1').click(function() {
            	 var message = $('#passwordInput').val(); // 여기서 'message'를 정의합니다.

            var memberNickname = "${sessionScope.member.nickname}";
          var memberPw = "${sessionScope.member.member_pw}";
                         
          if(memberPw == message) {
                $.ajax({
                    url: 'memberdelete',
                    type: 'POST',
                    data: {
                        nickname: memberNickname,
                        password: memberPw
                    },
                    success: function(response) {
						swal({
							title: '회원 탈퇴가 완료되었습니다',
							icon: 'success',
							buttons: {
								confirm: {
									text: '확인',
									value: true,
									visible: true,
									className: 'swal-custom' // 사용자 정의 클래스 추가
								}
							}
						})
						location.href = "home"; // 탈퇴 후 리다이렉트할 페이지
                    },
                    error: function() {
						swal({
							title: '서버 오류가 발생했습니다 \n 관리자에게 문의하세요',
							icon: 'error',
							buttons: {
								confirm: {
									text: '확인',
									value: true,
									visible: true,
									className: 'swal-custom' // 사용자 정의 클래스 추가
								}
							}
						})
                    }
                });
          } else {
                 alert("비밀번호가 일치하지 않습니다.");
                 console.log("password: " + password)

                }
                    // 모달 닫기
                    modal.hide();
                    //모달 배경 닫기
                    modalBackground.hide();
          });
              //취소 버튼 클릭 이벤트
                $('#confirmButton2').click(function() {
                      
                           location.href = "userinfo";
                           // 모달 닫기
                           modal.hide();
                           //모달 배경 닫기
                           modalBackground.hide();
                       
          
       });
   });

    $('#naverDelete').click(function() {
		swal({
			title: '정말 탈퇴 하시겠습니까? \n 탈퇴 하시면 회원정보를 되돌릴 수 없습니다',
			icon: 'question',
			buttons: {
				confirm: {
					text: '확인',
					value: true,
					visible: true,
					className: 'swal-custom' // 사용자 정의 클래스 추가
				},
				cancel: {
					text: '취소',
					value: null,
					visible: true,
					className: 'swal-custom' // 사용자 정의 클래스 추가
				}
			}
		}).then((result) => {
			if (result) {
				$.ajax({
					url: "naverDelete",
					type: "POST",
					success: function (response) {
						$.ajax({
							url: 'memberdelete',
							type: 'POST',
							data: {
								nickname: "${sessionScope.member.nickname}",
								password: "${sessionScope.member.member_pw}"
							},
							success: function(response) {
								swal({
									title: '회원 탈퇴가 완료되었습니다',
									icon: 'success',
									buttons: {
										confirm: {
											text: '확인',
											value: true,
											visible: true,
											className: 'swal-custom' // 사용자 정의 클래스 추가
										}
									}
								}).then((result) => {
									if (result) {
										location.href = "home";
									}
								});
								return false;
							},
							error: function() {
								swal({
									title: '서버 오류가 발생했습니다 \n 관리자에게 문의하세요',
									icon: 'error',
									buttons: {
										confirm: {
											text: '확인',
											value: true,
											visible: true,
											className: 'swal-custom' // 사용자 정의 클래스 추가
										}
									}
								})
							}
						});
					},
					error: function (res) {
						swal({
							title: '서버 오류가 발생했습니다 \n 관리자에게 문의하세요',
							icon: 'error',
							buttons: {
								confirm: {
									text: '확인',
									value: true,
									visible: true,
									className: 'swal-custom' // 사용자 정의 클래스 추가
								}
							}
						})
					}
				});
			}
		});
	});
});
</script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
	// 탈퇴 시 디비에서 정보 삭제하는 로직 추가 필요. commit 할 때는 얘 제외하고 하기
	Kakao.init('${kakao.script.key}');

	document.addEventListener("DOMContentLoaded", function () {
		document.getElementById("kakaoDeleteLink").addEventListener("click", function (event) {
			event.preventDefault(); // 기본 링크 동작 방지
			var nickname = this.getAttribute('data-member-id');

			// 질문 후 취소 클릭 시 작동 멈춤
			swal({
				title: '정말 탈퇴하시겠습니까? \n 탈퇴하시면 회원정보를 되돌릴 수 없습니다',
				icon: 'question',
				buttons: {
					confirm: {
						text: '확인',
						value: true,
						visible: true,
						className: 'swal-custom' // 사용자 정의 클래스 추가
					},
					cancel: {
						text: '취소',
						value: null,
						visible: true,
						className: 'swal-custom' // 사용자 정의 클래스 추가
					}
				}
			}).then((result) => {
				if (result) {
					Kakao.API.request({
						url: '/v1/user/unlink'
					}).then(function (response) {
						console.log(response);
						$.ajax({
							url: 'memberdelete',
							type: 'POST',
							data: {
								nickname: nickname,
								password: "kakaoLogin"
							},
							success: function(res) {
								swal({
									title: '회원 탈퇴가 완료되었습니다',
									icon: 'success',
									buttons: {
										confirm: {
											text: '확인',
											value: true,
											visible: true,
											className: 'swal-custom' // 사용자 정의 클래스 추가
										}
									}
								}).then((result) => {
									if (result) {
										location.href = "home";
									}
								});
								return false;
							},
							error: function(jqXHR, textStatus, errorThrown) {
								console.log('jqXHR:', jqXHR);
								console.log('textStatus:', textStatus);
								console.log('errorThrown:', errorThrown);
								swal({
									title: '서버 오류가 발생했습니다 \n 관리자에게 문의하세요',
									icon: 'error',
									buttons: {
										confirm: {
											text: '확인',
											value: true,
											visible: true,
											className: 'swal-custom' // 사용자 정의 클래스 추가
										}
									}
								})
							}
						});
					}).catch(function (error) {
						console.log(error);
					});
				}else {
					event.preventDefault();
					return false;
				}
			});
		});
	});
</script>

<body>
	<jsp:include page="header.jsp" />
	<!-- 박스-->
	<br>
	<div class="body_container">
		<div class="box" style="border: 5px solid #EEC595">
			<!-- 원-->
			<div class="c1" style="display: inline"></div>
			<div class="c2"></div>
			<div class="c3"></div>
			<div class="c4"></div>
	
			<!-- 회원정보-->
			<img class="img" src="imgView?file=로고.png" alt="">
			<div class="user-title">회원정보</div>
	
			<div class="name1" style="display: inline">이름</div>
			<div class="name2">${member.member_name }</div>
			
			<div class="nickname1" style="display: inline">닉네임</div>
			<div class="nickname2">${member.nickname }</div>
			
			<div class="email1" style="display: inline">이메일</div>
			<div class="email2">${member.email }</div>
	
	      <!-- 버튼-->
			<c:if test='${member.member_pw ne "kakaoLogin" && member.member_pw ne "naverLogin"}'>
				<p><button id="userRegister">회원정보 수정</button></p>
			</c:if>
	
			<c:choose>
				<c:when test='${member.member_pw eq "kakaoLogin"}'>
					<p><button id="kakaoDeleteLink" href="#" > 카카오 회원탈퇴</button></p>
				</c:when>
				<c:when test='${member.member_pw eq "naverLogin"}'>
					<p><button id="naverDelete"> 네이버 회원탈퇴</button></p>
				</c:when>
				<c:otherwise>
					<p><button id="userDelete"> 회원탈퇴 </button></p>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<br>

	<jsp:include page="footer.jsp" />
</body>
