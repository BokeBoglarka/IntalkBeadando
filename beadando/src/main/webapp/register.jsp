<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>﻿
<%-- 
    Document   : register
    Created on : 2020.11.22., 16:10:23
    Author     : adriennmate
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css"/>
        <title>Regisztráció</title>
    </head>
    <body class="background">
        <div class="card">
            <h1>Regisztráció</h1>
            <form action="check.jsp" method="POST">
                <table>
                    <tr>
                        <td class="lefttext">Felhasználó név: </td>
                        <td><input type="text" name="username"/></td>
                    </tr>
                    <tr>
                        <td class="lefttext">Email:</td>
                        <td><input type="text" name="email"/></td>
                    </tr>
                    <tr>
                        <td class="lefttext">Jelszó:</td>
                        <td><input type="password" name="password"/></td>
                    </tr>
                    <tr>
                        <td class="lefttext">Jelszó újra</td>
                        <td><input type="password" name="password2"/></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input class="button" type="submit" name="register" value="Regisztráció"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <p><a class="link" href ="login.jsp" > Bejelentkezés </a></p>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <c:if test="${!empty param.errorMsg}">
            <hr>
            <p class="error">${param.errorMsg}</p>
        </c:if>
    </body>   
</html>