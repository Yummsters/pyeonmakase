package service;

import java.util.List;

import bean.Board;
import bean.Board_Store;
import bean.Member;
import dao.BoardDAO;
import dao.BoardDAOImpl;
import org.json.simple.JSONObject;

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
            response.put("select", true);
        }else{
            // Recommand가 존재한다면
            // 테이블에서 추천 삭제
            boardDao.deleteRecommand(map);
            // 추천 수 -1
            boardDao.minusRecommandCount(board_id);
            // response에 값 넣기
            response.put("select", false);
        }

        // 좋아요 수 response에 넣기
        Integer recommandCount = boardDao.selectRecommandCount(board_id);
        System.out.println(recommandCount);
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
    
    // 최신순으로 row개의 게시글 조회
    @Override
    public List<Board> boardList(Integer row) throws Exception {
    	List<Board> boardList = boardDao.selectBoardList(row);
		return boardList;
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
	public List<Board> boardAllList() throws Exception {
		return boardDao.selectBoardList();
	}
    // main-list by food
	@Override
	public List<Board> boardListByFood(Integer foodId) throws Exception {
		return boardDao.selectBoardByFood(foodId);
	}
}


