<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : user
    Created on : 2020.11.22., 16:14:52
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
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <link href="style.css" rel="stylesheet" type="text/css"/>
        <title>Felhasználói oldal</title>
    </head>
    <body>

        <%
            int lehetoseg1 = 0;
            int lehetoseg2 = 0;
            int lehetoseg3 = 0;
            int lehetoseg4 = 0;
            int lehetoseg5 = 0;
            int lehetoseg6 = 0;
            int lehetoseg7 = 0;
            int lehetoseg8 = 0;
            int lehetoseg9 = 0;
            int lehetoseg10 = 0;
            int lehetoseg11 = 0;
            int lehetoseg12 = 0;
            int lehetoseg13 = 0;
            int lehetoseg14 = 0;
            int lehetoseg15 = 0;
            int lehetoseg16 = 0;
        %>
        <%
            if (session.getAttribute("validuser") != null) {%>

        <!-- diagram -->
        <sql:query var="valasz1" dataSource="${beadando}">
            SELECT COUNT(*) as valasz1 FROM BEADANDO.VOTES WHERE Answer1 = 'Segítsd lépteinket! Egyesület a sérült gyermekek fejlesztéséért'
        </sql:query>
        <sql:query var="valasz2" dataSource="${beadando}">
            SELECT COUNT(*) as valasz2 FROM BEADANDO.VOTES WHERE Answer1 = 'Orpheus Állatvédő Egyesület'
        </sql:query>
        <sql:query var="valasz3" dataSource="${beadando}">
            SELECT COUNT(*) as valasz3 FROM BEADANDO.VOTES WHERE Answer1 = 'Egyházak'
        </sql:query>
        <sql:query var="valasz4" dataSource="${beadando}">
            SELECT COUNT(*) as valasz4 FROM BEADANDO.VOTES WHERE Answer1 = 'Fény Felé Alapítvány a fogyatékossággal élő emberek alapítványa'
        </sql:query>
        <sql:query var="valasz5" dataSource="${beadando}">
            SELECT COUNT(*) as valasz5 FROM BEADANDO.VOTES WHERE Answer2 = 'Pénzösszeggel'
        </sql:query>
        <sql:query var="valasz6" dataSource="${beadando}">
            SELECT COUNT(*) as valasz6 FROM BEADANDO.VOTES WHERE Answer2 = 'Önkéntes munkával'
        </sql:query>
        <sql:query var="valasz7" dataSource="${beadando}">
            SELECT COUNT(*) as valasz7 FROM BEADANDO.VOTES WHERE Answer2 = 'Adója 1%-val'
        </sql:query>
        <sql:query var="valasz8" dataSource="${beadando}">
            SELECT COUNT(*) as valasz8 FROM BEADANDO.VOTES WHERE Answer2 = 'Tárgyi hozzájárulással'
        </sql:query>

        <!-- diagram -->

        <sql:query var="user" dataSource="${beadando}">
            SELECT * FROM Users WHERE Email='<%= session.getAttribute("validuser")%>' AND IsAdmin='0'
        </sql:query>
        <header>
            <form class="kijelentkez" action="check.jsp" method="post"><input type="submit" value="Kijelentkezés" name="logout"></form> 
            <h3 class="siker">Bejelentkezve: ${user.rows[0].username} &nbsp</h3>
        </header>
        <c:choose>
            <c:when test="${user.rowCount>0}">
                <sql:query var="existvote1" dataSource="${beadando}">
                    SELECT * FROM Votes WHERE Email='<%= session.getAttribute("validuser")%>'
                </sql:query>
                <c:choose>
                    <c:when test="${existvote1.rowCount>0}">
                        <table class="uservotetable">
                            <caption> Az Ön válasza a következő </caption>
                            <tr class="title">
                                <th>Dátum</th>
                                <th>Kiket támogatna az alábbi szervezetek közül karácsony alkalmából?</th>
                                <th>Lehetősége szerint mivel támogatná a fent megjelölt szervezetet?</th>
                            </tr>
                            <c:forEach var="vote" items="${existvote1.rows}">
                                <tr>
                                    <td>${vote.date}</td>
                                    <td>${vote.answer1}</td>
                                    <td>${vote.answer2}</td>                         
                                </tr>
                            </c:forEach>
                        </table>
                        <sql:query var="szavazat" dataSource="${beadando}">
                            SELECT * FROM Votes
                        </sql:query>

                        <c:forEach var="szavazatok" items="${szavazat.rows}">
                            <c:if test="${szavazatok.answer1 == 'Segítsd lépteinket! Egyesület a sérült gyermekek fejlesztéséért'}">
                                <c:if test="${szavazatok.answer2 == 'Pénzösszeggel'}">
                                    <% lehetoseg1 = lehetoseg1 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Önkéntes munkával'}">
                                    <% lehetoseg2 = lehetoseg2 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Adója 1%-val'}">
                                    <% lehetoseg3 = lehetoseg3 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Tárgyi hozzájárulással'}">
                                    <% lehetoseg4 = lehetoseg4 + 1; %>
                                </c:if>
                            </c:if>
                            <c:if test="${szavazatok.answer1 == 'Orpheus Állatvédő Egyesület'}">
                                <c:if test="${szavazatok.answer2 == 'Pénzösszeggel'}">
                                    <% lehetoseg5 = lehetoseg5 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Önkéntes munkával'}">
                                    <% lehetoseg6 = lehetoseg6 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Adója 1%-val'}">
                                    <% lehetoseg7 = lehetoseg7 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Tárgyi hozzájárulással'}">
                                    <% lehetoseg8 = lehetoseg8 + 1; %>
                                </c:if>
                            </c:if><c:if test="${szavazatok.answer1 == 'Egyházak'}">
                                <c:if test="${szavazatok.answer2 == 'Pénzösszeggel'}">
                                    <% lehetoseg9 = lehetoseg9 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Önkéntes munkával'}">
                                    <% lehetoseg10 = lehetoseg10 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Adója 1%-val'}">
                                    <% lehetoseg11 = lehetoseg11 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Tárgyi hozzájárulással'}">
                                    <% lehetoseg12 = lehetoseg12 + 1; %>
                                </c:if>
                            </c:if><c:if test="${szavazatok.answer1 == 'Fény Felé Alapítvány a fogyatékossággal élő emberek alapítványa'}">
                                <c:if test="${szavazatok.answer2 == 'Pénzösszeggel'}">
                                    <% lehetoseg13 = lehetoseg13 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Önkéntes munkával'}">
                                    <% lehetoseg14 = lehetoseg14 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Adója 1%-val'}">
                                    <% lehetoseg15 = lehetoseg15 + 1; %>
                                </c:if>
                                <c:if test="${szavazatok.answer2 == 'Tárgyi hozzájárulással'}">
                                    <% lehetoseg16 = lehetoseg16 + 1;%>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        <br>
                        <table class="voteListTable">
                            <caption>Az eddigi szavazatok eredménye</caption>
                            <tr>
                                <th colspan="2">Segítsd lépteinket! Egyesület a sérült gyermekek fejlesztéséért</th>
                            </tr>
                            <tr>
                                <td>Pénzösszeggel</td>
                                <td><% out.println(lehetoseg1); %></td>
                            </tr>
                            <tr>
                                <td>Önkéntes munkával</td>
                                <td><% out.println(lehetoseg2); %></td>
                            </tr>
                            <tr>
                                <td>Adója 1%-val</td>
                                <td><% out.println(lehetoseg3); %></td>
                            </tr>
                            <tr>
                                <td>Tárgyi hozzájárulással</td>
                                <td><% out.println(lehetoseg4); %></td>
                            </tr>
                            <tr>
                                <th colspan="2">Orpheus Állatvédő Egyesület</th>
                            </tr>
                            <tr>
                                <td>Pénzösszeggel</td>
                                <td><% out.println(lehetoseg5); %></td>
                            </tr>
                            <tr>
                                <td>Önkéntes munkával</td>
                                <td><% out.println(lehetoseg6); %></td>
                            </tr>
                            <tr>
                                <td>Adója 1%-val</td>
                                <td><% out.println(lehetoseg7); %></td>
                            </tr>
                            <tr>
                                <td>Tárgyi hozzájárulással</td>
                                <td><% out.println(lehetoseg8); %></td>
                            </tr>
                            <tr>
                                <th colspan="2">Egyházak</th>
                            </tr>
                            <tr>
                                <td>Pénzösszeggel</td>
                                <td><% out.println(lehetoseg9); %></td>
                            </tr>
                            <tr>
                                <td>Önkéntes munkával</td>
                                <td><% out.println(lehetoseg10); %></td>
                            </tr>
                            <tr>
                                <td>Adója 1%-val</td>
                                <td><% out.println(lehetoseg11); %></td>
                            </tr>
                            <tr>
                                <td>Tárgyi hozzájárulással</td>
                                <td><% out.println(lehetoseg12); %></td>
                            </tr>
                            <tr>
                                <th colspan="2">Fény Felé Alapítvány a fogyatékossággal élő emberek alapítványa</th>
                            </tr>
                            <tr>
                                <td>Pénzösszeggel</td>
                                <td><% out.println(lehetoseg13); %></td>
                            </tr>
                            <tr>
                                <td>Önkéntes munkával</td>
                                <td><% out.println(lehetoseg14); %></td>
                            </tr>
                            <tr>
                                <td>Adója 1%-val</td>
                                <td><% out.println(lehetoseg15); %></td>
                            </tr>
                            <tr>
                                <td>Tárgyi hozzájárulással</td>
                                <td><% out.println(lehetoseg16);%></td>
                            </tr>
                        </table>
                        <span id="barchart_1" style="width:50%;"></span>
                        <span id="barchart_2" style="width:50%;"></span>
                    </c:when>
                    <c:otherwise>
                        <form action="check.jsp"  method="post">
                            <table class="votetable">
                                <tr class="title">
                                    <th>1. Kérdés: Kiket támogatna az alábbi szervezetek közül karácsony alkalmából?</th>
                                </tr>
                            </table>
                            <br>
                            <table class="votetable">
                                <tr class="valt1">
                                    <td><input type="radio" id="valasz1" name="kerdes1" value="Segítsd lépteinket! Egyesület a sérült gyermekek fejlesztéséért" checked>
                                        <label for="valasz1">Segítsd lépteinket! Egyesület a sérült gyermekek fejlesztéséért </label>
                                    </td>
                                </tr>
                                <tr class="valt2">
                                    <td><input type="radio" id="valasz2" name="kerdes1" value="Orpheus Állatvédő Egyesület">
                                        <label for="valasz2">Orpheus Állatvédő Egyesület </label>
                                    </td>
                                </tr>
                                <tr class="valt1">
                                    <td><input type="radio" id="valasz3" name="kerdes1" value="Egyházak">
                                        <label for="valasz3">Egyházak </label>
                                    </td>
                                </tr>
                                <tr class="valt2">
                                    <td><input type="radio" id="valasz4" name="kerdes1" value="Fény Felé Alapítvány a fogyatékossággal élő emberek alapítványa">
                                        <label for="valasz4">Fény Felé Alapítvány a fogyatékossággal élő emberek alapítványa </label>
                                    </td>
                                </tr>
                            </table>
                            <br>
                            <table class="votetable">
                                <tr class="title">
                                    <th>2. Kérdés: Lehetősége szerint mivel támogatná a fent megjelölt szervezetet?</th>
                                </tr>
                            </table>
                            <br>
                            <table class="votetable">
                                <tr class="valt1">
                                    <td><input type="radio" id="valasz5" name="kerdes2" value="Pénzösszeggel" checked>
                                        <label for="valasz5"> Pénzösszeggel </label>
                                    </td>
                                </tr>
                                <tr class="valt2">
                                    <td><input type="radio" id="valasz6" name="kerdes2" value="Önkéntes munkával">
                                        <label for="valasz6"> Önkéntes munkával </label>
                                    </td>
                                </tr>
                                <tr class="valt1">
                                    <td><input type="radio" id="valasz7" name="kerdes2" value="Adója 1%-val">
                                        <label for="valasz7"> Adója 1%-val </label>
                                    </td>
                                </tr>
                                <tr class="valt2">
                                    <td><input type="radio" id="valasz8" name="kerdes2" value="Tárgyi hozzájárulással">
                                        <label for="valasz8"> Tárgyi hozzájárulással </label>
                                    </td>
                                </tr>
                            </table>
                            <br>
                            <table>
                                <tr>
                                    <td class="sendVoteTd">
                                        <input class="sendVoteBtn" type="submit" name="sendVote" value="Szavazat elküldése"/>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <jsp:forward page="login.jsp">
                    <jsp:param name="errorMsg" value="Nincs jogosultsága a user oldal megtekintéséhez!"/>       
                </jsp:forward>
            </c:otherwise>
        </c:choose>


        <c:if test="${!empty param.errorMsg}">
            <hr>
            ${param.errorMsg}
        </c:if>
        <%} else {%>
        <jsp:forward page="login.jsp">
            <jsp:param name="errorMsg" value="Kérjük jelentkezzen be!"/>       
        </jsp:forward><%}

        %>
    </body>
