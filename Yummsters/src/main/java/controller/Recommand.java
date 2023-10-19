package controller;

import bean.Member;
import org.json.simple.JSONObject;
import service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/recommand")
public class Recommand extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");

        // 로그인한 회원 확인
        HttpSession session = req.getSession();
        Member member = (Member)session.getAttribute("member");

        // 추천하기 버튼 클릭 시 넘겨준 게시글 아이디를 이용해 어떤 게시글인지 판별리
        Integer board_id = Integer.parseInt(req.getParameter("board_id"));
        try{
            BoardService boardService = new BoardServiceImpl();

            // 반환 객체 생성 및 반환 값 넣기
            Map<String, Object> response = new HashMap<>();

            // 로그인 한 회원이 아닐 경우
            if(member == null){
                response.put("login", false);
            } else{
                // 로그인 한 회원일 경우
                response = boardService.boardRecommand(member.getNickname(), board_id);
                response.put("login", true);
            }

            // JSON 형식으로 응답 변경
            JSONObject jsonObject = new JSONObject(response);
            res.getWriter().print(jsonObject.toJSONString());
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }

    }
}