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
        /*try{
            // 카카오에서 받은 응답으로 닉네임과 이메일 가져오기
            ObjectMapper objectMapper = new ObjectMapper();
            String kakaoLogin = req.getParameter("kakao");
            Map<String, Object> kakaoData = objectMapper.readValue(kakaoLogin, Map.class);

            Map<String, Object> kakaoAccount = (Map<String, Object>) kakaoData.get("kakao_account");
            Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");

            String nickname = (String) profile.get("nickname");
            String email = (String) kakaoAccount.get("email");

            // 데이터베이스에 있는지 확인 후 없을 경우 회원가입 진행
            MemberService memberService = new MemberServiceImpl();
            Member member = memberService.existMember(email, kakaoLogin);
            System.out.println(member);

            if(member == null){
                member = new Member(nickname, nickname, email, email, "kakaoLogin");
                memberService.signup(member);
                response.put("signup", true);
                response.put("login", true);
            }else{
                // 이미 회원인 경우 로그인 완료 진행
                HttpSession session = req.getSession();
                session.setAttribute("member", member);
                req.getRequestDispatcher("home.jsp").forward(req, res);
                response.put("signup", false);
                response.put("login", true);
            }

            // JSON 형태로 변경
            JSONObject jsonObject = new JSONObject(response);
            res.setContentType("application/json");
            res.getWriter().print(jsonObject.toJSONString());

            System.out.println(jsonObject.toJSONString());
        }catch (Exception e){
            e.printStackTrace();
        }
*/
    }
}