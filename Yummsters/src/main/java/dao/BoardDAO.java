package dao;

import java.util.List;

import bean.Board;
import bean.Board_Store;

public interface BoardDAO {
    void insertBoard(Board board) throws Exception;
    void insertStore_category(Board_Store boardStore) throws Exception;
    Board selectBoardOne(Integer board_id) throws Exception;
    List<Board> selectBoardList(Integer row) throws Exception;
    List<Board> selectBoardListTop10() throws Exception;
    
    // 선진 작성 부분---
    // main_list
    List<Board> selectBoardList() throws Exception;
    // main_list by foodCategory
    List<Board> selectBoardByFood(Integer foodId) throws Exception;
}
