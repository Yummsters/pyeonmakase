package controller;

import service.BoardService;
import service.BoardServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/reply_init")
public class Reply_Init extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        res.setCharacterEncoding("utf-8");
        Integer board_id = Integer.parseInt(req.getParameter("board_id"));

        try{
            BoardService boardService = new BoardServiceImpl();
            String response = boardService.selectReplyList(board_id);
            res.getWriter().print(response);
        }catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    }
}