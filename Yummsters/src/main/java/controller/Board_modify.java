package controller;

import bean.*;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

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
            res.sendRedirect("login");
            return;
        }

        try{
            BoardService boardService = new BoardServiceImpl();
            Board board = boardService.boardDetail(board_id);
            List<Board> store_category_list = boardService.boardStoreCategoryList(board_id);
            String store_category_name = "";

            for(Board b : store_category_list){
                store_category_name += "#" + b.getStore_category_name() + " ";
            }
            board.setStore_category_name(store_category_name);
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
        req.setCharacterEncoding("utf-8");

        // 게시글 수정 정보 가져오기
        String uploadPath = req.getServletContext().getRealPath("images");
        int size = 10*1024*1024;
        MultipartRequest multi = new MultipartRequest(req, uploadPath, size, "utf-8", new DefaultFileRenamePolicy());
        String title = multi.getParameter("board_title");
        String picture = multi.getOriginalFileName("board_picture");
        String content = multi.getParameter("editorContent");
        Integer food_category_id  = Integer.parseInt(multi.getParameter("food"));
        String[] store_category = multi.getParameterValues("store");
        Integer board_id = Integer.parseInt(multi.getParameter("board_id"));

        // 변경사항 게시글 객체로 생성
        Board board = new Board();
        board.setBoard_id(board_id);
        board.setTitle(title);
        board.setPicture(picture);
        board.setContent(content);
        board.setFood_category_id(food_category_id);

        try{
            BoardService boardService = new BoardServiceImpl();
            // 변경된 내용 게시글 수정 및 편의점 카테고리 삭제
            boardService.modifyBoard(board, board_id);

            // 편의점 카테고리 재등록
            for(String s : store_category){
                Board_Store boardStore = new Board_Store();
                boardStore.setBoard_id(board_id);
                boardStore.setStore_category_id(Integer.parseInt(s));
                boardService.board_store(boardStore);
            }
            res.sendRedirect("boardDetail?board_id="+board_id);

        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, res);
        }
    }
}