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
 * Servlet implementation class MyList
 */
@WebServlet("/mylist")
public class MyList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyList() {
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
			 // 로그인한 사용자가 없으면 로그인 페이지로 이동
	        if (member == null) {
	            response.sendRedirect("login.jsp"); // 로그인 페이지로 이동
	            return; // 더 이상 진행하지 않도록 메서드 종료
	        }
			
			BoardService boardService = new BoardServiceImpl();
			List<Board> myList = boardService.myList(member, 12);
			request.setAttribute("myList", myList);
			request.getRequestDispatcher("mylist.jsp").forward(request, response);			
		} catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", e.getMessage());
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}

	}

}
