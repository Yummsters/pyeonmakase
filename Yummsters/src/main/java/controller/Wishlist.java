package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/wishlist")
public class Wishlist extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO : 찜 여부를 확인한 다음 찜을 했다면 별을 노란색으로, 하지 않았다면 검은색으로 변경하는 로직 생성

    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO : 찜을 했는지 여부를 확인한 다음 찜을 했었다면 클릭 시 삭제, 안했었다면 클릭 시 찜하기 로직 생성
    }
}
