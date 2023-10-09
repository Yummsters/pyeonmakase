package controller;

import bean.Member;
import service.BoardService;
import service.BoardServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/recommand")
public class Recommand extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO : 추천 여부를 확인한 다음 추천을 했다면 별을 노란색으로, 하지 않았다면 검은색으로 변경하는 로직 생성
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO : 추천을 했는지 여부를 확인한 다음 추천을 했었다면 클릭 시 삭제, 안했었다면 클릭 시 추천하기 로직 생성
        req.setCharacterEncoding("utf-8");

        HttpSession session = req.getSession();
        Member member = (Member)session.getAttribute("member");

        // 추천하기 버튼 클릭 시 넘겨준 게시글 아이디를 이용해 어떤 게시글인지 판별
        Integer board_id = Integer.parseInt(req.getParameter("board_id"));
        try{
            BoardService boardService = new BoardServiceImpl();
            String response = boardService.boardRecommand(member.getNickname(), board_id);
            res.getWriter().print(response);
            System.out.println(response.toString());
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }

    }
}