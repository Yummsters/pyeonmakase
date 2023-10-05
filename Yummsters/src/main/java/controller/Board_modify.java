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

@WebServlet("/board_modify")
public class Board_modify extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO : 디테일 페이지에서 어떤 게시글 번호의 정보를 가져와야 하는지는 로직 작성 필요
        // TODO : detail.jsp로 이동하는 것은 동일하기 때문에 매핑을 modify에서 한 번에 진행하는 것 고려 필요
        req.setCharacterEncoding("utf-8");
        Integer board_id = Integer.parseInt(req.getParameter("board_id"));
        System.out.println(board_id);

        try{
            BoardService boardService = new BoardServiceImpl();
            Board board = boardService.boardDetail(board_id);
            req.setAttribute("board", board);
            req.getRequestDispatcher("modify.jsp").forward(req, res);
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