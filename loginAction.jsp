<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Team-5-Board</title>
</head>
<body>
    <%
        String userID = null;
        
        if((userID = (String) session.getAttribute("userID")) != null){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('Already signed in.')");
            //script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
        UserDAO userDAO = new UserDAO();
        int result = userDAO.login(user.getUserID(), user.getUserPassword());
        if (result == 1){
            session.setAttribute("userID", user.getUserID());            // 세션을 줌.
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
        else if (result == 0){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('Wrong Password!')");
            script.println("history.back()");
            script.println("</script>");
        }
        else if (result == -1){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('ID does not exist.')");
            script.println("history.back()");
            script.println("</script>");
        }
        else if (result == -2){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('DB Error!')");
            script.println("history.back()");
            script.println("</script>");
        }
    %>
</body>
</html>