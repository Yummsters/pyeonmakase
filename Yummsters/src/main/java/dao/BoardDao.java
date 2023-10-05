package dao;

import java.util.List;

import bean.Board;

public interface BoardDao {
	List<Board> selectBoardListTop10(Integer row) throws Exception;
}
