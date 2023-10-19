package controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Member;
import service.BoardService;
import service.BoardServiceImpl;

@WebServlet("/reply")
public class Reply extends HttpServlet {
    // 댓글 삭제
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        res.setCharacterEncoding("utf-8");

        // 댓글 아이디 가져오기
        System.out.println(req.getParameter("reply_id"));
        Integer reply_id = Integer.parseInt(req.getParameter("reply_id"));
        System.out.println("replyServlet : " + reply_id);

        try{
            BoardService boardService = new BoardServiceImpl();
            String response = boardService.deleteReply(reply_id);
            res.getWriter().print(response);
            System.out.println(response);
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }

    }

    // 댓글 등록
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        res.setCharacterEncoding("utf-8");

        // 게시글 가져오기
        Integer board_id = Integer.parseInt(req.getParameter("board_id"));

        // 로그인한 회원 가져오기
        HttpSession session = req.getSession();
        Member member = (Member) session.getAttribute("member");

        try{
            // 반환할 객체 생성 및 반환 값 넣기
            Map<String, Object> response = new HashMap<>();

            if(member == null){
                return; //Json 형식이 아닌 걸로 바꿔서 return 주고 끝내버림. 암것도 출력 x
            }else{
                // 댓글 객체 생성
                bean.Reply reply = new bean.Reply();
                reply.setBoard_id(board_id);
                reply.setContent(req.getParameter("content"));
                reply.setNickname(member.getNickname());
                // 입력한 댓글 정보 저장 및 조회 정보 가져오기
                BoardService boardService = new BoardServiceImpl();
                response = boardService.replyRegisterAndList(reply);
                
//                response.put("login", true);
            }
            
            // JSON 형식으로 응답 변경
//            JSONObject jsonObject = new JSONObject(response);
//            res.getWriter().print(jsonObject.toJSONString());
//            System.out.println(jsonObject.toJSONString());
            
            //1018 수 혜리 수정
            System.out.println(response.get("replyList"));
            req.setAttribute("replyList", response.get("replyList"));
            req.getRequestDispatcher("/reply.jsp").forward(req, res);
            
        }catch (Exception e){
            e.printStackTrace();
            req.setAttribute("err", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, res);
        }
    }
}