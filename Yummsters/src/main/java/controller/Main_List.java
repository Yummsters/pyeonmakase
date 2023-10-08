package controller;

import java.io.IOException;
import java.util.ArrayList;
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
 * Servlet implementation class Main_List
 */
@WebServlet("/mainlist")
public class Main_List extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Main_List() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String foodCategoryId = request.getParameter("foodId"); // 카테고리별 리스트
		
		try {
			BoardService service = new BoardServiceImpl();
			List<Board> boardList;
			Integer foodId; // 카테고리번호 파라미터 저장할 변수(jsp에서 title 설정에 사용하기 위함)
			
			if(foodCategoryId != null) { // foodCategory에 따라 필터링
				foodId = Integer.parseInt(foodCategoryId);
				boardList = service.boardListByFood(foodId);
				request.setAttribute("boardList", boardList);
				request.setAttribute("foodId", foodId);
			} else { // foodCategory 값이 0일 때, 전체 리스트 출력
				foodId = 0;
				boardList = service.boardAllList(); 
			    request.setAttribute("boardList", boardList);
			    request.setAttribute("foodId", foodId);
			}

			request.getRequestDispatcher("main_list.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
