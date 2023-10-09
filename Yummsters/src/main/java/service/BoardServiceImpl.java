package service;

import java.util.List;

import bean.Board;
import bean.Board_Store;
import bean.Member;
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
}


