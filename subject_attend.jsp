<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%
	int zero=0;
	int one=0;
	int two=0;
	int three=0;
	int total=0;
	double f=0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>출석현황</title>
	<meta name="generator" content="editplus" />
	<meta name="author" content="" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<link rel="stylesheet" href="style.css">
	<script src="js/jquery.js"> </script>
	<script src="js/jquery-migrate-1.4.1.min.js"> </script>
	<script type="text/javascript">




	</script>
	<style>
		.tables4{
			border-collapse : collapse;
			border-color :#D5D5D5;
			margin-right : 50px;
			margin-top : 20px;
			width:60%;
			position :absolute; top : 20%; left : 30%;
		}
		.tables4 td{
			text-align: center;
		}
		.week,.day,.date,.att_time,.att_check {
			background-color: #D3D3D3;
			height : 35px;
		}

		td {
			height : 35px;
		}
		.week,.day {
			width : 80px;
		}
		.date,.att_time {
			width : 180px;
		}
		.att_check {
			width : 120px;
		}
		.header2{
			margin-top:40px;
		}
		.donga_logo2 {

			font-size : 30px;

		}
		.logo_margin2 { float:left; margin-left:10px; margin-right:10px;}
		hr {
			position:relative;
			top:-15px;
		}

		.att_info {
			position : absolute ; top : 6%;
			margin-left : 57%;
			text-align : right;
			font-size : 14px;
		}
		.att_info2 {
			position : absolute ; top : 9%;
			margin-left : 57%;
			text-align : right;
			font-size : 14px;

		}
		.button_img {
			width : 250px;
			margin-left : 1%;
		}
		.button_img:hover { filter:brightness(50%);}
		#home_img {
			margin-top : 3%;
		}
		#hrname {
			margin-top : 50px;
		}
	</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String sub_name=(String)session.getAttribute("subject");
	String id=(String)session.getAttribute("id");
	String url = "jdbc:sqlserver://DESKTOP-L8MUV15;databaseName=swp";
	String uid = "User1";  String pass = "1234";
	String sql =  "select * from attendance where st_num = ? and sub_name = ?";
	try{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection conn = DriverManager.getConnection(url, uid, pass);
		PreparedStatement pre = conn.prepareStatement(sql);
		pre.setString(1,id); pre.setString(2,sub_name);
		ResultSet rs = pre.executeQuery();
%>

<div class="header2">
	<a href="main.html"><img class = "logo_margin2" src ="img\donga_logo3.jpg"></a><div class = "donga_logo2"><%=sub_name %>


</div>
	<hr id ="hrname">
	<a href="main.html"><img class="button_img" id ="home_img" src ="img\home.jpg"></a> <br>
	<a href="subject.jsp"><img class="button_img"  src ="img\subject_kind.jpg"></a><br>
	<a href="schedule.jsp"> <img class="button_img"  src ="img\timetable.jpg"></a>


	<table class="tables4">
		<tr>
			<th class ="week">주차</th><th class ="day">요일</th><th class ="date">날짜</th><th class ="att_time">출석 시간</th><th class ="att_check">출석 여부 </th>
		</tr>

		<%
			String real_attend="";
			while(rs.next()){
		%><tr>
		<td><%=rs.getString("week_num")%></td>
		<td><%=rs.getString("day_week")%></td>
		<td><%=rs.getDate("attend_date")%></td>
		<td><%=rs.getTime("attend_date")%></td>

		<%
			if(rs.getString("attend").equals("0")) {
				real_attend="미출결"   ;
				zero++;
				total++;
			}
			else if(rs.getString("attend").equals("1")) {
				real_attend="출석";
				one++;
				total++;
			}
			else if(rs.getString("attend").equals("2")) {
				real_attend="지각";
				two++;
				total++;
			}
			else if(rs.getString("attend").equals("3")) {
				real_attend="결석";
				three++;
				total++;
			}
		%>

		<td><%=real_attend%></td>
	</tr><%
		}

		f=(double)one/total*100.0;
		f=Math.floor(f);
	%></table>
	<span class="att_info">출석 : <%=one %> 지각 : <%=two %> 결석 : <%=three %> 미결 : <%=zero %></span>
	<span class="att_info2">출석 진행률 : <%=f %>%</span>


		<%

   }
   catch(Exception e) {
      out.print("문제가 생겼어요<p>" + e.getMessage());
   }
   %>



</body>
</html>