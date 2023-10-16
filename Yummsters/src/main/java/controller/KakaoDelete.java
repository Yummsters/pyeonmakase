package controller;

import service.MemberService;
import service.MemberServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/kakaoDelete")
public class KakaoDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getParameter("utf-8");

        String nickname = req.getParameter("nickname");
        try {
            MemberService memberService = new MemberServiceImpl();
            memberService.removeWish(nickname); // 위시 삭제
            memberService.updateNickname(nickname); // 게시글, 댓글, 추천 닉네임 변경

            //회원탈퇴(정보삭제)
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("nickname", nickname);
            paramMap.put("member_pw", "kakaoLogin");
            memberService.removeMember(paramMap);

            HttpSession session = req.getSession();
            session.removeAttribute("member");
            req.getRequestDispatcher("login").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();

            req.setAttribute("err", "회원탈퇴 오류");

            req.getRequestDispatcher("error.jsp").forward(req, res);
            System.out.println(e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    }
}