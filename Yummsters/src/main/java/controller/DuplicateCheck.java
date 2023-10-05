package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import service.MemberService;
import service.MemberServiceImpl;

/**
 * Servlet implementation class DuplicateCheck
 */
@WebServlet("/duplicateCheck")
public class DuplicateCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DuplicateCheck() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String nickname = request.getParameter("nickname"); // AJAX로부터 받은 데이터
        String email = request.getParameter("email"); 
        String id = request.getParameter("id"); 

        // 닉네임 중복 확인 로직 수행 (DAO, Service 사용)
        MemberService service = new MemberServiceImpl();

        try {
            boolean isNicknameDuplicate = service.isNicknameDuplicate(nickname);
            boolean isEmailDuplicate = service.isEmailDuplicate(email);
            boolean isIdDuplicate = service.isIdDuplicate(id);

            // JSON 객체 생성
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("nickname", isNicknameDuplicate ? "사용불가" : "사용가능");
            jsonResponse.put("email", isEmailDuplicate ? "사용불가" : "사용가능");
            jsonResponse.put("id", isIdDuplicate ? "사용불가" : "사용가능");

            // JSON 응답 전송
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
}