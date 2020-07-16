<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그아웃</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    session.invalidate();
    %>
    <script>
        alert("로그아웃 되었습니다.");
        sessionStorage.clear();
        location.href = "login.html";
    </script>
    <%
%>
</body>
</html>
