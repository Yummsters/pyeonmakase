package service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import bean.Board;
import bean.Board_Store;
import bean.Member;
import bean.Reply;

public interface BoardService {    
    // 선진 작성 부분
    // main-list
	List<Board> boardAllList(List<String> storeNames) throws Exception;
    // main_list by foodCategory
//	 List<Board> boardListByFood(Integer foodId) throws Exception;
    
    List<Board> boardListTop10() throws Exception; // 추천순 Top10 게시글 조회
  
    List<Board> wishList(Member member, Integer row) throws Exception; // 찜한 게시글 조회
  
    List<Board> myList(Member member, Integer row) throws Exception; // 내가 작성한 게시글 조회
  
    void boardRegister(Board board) throws Exception; // 게시글 등록

    void board_store(Board_Store boardStore) throws Exception; // 편의점 카테고리 등록

    Board boardDetail(Integer board_id) throws Exception; // 게시글 한 개 조회

    Map<String, Object> boardRecommand(String nickname, Integer board_id) throws Exception; // 추천하기 기능 구현 메서드

    Boolean isboardRecommand(String nickname, Integer board_id) throws Exception; // 추천 여부 조회 메서드

    Map<String, Object> boardWish(String nickname, Integer board_id) throws Exception; // 찜하기 기능 구현 메서드

    boolean isboardWish(String nickname, Integer board_id) throws Exception; // 찜 여부 조회 메서드

    List<Board> boardStoreCategoryList(Integer board_id) throws Exception; // 게시글의 편의점 카테고리 조회

    List<Board> boardSearch(String keyword, List<String> storeNames) throws Exception; // 키워드 검색
 	
 	List<Board> boardListByCate(Integer foodId, List<String> storeNames); // 카테고리별 리스트

    Map<String, Object> replyRegisterAndList(Reply reply) throws Exception; // 댓글 등록 및 모든 댓글 조회

    List<Reply> selectReplyList(@Param("board_id") Integer board_id, @Param("curPage") Integer curPage) throws Exception; // 게시글에 해당하는 댓글 출력

    String deleteReply(Integer reply_id) throws Exception; // 댓글 삭제

    void deleteBoardAll(Integer board_id) throws Exception; // 게시글 삭제를 위한 모든 참조 삭제

    void modifyBoard(Board board, Integer board_id) throws Exception; // 게시글 수정 및 편의점 카테고리 삭성

    Integer selectReplyCount(Integer board_id) throws Exception; // 댓글 개수 count

    Reply selectReply(Integer reply_id) throws Exception; // 댓글 하나 조회

}