</html>
<c:if test="${true}">
    <script>
        google.charts.load("current", {packages: ["corechart"]});
        google.charts.setOnLoadCallback(drawChart);
        google.charts.setOnLoadCallback(drawChart2);
        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ["Válasz", "Szavazatok száma", {role: "style"}],
                ["Segítsd lépteinket! ", ${valasz1.rows[0].valasz1}, "#0085f4"],
                ["Orpheus Állatvédő Egyesület ", ${valasz2.rows[0].valasz2}, "#0065b9"],
                ["Egyházak ", ${valasz3.rows[0].valasz3}, "#00457e"],
                ["Fény Felé Alapítvány ", ${valasz4.rows[0].valasz4}, "#000"]
            ]);

            var view = new google.visualization.DataView(data);
            view.setColumns([0, 1,
                {calc: "stringify",
                    sourceColumn: 1,
                    type: "string",
                    role: "annotation"},
                2]);

            var options = {
                title: "Kiket támogatna az alábbi szervezetek közül karácsony alkalmából?",
                width: 700,
                height: 400,
                bar: {groupWidth: "100%"},
                legend: {position: "none"},
            };
            var chart = new google.visualization.BarChart(document.getElementById("barchart_1"));
            chart.draw(view, options);
        }
        function drawChart2() {
            var data = google.visualization.arrayToDataTable([
                ["Válasz", "Szavazatok száma", {role: "style"}],
                ["Pénzösszeggel ", ${valasz5.rows[0].valasz5}, "#000"],
                ["Önkéntes munkával ", ${valasz6.rows[0].valasz6}, "#00457e"],
                ["Adója 1%-val ", ${valasz7.rows[0].valasz7}, "#0065b9"],
                ["Tárgyi hozzájárulással ", ${valasz8.rows[0].valasz8}, "#0085f4"]
            ]);

            var view = new google.visualization.DataView(data);
            view.setColumns([0, 1,
                {calc: "stringify",
                    sourceColumn: 1,
                    type: "string",
                    role: "annotation"},
                2]);

            var options = {
                title: "Lehetősége szerint mivel támogatná a fent megjelölt szervezetet?",
                width: 700,
                height: 400,
                bar: {groupWidth: "100%"},
                legend: {position: "none"},
            };
            var chart = new google.visualization.BarChart(document.getElementById("barchart_2"));
            chart.draw(view, options);
        }
    </script>
</c:if>
