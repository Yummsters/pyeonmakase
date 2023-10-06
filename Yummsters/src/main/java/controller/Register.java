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
        // 痍⑥냼 踰꾪듉 �겢由� �떆 硫붿씤 由ъ뒪�듃 �럹�씠吏�濡� �씠�룞
        res.sendRedirect("register.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // TODO : �젅�떆�뵾 愿��젴 DB ���옣 濡쒖쭅 �옉�꽦 �븘�슂
        req.setCharacterEncoding("utf-8");

        // �씠誘몄� �뾽濡쒕뱶 愿��젴 肄붾뱶 諛� �엯�젰 �젙蹂� 媛��졇�삤湲�
        String uploadPath = req.getServletContext().getRealPath("images");
        int size = 10*1024*1024;
        MultipartRequest multi = new MultipartRequest(req, uploadPath, size, "utf-8", new DefaultFileRenamePolicy());
        String title = multi.getParameter("board_title");
        String picture = multi.getOriginalFileName("board_picture");
        // TODO : �넗�뒪�듃 �뿉�뵒�꽣�뿉 �옉�꽦�븳 �궡�슜�쓣 �뼱�뼸寃� 媛��졇���빞 �븯�뒗吏� �빐寃� �븘�슂
        String content = "�븘臾닿컪�씠�굹 �꽔�뼱蹂닿린";//multi.getParameter("editorContent");
        Integer food_category_id  = Integer.parseInt(multi.getParameter("food"));
        String[] store_category = multi.getParameterValues("store");
        // 濡쒓렇�씤 �븳 �쉶�썝 議고쉶
        //HttpSession session = req.getSession();
        //Member member = (Member)session.getAttribute("user"); // TODO : 濡쒓렇�씤 �븳 �쉶�썝 key�뿉 �뵲�씪 蹂�寃� �븘�슂
        //String nickname = member.getNickname();

        // Board 媛앹껜 �깮�꽦 諛� �젙蹂� 異붽�
        Board board = new Board();
        board.setTitle(title);
        board.setPicture(picture);
        board.setContent(content);
        board.setFood_category_id(food_category_id);
        board.setNickname("�씗吏�");

        try{
            // �벑濡� �럹�씠吏��뿉�꽌 �벑濡� 踰꾪듉 �겢由� �떆 DB ���옣 �썑 硫붿씤 由ъ뒪�듃 �럹�씠吏�濡� �씠�룞
            BoardService boardService = new BoardServiceImpl();
            boardService.boardRegister(board);
            res.sendRedirect("register.jsp");
            //req.getRequestDispatcher("main_list.jsp").forward(req, res);
        }catch (Exception e){
            // TODO : �뿉�윭媛� �궇 寃쎌슦 �뼱�뼸寃� 泥섎━�븷吏� �끉�쓽 �븘�슂
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, res);
        }

    }

}
