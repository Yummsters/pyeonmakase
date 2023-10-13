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
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
       String nickname = request.getParameter("nickname");
       String password = request.getParameter("password");

          try {
              MemberService memberService = new MemberServiceImpl();
              memberService.removeWish(nickname); // 위시 삭제
              memberService.updateNickname(nickname); // 게시글, 댓글, 추천 닉네임 변경
              
              //회원탈퇴(정보삭제)
              Map<String, Object> paramMap = new HashMap<>();
              paramMap.put("nickname", nickname);
              paramMap.put("member_pw", password);
              memberService.removeMember(paramMap);
              
              HttpSession session = request.getSession();
              session.removeAttribute("member");

          } catch (Exception e) {
              e.printStackTrace();

              request.setAttribute("err", "회원탈퇴 오류");

              request.getRequestDispatcher("error.jsp").forward(request, response);
              System.out.println(e.getMessage());
          }
       }

}