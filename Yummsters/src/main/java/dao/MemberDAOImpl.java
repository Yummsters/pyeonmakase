package dao;

import org.apache.ibatis.session.SqlSession;

import bean.Member;
import util.MybatisSqlSessionFactory;

public class MemberDAOImpl implements MemberDAO{
	
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();


	// 회원가입을 위한 insertMember
	@Override
	public void insertMember(Member member) throws Exception {
		sqlSession.insert("mapper.member.insertMember", member);
		sqlSession.commit();
	}

	// 회원가입 이메일 중복확인
	@Override
	public int countNickname(String nickname) throws Exception {
		return sqlSession.selectOne("mapper.member.countNickname", nickname);
	}

	// 회원가입 이메일 중복확인
	@Override
	public int countEmail(String email) throws Exception {
		return sqlSession.selectOne("mapper.member.countEmail", email);
	}

	// 회원가입 아이디 중복확인
	@Override
	public int countId(String member_id) throws Exception {
		return sqlSession.selectOne("mapper.member.countId", member_id);
	}
	
	// 로그인을 위한 selectMember
	@Override
	public Member selectMember(String member_id) throws Exception {
		return sqlSession.selectOne("mapper.member.selectMember", member_id);	
	}
	
	//회원 탈퇴
	@Override
	public void deleteMember(Integer member_pw) throws Exception {
		sqlSession.delete("mapper.member.deleteMember", member_pw);
		sqlSession.commit();
		
	}
}
