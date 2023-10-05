package dao;

import java.util.List;

import bean.Board;

public interface BoardDAO {
    void insertBoard(Board board) throws Exception;
    List<Board> selectBoardListTop10(Integer row) throws Exception;
}
