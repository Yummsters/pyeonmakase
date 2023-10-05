package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import bean.Board;
import util.MybatisSqlSessionFactory;

public class BoardDaoImpl implements BoardDao {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public List<Board> selectBoardListTop10(Integer row) throws Exception {
		return sqlSession.selectList("mapper.board.selectBoardListTop10",row);
	}
}
