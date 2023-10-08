package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.Board;
import bean.Board_Store;
import dao.BoardDAO;
import dao.BoardDAOImpl;

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
    
    // home에서 최신순으로 5개의 게시글 조회
    @Override
    public Map<String, Object> boardList(Integer row) throws Exception {
    	List<Board> boardList = boardDao.selectBoardList(5);
		Map<String,Object> map = new HashMap<>();
		map.put("boardList", boardList);
		return map;
    }

    // home에서 추천 Top10 게시글 조회
	@Override
	public Map<String, Object> boardListTop10() throws Exception {
		List<Board> boardListTop10 = boardDao.selectBoardListTop10();
		Map<String,Object> map = new HashMap<>();
		map.put("boardListTop10", boardListTop10);
		return map;
	}
}


