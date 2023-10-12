package controller;

import bean.Board;
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

@WebServlet("/board_modify")
public class Board_modify extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        Integer board_id = Integer.parseInt(req.getParameter("board_id"));
        System.out.println(board_id);

        HttpSession session = req.getSession();
        Member member = (Member)session.getAttribute("member");
        if(member == null){
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }

        try{
            BoardService boardService = new BoardServiceImpl();
            Board board = boardService.boardDetail(board_id);
            // 자신이 작성하지 않은 글에 대한 수정페이지로 이동할 때 디테일 페이지로 이동시키기
            if(!member.getNickname().equals(board.getNickname())){
                res.sendRedirect("boardDetail?board_id=" + board_id);
            }else{
                req.setAttribute("board", board);
                req.getRequestDispatcher("modify.jsp").forward(req, res);
            }

        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("err", "게시글 수정 실패");
            req.getRequestDispatcher("error.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO : 디테일 페이지에서 어떤 게시글 번호의 정보를 가져와야 하는지는 로직 작성 필요
        req.getRequestDispatcher("detail.jsp").forward(req, res);
    }

}