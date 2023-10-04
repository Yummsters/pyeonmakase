
package controller;

import util.FileNameModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;

@WebServlet("/toastEditImageUpload")
public class toastEditImageUpload extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String url = null;
        try{
            String uploadPath = req.getServletContext().getRealPath("images");
            System.out.println(uploadPath);
            // MultiPartFile 객체를 가져오기 위한 수동 처리
            Part filePart = req. getPart("image"); // "image" = 파일 업로드 필드명
            String extName = "";
            if(filePart != null){
                String fileName = filePart.getName(); // 파일 명 가져오기
                extName = fileName.substring(fileName.lastIndexOf(".", fileName.length())); // 파일 확장자
                FileNameModel fileNameModel = new FileNameModel();
                String saveFileName = fileNameModel.GenSaveFileName(extName); // 저장한 파일의 파일명 변경

                // File file = new File(uploadPath, saveFileName);
                // 파일 업로드 진행
                String filePath = uploadPath + saveFileName;
                try(OutputStream out = new FileOutputStream(filePath)){
                    byte[] buff = new byte[1024];
                    int bytesRead;
                    InputStream fileContent = filePart.getInputStream(); // 파일 데이터를 바이트 형태로 가져옴

                    while((bytesRead = fileContent.read(buff)) !=  -1){
                        out.write(buff, 0, bytesRead);
                    }
                }catch (Exception e){
                    e.printStackTrace();
                }

                // 파일이 업로드 되었다면 파일에 대한 정보를 저장
                req.setAttribute("fileName", fileName);
                req.setAttribute("uploadPath", uploadPath);
                req.setAttribute("url", filePath);
                System.out.println("url : " + filePath);

                // 파일 저장 후 이동할 페이지 지정
                req.getRequestDispatcher("register.jsp").forward(req, res);
            }else {
                // 파일 업로드에 실패했다면
                req.getRequestDispatcher("register.jsp").forward(req, res);
            }
        }catch (Exception e){
            System.out.println("[Error] " + e.getMessage());
        }
    }
}
