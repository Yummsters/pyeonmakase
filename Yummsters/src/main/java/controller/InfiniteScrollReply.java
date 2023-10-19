package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardService;
import service.BoardServiceImpl;

import bean.Reply;

/**
 * Servlet implementation class InfiniteScrollReply
 */
@WebServlet("/infinitescrollreply")
public class InfiniteScrollReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InfiniteScrollReply() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 게시글 가져오기
        Integer board_id = Integer.parseInt(request.getParameter("board_id"));
        //페이지 번호 초기값 설정
		Integer curPage = 1;
		try {
			//만약 넘어온 페이지 번호가 null 값이 아니라면
			if(request.getParameter("curPage")!=null) {
				//받아온 값을 curPage에 저장
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			// 입력한 댓글 정보 저장 및 조회 정보 가져오기
            BoardService boardService = new BoardServiceImpl();
            // 댓글 목록 조회
            List<Reply> replyList = boardService.selectReplyList(board_id, curPage);
			//댓글 개수를 조회
//			int count = boardService.selectReplyCount(board_id);
			request.setAttribute("replyList", replyList);
			
			//포워딩 페이지
			request.getRequestDispatcher("/reply.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
            request.setAttribute("err", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
		}		
	}
}
