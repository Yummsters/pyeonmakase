package service;

import bean.Member;
import dao.MemberDAO;
import dao.MemberDAOImpl;

public class MemberServiceImpl implements MemberService{
	
	private MemberDAO memberDAO;
	
	public MemberServiceImpl() {
		memberDAO = new MemberDAOImpl();
	}

	// 회원가입
	@Override
	public void signup(Member member) throws Exception {
		Member mem = memberDAO.selectId(member.getMember_id());
		if(mem != null) throw new Exception("아이디 중복 오류");
		memberDAO.insertMember(member);
	}

	// 로그인
	@Override
	public Member login(String member_id, String member_pw) throws Exception {
		Member member = memberDAO.selectId(member_id);
		if(member == null) throw new Exception("아이디가 틀렸습니다.");
		if(member.getMember_pw().equals(member_pw) == false) throw new Exception("비밀번호가 틀렸습니다.");
		return member;
	}

	// 닉네임 중복확인
	@Override
	public String isNicknameCheck(String nickname) throws Exception {
		Member member = memberDAO.selectNickname(nickname);
		if(member==null) return "notexist";
		return "exist";
	}

	// 이메일 중복확인
	@Override
	public String isEmailCheck(String email) throws Exception {
		Member member = memberDAO.selectEmail(email);
		if(member==null) return "notexist";
		return "exist";
	}

	// 아이디 중복확인
	@Override
	public String isIdCheck(String member_id) throws Exception {
		Member member = memberDAO.selectId(member_id);
		if(member==null) return "notexist";
		return "exist";
	}
}
