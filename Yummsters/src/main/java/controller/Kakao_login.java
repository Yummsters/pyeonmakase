package controller;

import bean.Member;
import org.json.simple.JSONObject;
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

@WebServlet("/kakaoLogin")
public class Kakao_login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        res.setCharacterEncoding("utf-8");

        Map<String, Object> response = new HashMap<>();
        String email = req.getParameter("email");
        String nickname = req.getParameter("nickname");
        System.out.println(email + " " + nickname);

        try {
            // �뜲�씠�꽣踰좎씠�뒪�뿉 �엳�뒗吏� �솗�씤 �썑 �뾾�쓣 寃쎌슦 �쉶�썝媛��엯 吏꾪뻾
            MemberService memberService = new MemberServiceImpl();
            Member member = memberService.existMember(email, "kakaoLogin");
            System.out.println(member);

            if (member == null) {
                // �쉶�썝�씠 �븘�땶 寃쎌슦 媛��엯 吏꾪뻾
                member = new Member(nickname, nickname, email, email, "kakaoLogin");
                memberService.signup(member);
                response.put("signup", true);
                response.put("login", true);
            } else {
                // �씠誘� �쉶�썝�씤 寃쎌슦 濡쒓렇�씤留� 吏꾪뻾
                response.put("signup", false);
                response.put("login", true);
            }
            HttpSession session = req.getSession();
            session.setAttribute("member", member);

            // JSON �삎�깭濡� 蹂�寃�
            JSONObject jsonObject = new JSONObject(response);
            res.getWriter().print(jsonObject.toJSONString());

            System.out.println(jsonObject.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}