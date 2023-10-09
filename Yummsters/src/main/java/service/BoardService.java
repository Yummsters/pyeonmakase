package service;

import java.util.List;
import java.util.Map;

import bean.Board;
import bean.Board_Store;
import bean.Member;

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
    // ---
  
    List<Board> boardList(Integer row) throws Exception; // 최신 게시글 조회
  
    List<Board> boardListTop10() throws Exception; // 추천순 Top10 게시글 조회
  
    List<Board> wishList(Member member, Integer row) throws Exception; // 찜한 게시글 조회
  
    List<Board> myList(Member member, Integer row) throws Exception; // 내가 작성한 게시글 조회
  
    void boardRegister(Board board) throws Exception; // 게시글 등록

    void board_store(Board_Store boardStore) throws Exception; // 편의점 카테고리 등록

    Board boardDetail(Integer board_id) throws Exception; // 게시글 한 개 조회

    String boardRecommand(String nickname, Integer board_id) throws Exception; // 추천하기 기능 구현 메서드

    Boolean isboardRecommand(String nickname, Integer board_id) throws Exception; // 추천 여부 조회 메서드
}
