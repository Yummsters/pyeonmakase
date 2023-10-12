package dao;

import java.util.Map;

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
	
	//회원탈퇴
		void deleteMember(Map<String, Object> paramMap) throws Exception;
	//탈퇴할정보들을 nickname으로 부름
		void removeRelatedData(String nickname) throws Exception;
		void removeRelatedDataBoard(String nickname) throws Exception;
		void removeRelatedDataBoard2(String nickname) throws Exception;
		void removeRelatedDataRecommand(String nickname) throws Exception;
		void removeRelatedDataReply(String nickname) throws Exception;
		void removeRelatedDataWish(String nickname) throws Exception;
	//회원정보 수정	
	    void updateMember(Map<String, Object> paramMap) throws Exception;
	    
}
