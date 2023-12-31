package controller;

import java.io.IOException;
import java.util.ArrayList;
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
        String foodIdParam = request.getParameter("foodId"); // mainlist?foodId=
		String keyword = request.getParameter("keyword"); // mainlist?keyword=
        String[] storeNameParam = request.getParameterValues("storeNames[]"); 
        String[] defaultStoreName = {"CU","GS","SEVEN","기타"};
        Integer foodId = 0;
        List<String> storeNames = new ArrayList<>();
        
        if (storeNameParam != null) {
            storeNames = Arrays.asList(storeNameParam);
        } else {
        	storeNames = Arrays.asList(defaultStoreName);
        }

        try {
            BoardService service = new BoardServiceImpl();
            List<Board> boardList;
            
			if(foodIdParam != null && !foodIdParam.isEmpty()) { // foodCategory 선택할 때
				foodId = Integer.parseInt(foodIdParam);
				boardList = service.boardListByCate(foodId, storeNames);
			} else if (keyword != null) { // 검색할 때
				boardList = service.boardSearch(keyword, storeNames);
			} else { // foodId 없을 때, 전체 리스트 출력
				boardList = service.boardAllList(storeNames);
			}

            request.setAttribute("boardList", boardList);
            request.setAttribute("foodId", foodId);
            request.setAttribute("storeNames", storeNames);
            
            request.getRequestDispatcher("main_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String foodIdParam = request.getParameter("foodId"); // mainlist?foodId=
		String keyword = request.getParameter("keyword"); // mainlist?keyword=
        String[] storeNameParam = request.getParameterValues("storeNames[]"); 
        
        Integer foodId = 0;
        List<String> storeNames = new ArrayList<>();
        
        if (storeNameParam != null) {
            storeNames = Arrays.asList(storeNameParam);
        }

        try {
            BoardService service = new BoardServiceImpl();
            List<Board> boardList;
            
			if(foodIdParam != null && !foodIdParam.isEmpty()) { // foodCategory 선택할 때
				foodId = Integer.parseInt(foodIdParam);
				boardList = service.boardListByCate(foodId, storeNames);
			} else if (keyword != null) { // 검색할 때
				boardList = service.boardSearch(keyword, storeNames);
			} else { // foodId 없을 때, 전체 리스트 출력
				boardList = service.boardAllList(storeNames);
			}

            request.setAttribute("boardList", boardList);
            request.setAttribute("foodId", foodId);
            request.setAttribute("storeNames", storeNames);
            
            request.getRequestDispatcher("boardCard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }
    
}
