package controller;

import bean.Member;
import org.json.simple.JSONObject;
import service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/kakaoLogin")
public class Kakao_login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        res.setCharacterEncoding("utf-8");

        Map<String, Object> response = new HashMap<>();
        String email = req.getParameter("email");
        String nickname = req.getParameter("nickname");
        System.out.println(email + " " + nickname);

        try {
            // 데이터베이스에 있는지 확인 후 없을 경우 회원가입 진행
            MemberService memberService = new MemberServiceImpl();
            Member member = memberService.existMember(email, "kakaoLogin");
            System.out.println(member);

            if (member == null) {
                // 회원이 아닌 경우 가입 진행
                member = new Member(nickname, nickname, email, email, "kakaoLogin");
                memberService.signup(member);
                response.put("signup", true);
                response.put("login", true);
            } else {
                // 이미 회원인 경우 로그인만 진행
                response.put("signup", false);
                response.put("login", true);
            }
            HttpSession session = req.getSession();
            session.setAttribute("member", member);

            // JSON 형태로 변경
            JSONObject jsonObject = new JSONObject(response);
            res.getWriter().print(jsonObject.toJSONString());

            System.out.println(jsonObject.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}