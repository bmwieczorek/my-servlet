package com.bawi.servlet;

import org.apache.log4j.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet(urlPatterns = {"/do"})
public class MyServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(MyServlet.class);
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            System.out.println("default");
            resp.setContentType("text/plain;charset=UTF-8");
            ServletOutputStream out = resp.getOutputStream();
            out.print("Hello from MyServlet! - modified" +  new Date());
            return;
        }

        switch (action) {
            case "forward": {
                System.out.println("forward");
                ServletContext servletContext = getServletContext();
                RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/forwarded.jsp");
                dispatcher.forward(req, resp);
                break;
            }
            case "redirect": {
                System.out.println("redirect");
                resp.sendRedirect(req.getContextPath() + "/redirected.jsp");
                break;
            }
        }
    }

    // log injection

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain;charset=UTF-8");
        ServletOutputStream out = resp.getOutputStream();

        String username = req.getParameter("username");
        LOGGER.info("Authenticating " + username);

        String password = req.getParameter("password");
        if ("admin".equals(password)) {
            LOGGER.info("Successfully logged in");
            out.println("Successfully logged in");
        } else {
            LOGGER.info("Invalid credentials");
            out.println("Invalid credentials");
        }
        out.close();
    }
}
