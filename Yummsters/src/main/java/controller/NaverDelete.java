package controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class NaverDelete
 */
@WebServlet("/naverDelete")
public class NaverDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NaverDelete() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String token = (String) getServletContext().getAttribute("token");
		String url;
    	url = "https://nid.naver.com/oauth2.0/token?grant_type=delete";
    	url += "&client_id={Client_ID}";
    	url += "&client_secret={Client Secret}"; // 이거 숨겨야 함
    	url +=  "&access_token=" + token; // 접근 토큰 값
    	url +=  "&service_provider=NAVER";
    	
    	try {
    	    URL deleteUrl = new URL(url); // URL 생성
    	    HttpURLConnection connection = (HttpURLConnection) deleteUrl.openConnection(); // HttpURLConnection 생성
    	    connection.setRequestMethod("DELETE"); // 요청 메소드 설정 (DELETE 요청)
    	    int responseCode = connection.getResponseCode(); // 응답 코드 받아오기
    	    if (responseCode == HttpURLConnection.HTTP_OK) { 
    	        System.out.println("성공");
    	    } else {
    	        System.out.println("실패");
    	    }
    	} catch (Exception e) {
    	    e.printStackTrace();
    	}
	}

}
