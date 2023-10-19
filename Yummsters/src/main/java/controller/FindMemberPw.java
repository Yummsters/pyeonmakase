package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.MemberService;
import service.MemberServiceImpl;

/**
 * Servlet implementation class FindMemberPw
 */
@WebServlet("/findmemberpw")
public class FindMemberPw extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindMemberPw() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    if (session.getAttribute("member") == null) {
	    	request.getRequestDispatcher("findmemberpw.jsp").forward(request, response);
	    } else {
	    	request.getRequestDispatcher("home.jsp").forward(request, response);
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setCharacterEncoding("UTF-8");
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("member_name", request.getParameter("member_name"));
        paramMap.put("nickname", request.getParameter("nickname"));
        paramMap.put("email", request.getParameter("email"));
        paramMap.put("member_id", request.getParameter("member_id"));
   

        try {
            // MemberService를 통해 아이디를 찾습니다.
            MemberService memberService = new MemberServiceImpl(); 
            String memberPw = memberService.findPw(paramMap);
            // memberId를 클라이언트에 응답합니다.
            response.getWriter().write(memberPw != null ? "회원님의 아이디는 ["+ memberPw+"]입니다." : "비밀번호를 찾을 수 없습니다.");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("서비스 처리 중 오류가 발생했습니다.");
        }
    }
}


