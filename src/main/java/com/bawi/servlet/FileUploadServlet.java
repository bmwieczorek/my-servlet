package com.bawi.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;

@MultipartConfig(
        location = "/Users/me/Downloads/upload/",
        fileSizeThreshold=1024*1024*100, 	// 100 MB
        maxFileSize=1024*1024*500,      	// 500 MB
        maxRequestSize=1024*1024*1000)   	// 1000 MB
@WebServlet(urlPatterns = {"/upload"})
public class FileUploadServlet extends HttpServlet {
    private static final String FILE_NAME_REGEX = ".*\\.(jpg|JPG|jpeg|JPEG|png|PNG|mp3|MP3|mov|MOV|m4v|M4V|mp4|MP4|m4v|M4V)";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        if (!fileName.matches(FILE_NAME_REGEX)) {
            response.getWriter().println("Could not upload " + fileName + ". File extension not supported");
            return;
        }

        for (Part part : request.getParts()) {
//            String path = String.join(File.separator, System.getProperty("user.home"), "Downloads", "uploads", fileName);
//            part.write(path);
            part.write(fileName);
        }
        response.getWriter().println("File " + fileName + " successfully uploaded!");
    }

}
