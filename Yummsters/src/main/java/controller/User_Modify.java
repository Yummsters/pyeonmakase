package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 HttpSession session = request.getSession();
	        if (session.getAttribute("member") == null) {
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	        } else {
	            request.getRequestDispatcher("user_modify.jsp").forward(request, response);
	        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		 // 세션에서 현재 로그인한 회원의 정보를 가져옴
        HttpSession session = request.getSession();
        Member member = (Member) session.getAttribute("member");
        
        // JSP에서 전송한 수정된 회원 정보를 가져옴
        String newNickname = request.getParameter("nickname");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        try {
            MemberService service = new MemberServiceImpl();
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("nickname", member.getNickname());
            paramMap.put("newNickname", newNickname);
            paramMap.put("newEmail", newEmail);
            paramMap.put("newPassword", newPassword);
            
            service.updateNickname(member.getNickname()); // 변경 전 참조테이블 nickname 변경
            service.updateMember(paramMap);

            // 회원 정보 수정 성공 시 세션 정보 업데이트
            member.setNickname(newNickname);
            member.setEmail(newEmail);
            member.setMember_pw(newPassword);
            // 패스워드 수정이 필요한 경우, 이 부분을 수정

            // 성공 메시지를 request에 추가
            request.setAttribute("message", "회원 정보가 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            // 실패 메시지를 request에 추가
            request.setAttribute("message", "회원 정보 수정에 실패하였습니다.");
        }

        // 결과 페이지로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("user_info.jsp");
        dispatcher.forward(request, response);
    }
}
