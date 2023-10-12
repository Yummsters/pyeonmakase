package controller;

import bean.Board;
import bean.Member;
import bean.Reply;
import service.BoardService;
import service.BoardServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/boardDetail")
public class BoardDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");

        System.out.println(req.getParameter("board_id"));
        // 선택한 게시글의 번호를 가져오기
        Integer board_id = Integer.parseInt(req.getParameter("board_id"));
        System.out.println(board_id);

        try{
            // 게시글 번호를 통해 디비에서 게시글 조회 진행
            BoardService boardService = new BoardServiceImpl();
            Board board = boardService.boardDetail(board_id);

            // 게시글에 해당하는 편의점 카테고리 조회
            List<Board> store_category_list = boardService.boardStoreCategoryList(board_id);
            String store_category_name = "";
            for(Board b : store_category_list){
                store_category_name += "#" + b.getStore_category_name() + " ";
            }
            board.setStore_category_name(store_category_name);
            // board.setStore_category_list(store_category_list);

            req.setAttribute("board", board);
            // 로그인 정보를 통해 디테일 페이지에 로그인한 회원에 따른 정보 변경(추천, 찜)
            HttpSession session = req.getSession();
            Member member = (Member)session.getAttribute("member");
            if(member != null){
                Boolean isRecommand = boardService.isboardRecommand(member.getNickname(), board_id);
                Boolean isWish = boardService.isboardWish(member.getNickname(), board_id);
                req.setAttribute("recommand_select", isRecommand);
                if(isWish){
                    req.setAttribute("wish_select", true);
                }else{
                    req.setAttribute("wish_select", false);
                }
            }
            req.getRequestDispatcher("detail.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("err", "레시피 조회 실패");
            req.getRequestDispatcher("error.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    }
}