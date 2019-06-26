package ajaxdemo.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//继承HttpServlet实现Servlet
public class UserServlet extends HttpServlet {
//重写doGet和doPost
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        boolean used = false;
        if("ajax".equals(name)){
            used = true;
        }else{
            used = false;
        }
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(used);
        out.flush();
        out.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
			//设置字符集编码
        request.setCharacterEncoding("UTF-8");
        this.doGet(request, response);
    }

}
