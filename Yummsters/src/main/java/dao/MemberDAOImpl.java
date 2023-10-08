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
	
	// 아이디 중복확인 및 로그인을 위한 selectMember
	@Override
	public Member selectId(String member_id) throws Exception {
		return sqlSession.selectOne("mapper.member.selectId", member_id);	
	}

	@Override
	public Member selectNickname(String nickname) throws Exception {
		return sqlSession.selectOne("mapper.member.selectNickname", nickname);
	}

	@Override
	public Member selectEmail(String email) throws Exception {
		return sqlSession.selectOne("mapper.member.selectEmail", email);
	}
}
