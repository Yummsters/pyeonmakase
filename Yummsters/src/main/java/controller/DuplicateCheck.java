package controller;

import java.io.IOException;
import java.io.PrintWriter;

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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	    response.setCharacterEncoding("UTF-8");
	    String type = request.getParameter("type"); // 중복 확인 유형 (nickname, email, id)
	    String value = request.getParameter("value"); // ajax로부터 받은 데이터

	    try {
	        MemberService service = new MemberServiceImpl();
	        String isCheck = "";

	        // 중복 확인 유형에 따라 필요한 메서드 호출
	        if ("nickname".equals(type)) {
	            isCheck = service.isNicknameCheck(value);
	        } else if ("email".equals(type)) {
	            isCheck = service.isEmailCheck(value);
	        } else if ("id".equals(type)) {
	            isCheck = service.isIdCheck(value);
	        }

	        // JSON 결과 전송
	        JSONObject result = new JSONObject();
	        result.put(type, isCheck);
	        response.getWriter().print(result.toString());

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().print("error!");
	    }
	}
}