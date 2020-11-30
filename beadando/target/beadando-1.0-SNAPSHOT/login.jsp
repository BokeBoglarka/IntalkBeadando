<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : login
    Created on : 2020.11.22., 16:10:00
    Author     : adriennmate
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<sql:setDataSource driver="org.apache.derby.jdbc.ClientDriver" password="beadando" scope="session" url="jdbc:derby://localhost:1527/beadando" user="beadando" var="beadando"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css"/>
        <title>Bejelentkezés</title>
    </head>
    <body class="background">
        <div class="card">
            <h1>Bejelentkezés</h1>
            <form action="check.jsp" method="POST">
                <table>
                    <tr>
                        <td class="lefttext">Email cím: </td>
                        <td><input type="text" name="email"/></td>
                    </tr>
                    <tr>
                        <td class="lefttext">Jelszó: </td>
                        <td><input type="password" name="password"/></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input class="button" type="submit" name="login" value="Bejelentkezés"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <p><a class="link" href ="register.jsp" > Regisztráció </a></p>
                        </td>
                    </tr>
                </table>
            </form>

        </div>
        <c:if test="${!empty param.errorMsg}">
            <hr>
            <p class="error">${param.errorMsg}</p>
        </c:if>
        <c:if test="${empty beadando}">
            <p>Kérjük ellenőrizze a kapcsolatot</p>
        </c:if>
    </body>
</html>
