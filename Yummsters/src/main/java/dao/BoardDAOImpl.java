package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;

import bean.Board;
import bean.Board_Store;
import bean.Member;
import util.MybatisSqlSessionFactory;

public class BoardDAOImpl implements BoardDAO{
    SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

    // 레시피 게시글 등록
    @Override
    public void insertBoard(Board board) throws Exception {
        sqlSession.insert("mapper.board.insertBoard", board);
        sqlSession.commit();
    }

    // 레시피 게시글과 편의점 카테고리 매핑
    @Override
    public void insertStore_category(Board_Store boardStore) throws Exception {
        sqlSession.insert("mapper.board_store.insertBoard_store", boardStore);
        sqlSession.commit();
    }

    // 게시글 번호로 게시글 정보 가져오기
    @Override
    public Board selectBoardOne(Integer board_id) throws Exception {
        return sqlSession.selectOne("mapper.board.selectBoardOne", board_id);
    }
  // 최신 게시글 목록 조회
    @Override
    public List<Board> selectBoardList() throws Exception {
    	return sqlSession.selectList("mapper.board.selectBoardList");
    }
  // 추천순 Top10 목록 조회
	@Override
	public List<Board> selectBoardListTop10() throws Exception {
		return sqlSession.selectList("mapper.board.selectBoardListTop10");
	}

    // main-list by foodCategory
	@Override
	public List<Board> selectBoardByFood(Integer foodId) throws Exception {
		return sqlSession.selectList("mapper.board.selectBoardByFood", foodId);
	}
  // -----

  // 내가 찜한 게시글 목록 조회
	@Override
	public List<Board> selectWishList(@Param("member") Member member, @Param("row") Integer row) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("member", member);
		map.put("row", row);
		return sqlSession.selectList("mapper.board.selectWishList", map);
	}
  // 내가 작성한 게시글 목록 조회
	@Override
	public List<Board> selectMyList(@Param("member") Member member, @Param("row") Integer row) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("member", member);
		map.put("row", row);
		return sqlSession.selectList("mapper.board.selectMyList", map);
	}
    // 추천할 데이터 저장
    @Override
    public void insertRecommand(Map<String, Object> param) throws Exception {
        sqlSession.selectOne("mapper.recommand.insertRecommand", param);
        sqlSession.commit();
    }

    // 추천한 데이터 삭제
    @Override
    public void deleteRecommand(Map<String, Object> param) throws Exception {
        sqlSession.selectOne("mapper.recommand.deleteRecommand", param);
        sqlSession.commit();
    }

    // 추천한 데이터 조회
    @Override
    public Integer selectRecommand(Map<String, Object> param) throws Exception {
        return sqlSession.selectOne("mapper.recommand.selectRecommand", param);
    }

    // 추천수 + 1
    @Override
    public void plusRecommandCount(Integer board_id) throws Exception {
        sqlSession.update("mapper.board.plusRecommandCount", board_id);
        sqlSession.commit();
    }

    // 추천수 - 1
    @Override
    public void minusRecommandCount(Integer board_id) throws Exception {
        sqlSession.update("mapper.board.minusRecommandCount", board_id);
        sqlSession.commit();
    }

    // 추천수 조회
    @Override
    public Integer selectRecommandCount(Integer board_id) throws Exception {
        return sqlSession.selectOne("mapper.board.selectRecommandCount", board_id);
    }
}
