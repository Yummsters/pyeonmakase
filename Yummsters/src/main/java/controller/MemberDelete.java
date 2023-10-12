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

import bean.Member;
import service.MemberService;
import service.MemberServiceImpl;

/**
 * Servlet implementation class MemberDelete
 */
@WebServlet("/memberdelete")
public class MemberDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberDelete() {
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
		    String member_pw = loggedInMember.getMember_pw();

		    try {
		       
		        MemberService memberService = new MemberServiceImpl();
		        //다른테이블에 저장된 데이터 먼저 삭제
		        memberService.removeRelatedData(memberNickname);
		        
		        //회원탈퇴(정보삭제)
		        Map<String, Object> paramMap = new HashMap<>();
		        paramMap.put("nickname", memberNickname);
		        paramMap.put("member_pw", member_pw);

		        memberService.memberRemove(paramMap);
		        
		        HttpSession session = request.getSession();
		        session.removeAttribute("member");

		        response.sendRedirect("home.jsp");
		    } catch (Exception e) {
		        e.printStackTrace();

		        request.setAttribute("err", "회원탈퇴 오류");

		        request.getRequestDispatcher("error.jsp").forward(request, response);
		    }
	    }
	


	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
