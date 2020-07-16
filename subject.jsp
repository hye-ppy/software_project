<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="java.sql.*" %> 
<%
   int time[][] = new int[14][2];//시작시간 끝나는 시간
   String info[][] = new String[14][4];//요일 과목명 분반 강의실
   String day[] = {"월","화","수","목","금"};
   String color[] = {"yellow","blue","hotpink","purple","palegreen"};
   //String sub[] = {"데이터베이스","웹 프로그래밍","네트워크 설계","Talking English 2A", "자바프로그래밍","인공지능","C프로그래밍"};
   int startTime[] = {90000,93000,100000,103000,110000,113000,120000,123000,130000,133000,140000,143000,150000,153000,160000,163000,170000,173000};
   //int endTime[] = {90000,93000,100000,103000,110000,113000,120000,123000,130000,133000,140000,143000,150000,153000,160000,163000,170000,17300000};
   String square_color[]={"#27AAE1","#F1E74E","#E82A36","#9869AA","#00CD73","#E33768","#03A8FD","#FFC601"};

   int k_num=0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>수강과목</title>
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
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR|Yeon+Sung');
    .header{
        margin-top:40px;
    }
    .donga_logo {
        
        font-size : 30px;
    }
    .logo_margin { float:left; margin-left:10px; margin-right:10px;}
    hr {
        float:left;
        width:62%;
    }
  
      #sub_title{
        margin-left:25px;
        font-size : 30px;
    }
    #tables2 {
        margin-left : 20px;
        margin-right : 50px;
        text-align:center;
        margin-top : 20px;
        font-size : 15px;
        border-collapse : collapse;
        border-color :#D5D5D5;
        width : 900px;
        height : 550px;
        float:left;
   }
   #tables3 {
   
    font-size : 15px;
    text-align:center;
    border-collapse : collapse;  
    border-color :#D5D5D5;
     /*  width : 200px;
       height : 500px;
        */
   }
   #tables3 td {
       width : 100px;
       height : 30px;
   }
   .hour{
       width : 8px;
       justify-content: center;
       font-size : 10px;
   }
   #dayweek2 {
    background-color :#D3D3D3;
    font-size : 10px;
   }
   .subject_btn {
   		width : 170px;
   		height : 150px;
   		border:0;
   		cursor: pointer;
   		border-radius:25px;
   }
   #tables2 button {
    width : 220px;
    height : 200px;
   /* opacity:0; filter:Alpha(opacity=0); */
   }
   .subject_name {
   		font-family:"Noto Sans KR",sans-serif;
   		font-size:14px;
   }
</style>
</head>
<body>
    <div class="header">
        <a href="main.html"><img class = "logo_margin" src ="img\donga_logo3.jpg"></a><div class = "donga_logo">수강과목</div>
    </div>
    <br>
    <hr>
	<%
	request.setCharacterEncoding("UTF-8"); 
	String id=(String)session.getAttribute("id");
	String url = "jdbc:sqlserver://DESKTOP-L8MUV15;databaseName=swp"; 
	String uid = "User1";  String pass = "1234";  
	String sql =  "select DISTINCT sub_name from subject where st_num =?"; //오른쪽용
	String sql1 =  "select * from subject where st_num =?"; //왼쪽용
	try{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
		Connection conn = DriverManager.getConnection(url, uid, pass); 
		PreparedStatement pre = conn.prepareStatement(sql);
		pre.setString(1,id); 
		ResultSet rs = pre.executeQuery();
		%>
		
		<table id ="tables2">
	    <tr> 
		
		<% 
		int count=0;
		String sc="";//사각형 색

		while(rs.next()){
			sc=square_color[count];
			if(count<4){
				%>
				<td>
					<form method ="post"action ="subject_middle.jsp">
					<input type ="submit" value ="<%=rs.getString("sub_name")%>" name="button" class = "subject_btn" style="background-color:<%=sc%>; color:<%=sc%>; visibility:visible;">
					<div class ="subject_name">
						<%=rs.getString("sub_name")%>
					</div>
				</td>
				<% 
				count++;
				if(count==4)%></tr><tr><% 
			}
			else{
				%>
				<td>
					<input type ="submit" value ="<%=rs.getString("sub_name")%>" name="button" class = "subject_btn" style="background-color:<%=sc%>; color:<%=sc%>; visibility:visible;">
					<div class ="subject_name">
						<%=rs.getString("sub_name")%>
					</div>
				</td>
				<%
			}
		}
		%></form><% 
		while(count<=5){//줄 맞추기용
			sc=square_color[count];
			if(count<4){
				%>
				<td>
					<input type="submit" name = "button" class = "subject_btn" style="background-color:<%=sc%>; color:<%=sc%>; visibility:hidden">
					<div class="subject_name">&nbsp;</div>
				</td>
				<% 
				count++;
				if(count==4)%></tr><tr><% 
			}
			else{
				%>
				<td>
					<input type="submit" name = "button" class = "subject_btn" style="background-color:<%=sc%>; color:<%=sc%>; visibility:hidden;">
					<div class="subject_name">&nbsp;</div>
				</td>
				<%
				count++;
			}
		}
		
		
		%>
		<!----------------------------------시간표--------------------------------------->
		<%
		
		PreparedStatement pre1 = conn.prepareStatement(sql1);
		pre1.setString(1,id);
		ResultSet rs1 = pre1.executeQuery();
		for(int i=0;rs1.next();i++){//시간 정수로 바꾸는 부분
			String a="";
			String[] b=rs1.getString("start_time").split(":");
			String c=a+b[0]+b[1]+b[2];
			time[i][0]=Integer.parseInt(c);
			a="";
			b=rs1.getString("end_time").split(":");
			c=a+b[0]+b[1]+b[2];
			time[i][1]=Integer.parseInt(c);
			info[i][0]=rs1.getString("day_week");
			info[i][1]=rs1.getString("sub_name");
			info[i][2]=rs1.getString("class_num");
			info[i][3]=rs1.getString("classroom");
			k_num=i;
		}//for문 끝
		%>
		<table border ="1" id ="tables3">
		<tr id = dayweek2> <th></th><th>  월   </th> <th> 화</th> <th>수</th> <th> 목</th> <th> 금 </th></tr>
		<%
		String yoil="";
		int num=9;
		for(int i=0;i<18;i++){
			%><tr><%
			for(int j=0;j<6;j++){
				if(j==0){
					if(i%2==0){
						%><td valign="top" rowspan="2" style="width:4%; font-size:10px;"><%=num%></td><%
						num++;
					}
					continue;
				}//시간 적는 부분
				
				if(j==1) yoil="월";
				else if(j==2) yoil="화";
				else if(j==3) yoil="수";
				else if(j==4) yoil="목";
				else if(j==5) yoil="금";
				
				int check=0;
				for(int k=0;k<=k_num;k++){
					if(info[k][0].equals(yoil)){
						if((startTime[i]>=time[k][0])&&(startTime[i]<time[k][1])){
							check=1;
							%><td style="font-size:11px;"><%=info[k][1] %><br><%='('+info[k][2]+'/'+info[k][3]+')' %></td><%
							break;
						}//그 시간안에 해당하는 과목
					}//그 요일에 있는 과목
				}//학번이 수강하는 과목
				if(check==0) %><td></td><%				
			}//열 for문
			%></tr><%
		}//행 for문
		%></table><%
	}
	catch(Exception e) { 
		out.print("문제가 생겼어요<p>" + e.getMessage()); 
	}
	%>
	
    <hr style="width:100%; margin-top:15px; margin-bottom:30px;">
</body>
</html>