package dao;

import bean.Member;

public interface MemberDAO {
	// 회원가입
	void insertMember(Member member) throws Exception;

	// 회원가입 아이디 중복확인 및 로그인
	Member selectId(String member_id) throws Exception;
	
	// 회원가입 닉네임 중복확인
	Member selectNickname(String nickname) throws Exception;
	
	// 회원가입 이메일 중복확인
	Member selectEmail(String email) throws Exception;
}
