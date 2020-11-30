<%@page import="java.text.SimpleDateFormat"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.Date"%>
<%-- 
    Document   : check
    Created on : 2020.11.22., 16:14:28
    Author     : Bogi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<% Date date = new Date();
    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
    String dates = ft.format(date);%>

<sql:setDataSource 
    var="beadando"
    driver="org.apache.derby.jdbc.ClientDriver"
    url="jdbc:derby://localhost:1527/beadando"
    user="beadando"
    password="beadando"
    scope="session"/>
<c:choose>
    <c:when test="${!empty param.login}">
        <% session.setAttribute("validuser", null);%>
        <c:choose>
            <c:when test="${(empty param.email) || (empty param.password)}">
                <jsp:forward page="login.jsp">
                    <jsp:param name="errorMsg" value="Felhasználó név és jelszó megadása kötelező!"/>       
                </jsp:forward>
            </c:when>
            <c:otherwise>
                <sql:query var="eredmeny" dataSource="${beadando}">
                    SELECT * FROM Users WHERE Email='${param.email}' AND Password='${param.password}'
                </sql:query>
                <c:choose>
                    <c:when test="${eredmeny.rowCount>0}">
                        <%session.setAttribute("validuser", request.getParameter("email"));%>
                        <sql:query var="IsAdmin" dataSource="${beadando}">
                            SELECT * FROM users WHERE Email='${param.email}' AND IsAdmin='1'
                        </sql:query>
                        <c:choose>
                            <c:when test="${IsAdmin.rowCount>0}">
                                <c:redirect url="admin.jsp"/>
                            </c:when>
                            <c:otherwise>
                                <c:redirect url="user.jsp"/>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <jsp:forward page="login.jsp">
                            <jsp:param name="errorMsg" value="Jelszó helytelen"/>       
                        </jsp:forward>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${!empty param.sendVote}">
        <sql:query var="existvote" dataSource="${beadando}">
            SELECT * FROM Votes WHERE Email='<%=session.getAttribute("validuser")%>'
        </sql:query>
        <c:choose>
            <c:when test="${existvote.rowCount>0}">
                <jsp:forward page="user.jsp">
                    <jsp:param name="errorMsg" value="Az adott felhasználóval már létezik leadott szavazat!"/>       
                </jsp:forward>
            </c:when>
            <c:otherwise>
                <sql:update var="insert2" dataSource="${beadando}">
                    INSERT INTO Votes (Answer1, Answer2, Date, Email)
                    VALUES ('${param.kerdes1}','${param.kerdes2}', '<%=dates%>', '<%=session.getAttribute("validuser")%>')
                </sql:update>
                <c:redirect url="user.jsp"/>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${!empty param.logout}">
        <% session.invalidate();%>
        <c:redirect url="login.jsp"/>
    </c:when>
    <c:when test="${!empty param.register}">
        <c:choose>
            <c:when test="${(empty param.email) || (empty param.username) || (empty param.password) || (empty param.password2)}">
                <jsp:forward page="register.jsp">
                    <jsp:param name="errorMsg" value="Adja meg az összes adatot!"/>       
                </jsp:forward>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${!fn:contains(param.email, '@')}">
                        <jsp:forward page="register.jsp">
                            <jsp:param name="errorMsg" value="Az email címnek tartalmaznia kell a @ jelet!"/>       
                        </jsp:forward>                           
                    </c:when>
                    <c:otherwise>
                        <sql:query var="eredmeny2" dataSource="${beadando}">
                            SELECT * FROM Users WHERE Email='${param.email}'
                        </sql:query>
                        <c:choose>
                            <c:when test="${eredmeny2.rowCount>0}">
                                <jsp:forward page="register.jsp">
                                    <jsp:param name="errorMsg" value="Ezzel az email címmel már történt regisztráció!"/>       
                                </jsp:forward>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${param.password != param.password2}">
                                        <jsp:forward page="register.jsp">
                                            <jsp:param name="errorMsg" value="A megadott jelszavak nem egyeznek!"/>       
                                        </jsp:forward>
                                    </c:when>
                                    <c:otherwise>
                                        <sql:update var="insert" dataSource="${beadando}">
                                            INSERT INTO Users (UserName, Email, Password, IsAdmin)
                                            VALUES ('${param.username}','${param.email}','${param.password}',false)
                                        </sql:update>
                                        <jsp:forward page="login.jsp">
                                            <jsp:param name="errorMsg" value="Sikeresen regisztrált"/>       
                                        </jsp:forward>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${!empty param.adminRegister}">
        <c:choose>
            <c:when test="${(empty param.email) || (empty param.username) || (empty param.password) || (empty param.password2)}">
                <jsp:forward page="admin.jsp">
                    <jsp:param name="errorMsg" value="Adja meg az összes adatot!"/>       
                </jsp:forward>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${!fn:contains(param.email, '@')}">
                        <jsp:forward page="admin.jsp">
                            <jsp:param name="errorMsg" value="Az email címnek tartalmaznia kell a @ jelet!"/>       
                        </jsp:forward>                           
                    </c:when>
                    <c:otherwise>
                        <sql:query var="eredmeny2" dataSource="${beadando}">
                            SELECT * FROM Users WHERE Email='${param.email}'
                        </sql:query>
                        <c:choose>
                            <c:when test="${eredmeny2.rowCount>0}">
                                <jsp:forward page="admin.jsp">
                                    <jsp:param name="errorMsg" value="Ezzel az email címmel már történt regisztráció!"/>       
                                </jsp:forward>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${param.password != param.password2}">
                                        <jsp:forward page="admin.jsp">
                                            <jsp:param name="errorMsg" value="A megadott jelszavak nem egyeznek!"/>       
                                        </jsp:forward>
                                    </c:when>
                                    <c:otherwise>
                                        <sql:update var="insert" dataSource="${beadando}">
                                            INSERT INTO Users (UserName, Email, Password, IsAdmin)
                                            VALUES ('${param.username}','${param.email}','${param.password}','${param.isadmin != null ? true : false}')
                                        </sql:update>
                                        <c:redirect url = "admin.jsp"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${!empty param.deleteUser}">
        <c:if test="${!empty param.deletableUserEmail && param.deletableUserEmail != ''}">
            <sql:update var="deleteuser" dataSource="${beadando}">
                DELETE FROM Users WHERE Email = '${param.deletableUserEmail}'
            </sql:update>
            <sql:update var="deletevote" dataSource="${beadando}">
                DELETE FROM Votes WHERE Email = '${param.deletableUserEmail}'
            </sql:update>
        </c:if>
        <c:redirect url = "admin.jsp"/>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${!empty param.deleteVote}">    
                <c:if test="${!empty param.deletableVoteEmail && param.deletableVoteEmail != ''}">
                    <sql:update var="deletevote" dataSource="${beadando}">
                        DELETE FROM Votes WHERE Email = '${param.deletableVoteEmail}'
                    </sql:update>
                </c:if>
                <c:redirect url = "admin.jsp"/>
            </c:when>
            <c:otherwise>
                <jsp:forward page="login.jsp">
                    <jsp:param name="errorMsg" value="A program használata előtt be kell jelentkezni"/>       
                </jsp:forward>
            </c:otherwise>
        </c:choose>
    </c:otherwise>             
</c:choose>
