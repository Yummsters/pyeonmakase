package service;

import java.util.Map;

import bean.Board;
import bean.Board_Store;

public interface BoardService {
    void boardRegister(Board board) throws Exception; // 게시글 등록

    void board_store(Board_Store boardStore) throws Exception; // 편의점 카테고리 등록

    Board boardDetail(Integer board_id) throws Exception; // 게시글 한 개 조회
  
    Map<String,Object> boardList(Integer row) throws Exception;
    Map<String,Object> boardListTop10() throws Exception;

    String boardRecommand(String nickname, Integer board_id) throws Exception; // 추천하기 기능 구현 메서드

    Boolean isboardRecommand(String nickname, Integer board_id) throws Exception; // 추천 여부 조회 메서드
}
