package dao;

import java.util.List;
import java.util.Map;

import bean.Wish;
import org.apache.ibatis.annotations.Param;

import bean.Board;
import bean.Board_Store;
import bean.Member;

public interface BoardDAO {
    
    // main_list by foodCategory
//    List<Board> selectBoardByFood(Integer foodId) throws Exception; // food 카테고리 sj

    void insertBoard(Board board) throws Exception; // 게시글 저장

    void insertStore_category(Board_Store boardStore) throws Exception; // 카테고리 선택

    Board selectBoardOne(Integer board_id) throws Exception; // 게시글 한개 조회

    List<Board> selectBoardList(List<String> storeNames) throws Exception; // 게시글 최신순 조회 sj
  
    List<Board> selectBoardListTop10() throws Exception; // 게시글 추천순 Top10 조회
  
    List<Board> selectWishList(@Param("member") Member member, @Param("row") Integer row) throws Exception; // 마이페이지에서 더보기 눌러서 찜한 목록 조회
  
    List<Board> selectMyList(@Param("member") Member member, @Param("row") Integer row) throws Exception; // 마이페이지에서 더보기 눌러서 내가 작성한 게시글 목록 조회

    void insertRecommand(Map<String, Object> param) throws Exception; // 추천 데이터 저장

    void deleteRecommand(Map<String, Object> param) throws Exception; // 추천 데이터 삭제

    Integer selectRecommand(Map<String, Object> param) throws Exception; // 로그인 멤버에 대한 추천 여부 확인

    void plusRecommandCount(Integer board_id) throws Exception; // 추천수 +1

    void minusRecommandCount(Integer board_id) throws Exception; // 추천수 -1

    Integer selectRecommandCount(Integer board_id) throws Exception; // 추천수 조회

    void insertWish(Map<String, Object> param) throws Exception; // 찜 데이터 저장

    void deleteWish(Map<String, Object> param) throws Exception; // 찜 데이터 삭제

   Integer selectWish(Map<String, Object> param) throws Exception; // 로그인 멤버에 대한 찜 여부 확인

    List<Board> selectBoardCategoryList(Integer board_id) throws Exception; // 편의점 카테고리 리스트 가져오기

    void deleteWishBoard(Integer board_id) throws Exception; // 게시글을 참조하는 모든 wish 삭제

    void deleteRecommandBoard(Integer board_id) throws Exception; // 게시글을 참조하는 모든 recommand 삭제

    void deleteBoard_store(Integer board_id) throws Exception; // 게시글을 참조하는 모든 board_store 삭제

    void deleteBoardOne(Integer board_id) throws Exception; // 게시글 삭제

    List<Board> searchByKeyword(String keyword, List<String> storeNames) throws Exception; // 키워드 검색 sj
    
    List<Board> selectBoardByCate(Integer foodId, List<String> storeNames); // 카테고리별 리스트 sj
}
