package service;

import bean.Member;

public interface MemberService {

	// 회원가입
	void signup(Member member) throws Exception;
	
	// 로그인
	Member login(String member_id, String member_pw) throws Exception;
	
	// 닉네임 중복확인
	boolean isNicknameDuplicate(String nickname) throws Exception;
	
	// 이메일 중복확인
	boolean isEmailDuplicate(String email) throws Exception;
	
	// 아이디 중복확인
	boolean isIdDuplicate(String member_id) throws Exception;
	
	//회원 탈퇴
	void memberRemove(Integer member_pw) throws Exception;
}
