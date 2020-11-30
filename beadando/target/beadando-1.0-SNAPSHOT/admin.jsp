<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : login
    Created on : 2020.11.22., 16:09:56
    Author     : Bogi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<sql:setDataSource 
    var="beadando"
    driver="org.apache.derby.jdbc.ClientDriver"
    url="jdbc:derby://localhost:1527/beadando"
    user="beadando"
    password="beadando"
    scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css"/>
        <title>Adminisztráció</title>
    </head>
    <body>
        <%
            if (session.getAttribute("validuser") != null) {%>
        <sql:query var="user" dataSource="${beadando}">
            SELECT * FROM Users WHERE Email='<%= session.getAttribute("validuser")%>' AND IsAdmin='1'
        </sql:query>
        <header>
            <form class="kijelentkez" action="check.jsp" method="post"><input type="submit" value="Kijelentkezés" name="logout"></form> 
            <h3 class="siker">Bejelentkezve: ${user.rows[0].username} &nbsp</h3>
        </header>
        <c:choose>
            <c:when test="${user.rowCount>0}">
                <h1 class="zerotopmargin">Adminisztráció</h1>
                <button class="adduserBtn" id="newUserBtn" name="newUserBtn" onclick="openNewUserDiv()">Új felhasználó felvétele</button>
                <!--Új felhasználó rész-->
                <div class="addUserDiv" id="newUserDiv" style="display:none;">
                     <h2>Új felhasználó</h2>
                    <form action="check.jsp" method="POST">
                        <table>
                            <tr>
                                <td class="lefttext">Felhasználónév:</td>
                                <td>
                                    <input type="text" name="username" id="username"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="lefttext">Email-cím:</td>
                                <td>
                                    <input type="text" name="email" id="email"/>
                                </td>
                            </tr>               
                            <tr>
                                <td class="lefttext">Jelszó:</td>
                                <td>
                                    <input type="password" name="password" id="password"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="lefttext">Jelszó megerősítése:</td>
                                <td>
                                    <input type="password" name="password2" id="password2"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="lefttext">Admin?</td>
                                <td>
                                    <input type="checkbox" name="isadmin" id="isadmin"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="center">
                                    <input class="adduserBtn" type="submit" name="adminRegister" value="Új felhasználó hozzáadása"/>
                                </td>
                            </tr>
                        </table>   
                    </form>
                    <button class="cancelBtn" name="cancelUserBtn" onclick="closeNewUserDiv()">Mégsem</button>
                </div>
                <c:if test="${!empty param.errorMsg}">
                    <p class="error">${param.errorMsg}</p>            
                </c:if>
                <!--Új felhasználó rész-->
                <h3 class="uppercase">Felhasználók listája</h3>
                <table class="usertable">
                    <tr class="tabletitle">
                        <th>Email-cím</th>
                        <th>Felhasználónév</th>
                        <th>Jelszó</th>
                        <th>Jogosultság</th>
                        <th>Funkciók</th>
                    </tr>
                    <sql:query var="felhasznalok" dataSource="${beadando}">
                        SELECT * FROM Users ORDER BY Email
                    </sql:query>
                    <c:choose>                
                        <c:when test="${felhasznalok.rowCount>0}">
                            <c:forEach var="user" items="${felhasznalok.rows}">
                                <tr>
                                    <td>${user.email}</td>
                                    <td>${user.username}</td>
                                    <td>${user.password}</td>
                                    <c:choose>
                                        <c:when test="${user.isadmin == true}">
                                            <td>Adminisztrátor</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>Felhasználó</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td>
                                        <form action="check.jsp" method="POST" onSubmit="return confirmUserDelete()">
                                            <input type="hidden" name="deletableUserEmail" value="${user.email}"/>
                                            <input class="deleteBtn" type="submit" name="deleteUser" value="Törlés"/>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                </table>
                <h3 class="uppercase">Szavazatok listája</h3>
                <table class="usertable">
                    <tr class="tabletitle">
                        <th>Dátum</th>
                        <th>Felhasználónév</th>
                        <th>Első kérdés</th>
                        <th>Második kérdés</th>
                        <th>Funkciók</th>
                    </tr>
                    <sql:query var="szavazatok" dataSource="${beadando}">
                        SELECT * FROM VOTES INNER JOIN USERS ON VOTES.EMAIL = USERS.EMAIL ORDER BY Date desc
                    </sql:query>
                    <c:choose>                
                        <c:when test="${szavazatok.rowCount>0}">
                            <c:forEach var="vote" items="${szavazatok.rows}">
                                <tr>
                                    <td>${vote.date}</td>
                                    <td>${vote.username}</td>
                                    <td>${vote.answer1}</td>
                                    <td>${vote.answer2}</td>                            
                                    <td>
                                        <form action="check.jsp" method="POST" onSubmit="return confirmVoteDelete()">
                                            <input type="hidden" name="deletableVoteEmail" value="${vote.email}"/>
                                            <input class="deleteBtn" type="submit" name="deleteVote" value="Törlés"/>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                </table>
            </body>
        </html>
        <script>
            function confirmUserDelete() {
                var r = confirm("Biztosan törli a felhasználót?");
                if (r === true) {
                    return true;
                } else {
                    return false;
                }
            }
            function confirmVoteDelete() {
                var r = confirm("Biztosan törli a szavazatot?");
                if (r === true) {
                    return true;
                } else {
                    return false;
                }
            }
            function openNewUserDiv() {
                var newUserBtn = document.getElementById("newUserBtn");
                var newUserDiv = document.getElementById("newUserDiv");
                newUserBtn.style.display = "none";
                newUserDiv.style.display = "block";
            }
            function closeNewUserDiv() {
                var newUserBtn = document.getElementById("newUserBtn");
                var newUserDiv = document.getElementById("newUserDiv");
                newUserBtn.style.display = "block";
                newUserDiv.style.display = "none";
            }
        </script>

    </c:when>
    <c:otherwise>
        <jsp:forward page="login.jsp">
            <jsp:param name="errorMsg" value="Nincs jogosultsága az admin oldal megtekintéséhez!"/>       
        </jsp:forward>
    </c:otherwise>
</c:choose>

<%} else {%>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kérjük jelentkezzen be!"/>       
</jsp:forward><%}

%>
