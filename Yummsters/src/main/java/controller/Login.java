package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Member;
import service.MemberService;
import service.MemberServiceImpl;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    if (session.getAttribute("member") == null) {
	    	request.getRequestDispatcher("login.jsp").forward(request, response);
	    } else {
	    	request.getRequestDispatcher("home.jsp").forward(request, response);
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		try {
			MemberService service = new MemberServiceImpl();
			// 로그인 시도
			Member member = service.login(id, password);
			// 세션 생성 및 "member"라는 이름으로 로그인한 회원 정보 저장
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			
		} catch (Exception e) {
			response.getWriter().print("fail");
		}	
	}

}
