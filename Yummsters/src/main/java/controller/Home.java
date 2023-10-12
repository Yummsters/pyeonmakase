package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import bean.Board;
import service.BoardService;
import service.BoardServiceImpl;

/**
 * Servlet implementation class Home
 */
@WebServlet("/")
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Home() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
		String[] storeNameParam = request.getParameterValues("storeNames[]"); 
        List<String> storeNames = new ArrayList<>();
        
        if (storeNameParam != null) {
            storeNames = Arrays.asList(storeNameParam);
        } else {
        	System.out.println("기본값-store전체선택");
        }
		try {
			BoardService boardService = new BoardServiceImpl();
			List<Board> boardListTop10 = boardService.boardListTop10();
			request.setAttribute("boardListTop10", boardListTop10);
			
			List<Board> boardList = boardService.boardAllList(storeNames);
			request.setAttribute("boardList", boardList);
			request.getRequestDispatcher("home.jsp").forward(request, response);			
		} catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", e.getMessage());
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
