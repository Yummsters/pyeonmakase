package dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import bean.Member;
import util.MybatisSqlSessionFactory;

public class MemberDAOImpl implements MemberDAO {

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

	 // 회원탈퇴
	   @Override
	   public void deleteMember(Map<String, Object> paramMap) throws Exception {
	      sqlSession.delete("mapper.member.deleteMember", paramMap); // member 삭제
	      sqlSession.commit();
	   }

	   // 탈퇴할때 삭제할것들
	   @Override
	   public void updateBoardNickname(String nickname) throws Exception {
	      sqlSession.update("mapper.member.updateBoardNickname", nickname); // board의 닉네임 변경
	      sqlSession.commit();
	   }

	   @Override
	   public void updateRecommandNickname(String nickname) throws Exception {
	      sqlSession.update("mapper.member.updateRecommandNickname", nickname); // Recommand의 닉네임 변경
	      sqlSession.commit();
	   }

	   @Override
	   public void updateReplyNickname(String nickname) throws Exception {
	      sqlSession.update("mapper.member.updateReplyNickname", nickname); // Reply의 닉네임 변경
	      sqlSession.commit();
	   }

	   @Override
	   public void deleteWish(String nickname) throws Exception {
	      sqlSession.delete("mapper.member.deleteWish", nickname); // wish 삭제
	      sqlSession.commit();
	   }

	
	// 회원정보수정
	@Override
	public void updateMember(Map<String, Object> paramMap) throws Exception {
		sqlSession.update("mapper.member.updateMember", paramMap);
		sqlSession.commit();
	}
}
