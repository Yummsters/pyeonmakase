package dao;

import java.util.List;

import bean.Board;
import bean.Board_Store;

public interface BoardDAO {
    void insertBoard(Board board) throws Exception;
    void insertStore_category(Board_Store boardStore) throws Exception;
    List<Board> selectBoardListTop10(Integer row) throws Exception;
}
