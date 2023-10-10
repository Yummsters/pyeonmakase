package controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Board;
import service.BoardService;
import service.BoardServiceImpl;

/**
 * Servlet implementation class BoardSearch
 */
@WebServlet("/search")
public class Board_search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Board_search() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String keyword = request.getParameter("keyword");
		
		try {
			BoardService service = new BoardServiceImpl();
			List<Board> boardList = service.boardSearch(keyword);
			request.setAttribute("boardList", boardList);
			request.getRequestDispatcher("main_list.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
