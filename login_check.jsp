<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8"); 
String id = request.getParameter("id"); 
String pw = request.getParameter("pw"); 
String position=request.getParameter("position");
String url = "jdbc:sqlserver://DESKTOP-L8MUV15;databaseName=swp"; 
String uid = "User1";  String pass = "1234";  
String sql =  "select * from st_info where st_num =?"; 
//String sql1 =  "select * from pro_info where id =?"; 
try{ 
	out.println(position);
	if(position.equals("st")){
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
		Connection conn = DriverManager.getConnection(url, uid, pass); 
		PreparedStatement pre = conn.prepareStatement(sql);
		pre.setString(1,id);
		ResultSet rs = pre.executeQuery();
		if(rs.next()){
			if(pw.equals(rs.getString("st_pw"))) {
				session.setAttribute("name",rs.getString("st_name"));
				session.setAttribute("id", id); 
				session.setMaxInactiveInterval(60*60);  
				response.sendRedirect("main.html"); 
			}
			else{%>
				<script> 
				alert("비밀번호를 틀리게 입력하셨어요~  다시입력해주세요"); 
				location.href="login.html"; </script> <%
			}
		}%>
		<script> 
		alert("미등록아이디입니다~  다시입력해주세요"); 
		location.href="login.html"; </script> <%
	} 
}
catch (Exception e) { 
		out.print("문제가 생겼어요<p>" + e.getMessage()); 
} %>
	
		

</body>
</html>