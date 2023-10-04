package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/modify")
public class Modify extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO : 디테일 페이지에서 어떤 게시글 번호의 정보를 가져와야 하는지는 로직 작성 필요
        // TODO : detail.jsp로 이동하는 것은 동일하기 때문에 매핑을 modify에서 한 번에 진행하는 것 고려 필요
        req.getRequestDispatcher("detail.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO : 디테일 페이지에서 어떤 게시글 번호의 정보를 가져와야 하는지는 로직 작성 필요
        req.getRequestDispatcher("detail.jsp").forward(req, res);
    }
}