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
		Member mem = memberDAO.selectMember(member.getMember_id());
		if(mem != null) throw new Exception("아이디 중복 오류");
		memberDAO.insertMember(member);
	}

	// 로그인
	@Override
	public Member login(String member_id, String member_pw) throws Exception {
		Member member = memberDAO.selectMember(member_id);
		if(member == null) throw new Exception("아이디가 틀렸습니다.");
		if(member.getMember_pw().equals(member_pw) == false) throw new Exception("비밀번호가 틀렸습니다.");
		return member;
	}

	// 회원가입 닉네임 중복확인
	@Override
	public boolean isNicknameDuplicate(String nickname) throws Exception {
        int count = memberDAO.countNickname(nickname);
        return count > 0;
	}

	// 회원가입 이메일 중복확인
	@Override
	public boolean isEmailDuplicate(String email) throws Exception {
        int count = memberDAO.countEmail(email);
        return count > 0;
	}

	// 회원가입 아이디 중복확인
	@Override
	public boolean isIdDuplicate(String member_id) throws Exception {
        int count = memberDAO.countId(member_id);
        return count > 0;

	}
}
