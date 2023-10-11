package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Board;
import bean.Member;
import service.BoardService;
import service.BoardServiceImpl;

/**
 * Servlet implementation class MyPage
 */
@WebServlet("/mypage")
public class MyPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyPage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("member");
			
			BoardService boardService = new BoardServiceImpl();
			List<Board> myList = boardService.myList(member, 3);
			List<Board> wishList = boardService.wishList(member, 3);
			request.setAttribute("myList", myList);
			request.setAttribute("wishList", wishList);
			request.getRequestDispatcher("mypage.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", e.getMessage());
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
