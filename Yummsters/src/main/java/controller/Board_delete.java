package controller;

import bean.Board;
import service.BoardService;
import service.BoardServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/board_delete")
public class Board_delete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        try{
            BoardService boardService = new BoardServiceImpl();
            Integer board_id = Integer.parseInt(req.getParameter("board_id"));
            boardService.deleteBoardAll(board_id);
            res.sendRedirect("main_list");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("err", "게시글 수정 실패");
            req.getRequestDispatcher("error.jsp").forward(req, res);
        }

    }
}