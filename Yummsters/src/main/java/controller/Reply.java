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

@WebServlet("/reply")
public class Reply extends HttpServlet {
    // 댓글 삭제
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        res.setCharacterEncoding("utf-8");

        // 댓글 아이디 가져오기
        System.out.println(req.getParameter("reply_id"));
        Integer reply_id = Integer.parseInt(req.getParameter("reply_id"));
        System.out.println("replyServlet : " + reply_id);

        try{
            BoardService boardService = new BoardServiceImpl();
            String response = boardService.deleteReply(reply_id);
            res.getWriter().print(response);
            System.out.println(response);
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }

    }

    // 댓글 등록
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        res.setCharacterEncoding("utf-8");

        // 게시글 가져오기
        Integer board_id = Integer.parseInt(req.getParameter("board_id"));

        // 로그인한 회원 가져오기
        HttpSession session = req.getSession();
        Member member = (Member) session.getAttribute("member");

        bean.Reply reply = new bean.Reply();
        reply.setBoard_id(board_id);
        reply.setContent(req.getParameter("content"));
        reply.setNickname(member.getNickname());

        try{
            // 입력한 댓글 정보 저장 및 조회 정보 가져오기
            BoardService boardService = new BoardServiceImpl();
            String response = boardService.replyRegisterAndList(reply);
            res.getWriter().print(response);
            System.out.println(response.toString());
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }
    }
}