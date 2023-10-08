package dao;

import bean.Board;

import java.util.List;

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
    public List<Board> selectBoardList(Integer row) throws Exception {
    	return sqlSession.selectList("mapper.board.selectBoardList", row);
    }
    
	@Override
	public List<Board> selectBoardListTop10() throws Exception {
		return sqlSession.selectList("mapper.board.selectBoardListTop10");
	}
}
