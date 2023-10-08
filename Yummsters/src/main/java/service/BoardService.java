package service;

import java.util.Map;

import bean.Board;
import bean.Board_Store;

public interface BoardService {
    void boardRegister(Board board) throws Exception;
    void board_store(Board_Store boardStore) throws Exception;
    Board boardDetail(Integer board_id) throws Exception;
    Map<String,Object> boardList(Integer row) throws Exception;
    Map<String,Object> boardListTop10() throws Exception;
    Map<String,Object> wishList(Integer row) throws Exception;
    Map<String,Object> myList(Integer row) throws Exception;
}
