package service;

import java.util.List;
import java.util.Map;

import bean.Board;
import bean.Board_Store;

public interface BoardService {
    void boardRegister(Board board) throws Exception;
    void board_store(Board_Store boardStore) throws Exception;
    Board boardDetail(Integer board_id) throws Exception;
    Map<String,Object> boardList(Integer row) throws Exception;
    Map<String,Object> boardListTop10() throws Exception;
    
    // 선진 작성 부분
    // main-list
    List<Board> boardAllList() throws Exception;
    // main_list by foodCategory
	List<Board> boardListByFood(Integer foodId) throws Exception;
}
