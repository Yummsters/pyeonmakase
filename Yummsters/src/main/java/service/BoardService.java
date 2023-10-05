package service;

import bean.Board;
import bean.Board_Store;

public interface BoardService {
    void boardRegister(Board board) throws Exception;
    void board_store(Board_Store boardStore) throws Exception;
}
