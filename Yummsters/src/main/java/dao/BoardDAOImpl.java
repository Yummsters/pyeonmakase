package dao;

import bean.Board;

import java.util.List;
import java.util.Map;

import bean.Board_Store;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

public class BoardDAOImpl implements BoardDAO{
    SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    // 레시피 게시글 등록
    @Override
    public void insertBoard(Board board) throws Exception {
        sqlSession.insert("mapper.board.insertBoard", board);
        sqlSession.commit();
    }

    // 레시피 게시글과 편의점 카테고리 매핑
    @Override
    public void insertStore_category(Board_Store boardStore) throws Exception {
        sqlSession.insert("mapper.board_store.insertBoard_store", boardStore);
        sqlSession.commit();
    }

    // 게시글 번호로 게시글 정보 가져오기
    @Override
    public Board selectBoardOne(Integer board_id) throws Exception {
        return sqlSession.selectOne("mapper.board.selectBoardOne", board_id);
    }

    @Override
	public List<Board> selectBoardListTop10(Integer row) throws Exception {
		return sqlSession.selectList("mapper.board.selectBoardListTop10",row);
	}

    // 추천할 데이터 저장
    @Override
    public void insertRecommand(Map<String, Object> param) throws Exception {
        sqlSession.selectOne("mapper.recommand.insertRecommand", param);
        sqlSession.commit();
    }

    // 추천한 데이터 삭제
    @Override
    public void deleteRecommand(Map<String, Object> param) throws Exception {
        sqlSession.selectOne("mapper.recommand.deleteRecommand", param);
        sqlSession.commit();
    }

    // 추천한 데이터 조회
    @Override
    public Integer selectRecommand(Map<String, Object> param) throws Exception {
        return sqlSession.selectOne("mapper.recommand.selectRecommand", param);
    }

    // 추천수 + 1
    @Override
    public void plusRecommandCount(Integer board_id) throws Exception {
        sqlSession.update("mapper.board.plusRecommandCount", board_id);
        sqlSession.commit();
    }

    // 추천수 - 1
    @Override
    public void minusRecommandCount(Integer board_id) throws Exception {
        sqlSession.update("mapper.board.minusRecommandCount", board_id);
        sqlSession.commit();
    }

    // 추천수 조회
    @Override
    public Integer selectRecommandCount(Integer board_id) throws Exception {
        return sqlSession.selectOne("mapper.board.selectRecommandCount", board_id);
    }
}
