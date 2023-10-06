package controller;

import bean.Board;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import service.BoardService;
import service.BoardServiceImpl;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class Register extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 취소 버튼 클릭 시 메인 리스트 페이지로 이동
        res.sendRedirect("register.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO : 레시피 관련 DB 저장 로직 작성 필요
        req.setCharacterEncoding("utf-8");

        // 이미지 업로드 관련 코드 및 입력 정보 가져오기
        String uploadPath = req.getServletContext().getRealPath("images");
        int size = 10*1024*1024;
        MultipartRequest multi = new MultipartRequest(req, uploadPath, size, "utf-8", new DefaultFileRenamePolicy());
        String title = multi.getParameter("board_title");
        String picture = multi.getOriginalFileName("board_picture");
        // TODO : 토스트 에디터에 작성한 내용을 어떻게 가져와야 하는지 해결 필요
        String content = "아무값이나 넣어보기";//multi.getParameter("editorContent");
        Integer food_category_id  = Integer.parseInt(multi.getParameter("food"));
        String[] store_category = multi.getParameterValues("store");
        // 濡쒓렇�씤 �븳 �쉶�썝 議고쉶
        //HttpSession session = req.getSession();
        //Member member = (Member)session.getAttribute("user"); // TODO : 로그인 한 회원 key에 따라 변경 필요
        //String nickname = member.getNickname();

        // 로그인 한 회원 조회
        Board board = new Board();
        board.setTitle(title);
        board.setPicture(picture);
        board.setContent(content);
        board.setFood_category_id(food_category_id);
        board.setNickname("�씗吏�");

        try{
            // 등록 페이지에서 등록 버튼 클릭 시 DB 저장 후 메인 리스트 페이지로 이동
            BoardService boardService = new BoardServiceImpl();
            boardService.boardRegister(board);
            res.sendRedirect("register.jsp");
            //req.getRequestDispatcher("main_list.jsp").forward(req, res);
        }catch (Exception e){
            // TODO : 에러가 날 경우 어떻게 처리할지 논의 필요
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, res);
        }

    }

}
