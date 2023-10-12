package dao;

import java.util.Map;

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
	//회원탈퇴
	@Override
	public void deleteMember(Map<String, Object> paramMap) throws Exception {
	    sqlSession.delete("mapper.member.deleteMember", paramMap);
	    sqlSession.commit();
	}
	//탈퇴할때 삭제할것들
	 @Override
	    public void removeRelatedData(String nickname) throws Exception {
	        removeRelatedDataBoard(nickname);
	        removeRelatedDataBoard2(nickname);
	        removeRelatedDataRecommand(nickname);
	        removeRelatedDataReply(nickname);
	        removeRelatedDataWish(nickname);
	    }

	    @Override
	    public void removeRelatedDataBoard(String nickname) throws Exception {
	        sqlSession.delete("mapper.member.removeRelatedDataBoard", nickname);
	        sqlSession.commit();
	    }
	    
	    @Override
	    public void removeRelatedDataBoard2(String nickname) throws Exception {
	        sqlSession.delete("mapper.member.removeRelatedDataBoard2", nickname);
	        sqlSession.commit();
	    }
	    @Override
	    public void removeRelatedDataRecommand(String nickname) throws Exception {
	        sqlSession.delete("mapper.member.removeRelatedDataRecommand", nickname);
	        sqlSession.commit();
	    }

	    @Override
	    public void removeRelatedDataReply(String nickname) throws Exception {
	        sqlSession.delete("mapper.member.removeRelatedDataReply", nickname);
	        sqlSession.commit();
	    }

	    @Override
	    public void removeRelatedDataWish(String nickname) throws Exception {
	        sqlSession.delete("mapper.member.removeRelatedDataWish", nickname);
	        sqlSession.commit();
	    }
	
	//회원정보수정
	@Override
	public void updateMember(Map<String, Object> paramMap) throws Exception {
		 sqlSession.update("mapper.member.updateMember", paramMap);
		    sqlSession.commit();
	}
}
