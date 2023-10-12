package controller;

import bean.Board;
import bean.Board_Store;
import bean.Member;
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
import javax.servlet.http.HttpSession;


@WebServlet("/register")
public class Register extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Member member = (Member)session.getAttribute("member");
        if(member == null){
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }

        req.getRequestDispatcher("register.jsp").forward(req, res);
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
        String content = multi.getParameter("editorContent");
        Integer food_category_id  = Integer.parseInt(multi.getParameter("food"));
        String[] store_category = multi.getParameterValues("store");

        // 로그인 한 회원 조회
        HttpSession session = req.getSession();
        Member member = (Member)session.getAttribute("member");
        String nickname = member.getNickname();

        // Board 객체 생성 및 정보 추가
        Board board = new Board();
        board.setTitle(title);
        board.setPicture(picture);
        board.setContent(content);
        board.setFood_category_id(food_category_id);
        board.setNickname(nickname);

        try{
            // 등록 페이지에서 등록 버튼 클릭 시 DB 저장 후 메인 리스트 페이지로 이동
            BoardService boardService = new BoardServiceImpl();
            boardService.boardRegister(board);

            // 게시글 등록시 선택한 편의점 카테고리 전부 데이터 추가
            for(String s : store_category){
                Board_Store boardStore = new Board_Store();
                boardStore.setBoard_id(board.getBoard_id());
                boardStore.setStore_category_id(Integer.parseInt(s));
                boardService.board_store(boardStore);
            }
            res.sendRedirect("main_list");
        }catch (Exception e){
            // TODO : 에러가 날 경우 어떻게 처리할지 논의 필요
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, res);
        }
    }

}
