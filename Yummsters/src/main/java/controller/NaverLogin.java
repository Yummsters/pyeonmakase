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
 * Servlet implementation class NaverLogin
 */
@WebServlet("/naverlogin")
public class NaverLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NaverLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		String id = request.getParameter("id");
		String password = "naverLogin"; // pw 존재하지 않음, 공백
		
		try {
			MemberService service = new MemberServiceImpl();
			Member existMember = service.existMember(id, password);
			if(existMember != null) {
				HttpSession session = request.getSession();
				session.setAttribute("member", existMember);		
				response.getWriter().write("loginSuccess");
			} else {
				Member member = service.signup(new Member(name, nickname, email, id, password));
				if(member != null) {
					HttpSession session = request.getSession();
					session.setAttribute("member", member);		
					response.getWriter().write("signupAndLoginSuccess");
				} else {
					response.getWriter().write("signupfail");
				}
			}
		} catch (Exception e) {
			response.getWriter().write("login fail");
		}
	}
}
