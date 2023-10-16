package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import service.BoardService;
import service.BoardServiceImpl;

@WebServlet("/reply_init")
public class Reply_Init extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        res.setCharacterEncoding("utf-8");
        Integer board_id = Integer.parseInt(req.getParameter("board_id"));

        try{
            BoardService boardService = new BoardServiceImpl();
            //기존 코드
            //String response = boardService.selectReplyList(board_id);
            
            //변경 코드
            JSONObject replyList = new JSONObject(boardService.selectReplyList(board_id, 1));
            String response = replyList.toString();
            
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