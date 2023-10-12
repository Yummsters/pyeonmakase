package service;

import java.util.List;

import bean.*;
import dao.BoardDAO;
import dao.BoardDAOImpl;
import org.json.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

public class BoardServiceImpl implements BoardService{
    private BoardDAO boardDao;

    public BoardServiceImpl(){
        boardDao = new BoardDAOImpl();
    }

    // 레시피 게시글 등록
    @Override
    public void boardRegister(Board board) throws Exception {
        boardDao.insertBoard(board);
    }

    // 레시피 게시글과 편의점 카테고리 매핑
    @Override
    public void board_store(Board_Store boardStore) throws Exception {
        boardDao.insertStore_category(boardStore);
    }

    // 게시글 번호로 게시글 정보 조회
    @Override
    public Board boardDetail(Integer board_id) throws Exception {
        return boardDao.selectBoardOne(board_id);
    }

    // 추천하기 기능 구현
    @Override
    public String boardRecommand(String nickname, Integer board_id) throws Exception {
        // Recommand 존재 여부 확인
        Map<String, Object> map = new HashMap<>();
        map.put("nickname", nickname);
        map.put("board_id", board_id);
        Integer recommand_id = boardDao.selectRecommand(map);

        Map<String, Object> response = new HashMap<>();

        // Recommand가 존재하지 않는다면
        if(recommand_id == null){
            // 테이블에 추천 저장
            boardDao.insertRecommand(map);
            // 추천 수  + 1
            boardDao.plusRecommandCount(board_id);
            // response 값 넣기
            response.put("recommand_select", true);
        }else{
            // Recommand가 존재한다면
            // 테이블에서 추천 삭제
            boardDao.deleteRecommand(map);
            // 추천 수 -1
            boardDao.minusRecommandCount(board_id);
            // response에 값 넣기
            response.put("recommand_select", false);
        }

        // 좋아요 수 response에 넣기
        Integer recommandCount = boardDao.selectRecommandCount(board_id);
        response.put("recommandCount", recommandCount);

        // JSON 형식으로 응답 변경
        JSONObject jsonObject = new JSONObject(response);
        return jsonObject.toJSONString();
    }

    // 추천 여부 조회
    @Override
    public Boolean isboardRecommand(String nickname, Integer board_id) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("nickname", nickname);
        map.put("board_id", board_id);

        // 추천을 누른 정보 조회
        if(boardDao.selectRecommand(map) == null) return false;
        return true;
    }

    // 찜하기 기능 구현
    @Override
    public String boardWish(String nickname, Integer board_id) throws Exception {
        // Wish 존재 여부 확인
        Map<String, Object> map = new HashMap<>();
        map.put("nickname", nickname);
        map.put("board_id", board_id);
        System.out.println("BoardServiceImpl nickname : " + nickname);
        System.out.println("BoardServiceImpl board_id : " + board_id);
        Integer wish_id = boardDao.selectWish(map);
        System.out.println("BoardServiceImpl wish_id : " + wish_id);

        Map<String, Object> response = new HashMap<>();

        // Wish가 존재하지 않는다면
        if(wish_id == null){
            // 테이블에 찜 저장
            boardDao.insertWish(map);
            System.out.println(map);
            // response 값 넣기
            response.put("wish_select", true);
        }else{
            // Wish가 존재한다면
            boardDao.deleteWish(map);
            // response에 값 넣기
            response.put("wish_select", false);
        }
        System.out.println("BoardServiceImpl wish_select : " + response.get("wish_select"));

        // JSON 형식으로 응답 변경
        JSONObject jsonObject = new JSONObject(response);
        return jsonObject.toJSONString();
    }

    // 찜 여부 조회
    @Override
    public boolean isboardWish(String nickname, Integer board_id) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("nickname", nickname);
        map.put("board_id", board_id);

        // 추천을 누른 정보 조회
        return boardDao.selectWish(map) != null;
    }

    @Override
    public List<Board> boardStoreCategoryList(Integer board_id) throws Exception {
        return boardDao.selectBoardCategoryList(board_id);
    }

    // 게시글 삭제를 위해 게시글을 참조하는 모든 행 삭제
    @Override
    public void deleteBoardAll(Integer board_id) throws Exception {
        boardDao.deleteWishBoard(board_id);
        boardDao.deleteRecommandBoard(board_id);
        boardDao.deleteBoard_store(board_id);
        boardDao.deleteBoardOne(board_id);
    }

    // 댓글 등록 및 조회
    @Override
    public String replyRegisterAndList(Reply reply) throws Exception {
        Map<String, Object> response = new HashMap<>();
        Integer board_id = reply.getBoard_id();

        // 댓글 저장
        try{
            boardDao.insertReply(reply);
            response.put("register", true);
        }catch (Exception e){
            response.put("register", false);
        }

        // 댓글 조회
        List<Reply> replyList = boardDao.selectReplyList(board_id);
        JSONArray jsonArray = new JSONArray(replyList);
        response.put("replyList", jsonArray);

        // JSON 형식으로 응답 변경
        JSONObject jsonObject = new JSONObject(response);
        return jsonObject.toJSONString();
    }

    // 게시글에 따른 댓글 조회
    @Override
    public String selectReplyList(Integer board_id) throws Exception {
        // 댓글 조회
        Map<String, Object> response = new HashMap<>();
        List<Reply> replyList = boardDao.selectReplyList(board_id);
        JSONArray jsonArray = new JSONArray(replyList);
        response.put("replyList", jsonArray);

        // JSON 형식으로 응답 변경
        JSONObject jsonObject = new JSONObject(response);
        return jsonObject.toJSONString();
    }

    // 댓글 삭제
    @Override
    public String deleteReply(Integer reply_id) throws Exception {
        Map<String, Object> response = new HashMap<>();
        Reply reply = boardDao.selectReply(reply_id);

        try{
            boardDao.deleteReply(reply_id);
            response.put("delete", true);
        }catch (Exception e){
            response.put("delete", false);
        }

        // 댓글 조회
        List<Reply> replyList = boardDao.selectReplyList(reply.getBoard_id());
        JSONArray jsonArray = new JSONArray(replyList);
        response.put("replyList", jsonArray);

        // JSON 형식으로 응답 변경
        JSONObject jsonObject = new JSONObject(response);
        return jsonObject.toJSONString();
    }

    // home에서 추천 Top10 게시글 조회
	@Override
	public List<Board> boardListTop10() throws Exception {
		List<Board> boardListTop10 = boardDao.selectBoardListTop10();
		return boardListTop10;
	}

	@Override
	public List<Board> wishList(Member member, Integer row) throws Exception {
		List<Board> wishList = boardDao.selectWishList(member, row);
		return wishList;
	}

	@Override
	public List<Board> myList(Member member, Integer row) throws Exception {
		List<Board> myList = boardDao.selectMyList(member, row);
		return myList;
	}
	
    // 선진 작성 부분 
    // main-list
	@Override
	public List<Board> boardAllList(List<String> storeNames) throws Exception {
		return boardDao.selectBoardList(storeNames);
	}
    // main-list by food
//	@Override
//	public List<Board> boardListByFood(Integer foodId) throws Exception {
//		return boardDao.selectBoardByFood(foodId);
//	}
	
	// 키워드 검색
	@Override
	public List<Board> boardSearch(String keyword , List<String> storeNames) throws Exception {
		return boardDao.searchByKeyword(keyword, storeNames);
	}
	
	// food, store 카테고리별 리스트
	@Override
	public List<Board> boardListByCate(Integer foodId, List<String> storeNames) {
		return boardDao.selectBoardByCate(foodId, storeNames);
	}
}


