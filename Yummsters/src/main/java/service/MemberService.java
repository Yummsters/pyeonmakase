package service;

import java.util.Map;

import bean.Member;

public interface MemberService {

	// 회원가입
	void signup(Member member) throws Exception;
	
	// 로그인
	Member login(String member_id, String member_pw) throws Exception;
	
	// 닉네임 중복확인
	String isNicknameCheck(String nickname) throws Exception;
	
	// 이메일 중복확인
	String isEmailCheck(String email) throws Exception;
	
	// 아이디 중복확인
	String isIdCheck(String member_id) throws Exception;
	

	   //회원탈퇴
	   void removeMember(Map<String, Object> paramMap) throws Exception;
	   
	    //탈퇴 전 nickname 변경
	   void updateNickname(String nickname) throws Exception;
	   
	   //탈퇴 전 찜 삭제
	   void removeWish(String nickname) throws Exception;

	   

	//회원정보수정
		void updateMember(Map<String, Object> paramMap) throws Exception;
	
}
