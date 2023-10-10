package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Member;
import service.MemberService;
import service.MemberServiceImpl;

/**
 * Servlet implementation class User_Modify
 */
@WebServlet("/usermodify")
public class User_Modify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public User_Modify() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
	    Member loggedInMember = (Member) request.getSession().getAttribute("member");
	    String memberNickname = loggedInMember.getNickname();
	    String email = loggedInMember.getEmail();  
	    String member_pw = loggedInMember.getMember_pw();

	    try {
	        request.setAttribute("nickname", memberNickname);
	        request.setAttribute("email", email);
	        request.setAttribute("member_pw", member_pw);
	        request.getRequestDispatcher("user_modify.jsp").forward(request, response);
	    } catch(Exception e) {
	        // 에러 처리
	    }

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		String updatedNickname = request.getParameter("nickname");
	    String updatedEmail = request.getParameter("email");
	    String updatedPassword = request.getParameter("member_pw");

	    Member loggedInMember = (Member) request.getSession().getAttribute("member");
	    String originalNickname = loggedInMember.getNickname();

	    try {
	        MemberService memberService = new MemberServiceImpl();
	        
	        Map<String, Object> paramMap = new HashMap<>();
	     
	        paramMap.put("nickname", originalNickname);
	        paramMap.put("newNickname", updatedNickname);
	        paramMap.put("newEmail", updatedEmail);
	        paramMap.put("newPassword", updatedPassword);

	        memberService.userModify(paramMap);
	        response.sendRedirect("user_info.jsp");
	    } catch (Exception e) {
	        // 예외 발생 시 에러 페이지로 리다이렉트
	        e.printStackTrace();
	        response.sendRedirect("error.jsp");
	    }
	}
}
