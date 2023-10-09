package dao;

import java.util.List;
import java.util.Map;

import bean.Board;
import bean.Board_Store;

public interface BoardDAO {

    void insertBoard(Board board) throws Exception; // 게시글 저장

    void insertStore_category(Board_Store boardStore) throws Exception; // 카테고리 선택

    Board selectBoardOne(Integer board_id) throws Exception; // 게시글 한개 조회

    List<Board> selectBoardListTop10(Integer row) throws Exception;
    List<Board> selectBoardListTop10() throws Exception;

    void insertRecommand(Map<String, Object> param) throws Exception; // 추천 데이터 저장

    void deleteRecommand(Map<String, Object> param) throws Exception; // 추천 데이터 삭제

    Integer selectRecommand(Map<String, Object> param) throws Exception; // 로그인 멤버에 대한 추천 여부 확인

    void plusRecommandCount(Integer board_id) throws Exception; // 추천수 +1

    void minusRecommandCount(Integer board_id) throws Exception; // 추천수 -1

    Integer selectRecommandCount(Integer board_id) throws Exception; // 추천수 조회
}
