package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import bean.Board;
import bean.Board_Store;
import bean.Member;

public interface BoardDAO {
    void insertBoard(Board board) throws Exception;
    void insertStore_category(Board_Store boardStore) throws Exception;
    Board selectBoardOne(Integer board_id) throws Exception;
    List<Board> selectBoardList(Integer row) throws Exception;
    List<Board> selectBoardListTop10() throws Exception;
    List<Board> selectWishList(@Param("member") Member member, @Param("row") Integer row) throws Exception;
    List<Board> selectMyList(@Param("member") Member member, @Param("row") Integer row) throws Exception;
}
