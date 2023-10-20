package controller;

import service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/board_delete")
public class Board_delete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        try{
            BoardService boardService = new BoardServiceImpl();
            Integer board_id = Integer.parseInt(req.getParameter("board_id"));
            boardService.deleteBoardAll(board_id);
            res.sendRedirect("mainlist");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("err", "게시글 수정 실패");
            req.getRequestDispatcher("error.jsp").forward(req, res);
        }
    }
}