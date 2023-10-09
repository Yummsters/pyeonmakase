package service;

import java.util.List;

import bean.Board;
import bean.Board_Store;
import bean.Member;

public interface BoardService {
    void boardRegister(Board board) throws Exception;
    void board_store(Board_Store boardStore) throws Exception;
    Board boardDetail(Integer board_id) throws Exception;
    List<Board> boardList(Integer row) throws Exception;
    List<Board> boardListTop10() throws Exception;
    List<Board> wishList(Member member, Integer row) throws Exception;
    List<Board> myList(Member member, Integer row) throws Exception;
}
