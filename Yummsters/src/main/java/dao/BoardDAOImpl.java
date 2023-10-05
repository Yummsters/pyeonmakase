package dao;

import bean.Board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

public class BoardDAOImpl implements BoardDAO{
    SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    @Override
    public void insertBoard(Board board) throws Exception {
        sqlSession.insert("mapper.board.insertBoard", board);
        sqlSession.commit();
    }

	@Override
	public List<Board> selectBoardListTop10(Integer row) throws Exception {
		return sqlSession.selectList("mapper.board.selectBoardListTop10",row);
	}
}
