<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>시간표</title>
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

        table {
            margin:0 auto; text-align:center;
            margin-top : 50px;
            font-size : 10px;
            border-collapse : collapse;
            border-color :#D5D5D5;
            text-align : center;
        }
        .dayweek {
            width : 100px;
            height : 25px;
            background-color :#CEFBC9;
            font-size : 10px;
        }
        #can
        {
            background-color :#CEFBC9;
        }
        .tableheight {
            height : 40px;
        }
        .sub_find{
            width : 100px;
            height : 40px;
            background-color: white;
            border : 0px solid rgb(0,0,0);
            font-size: 9px;
        }
        .donga_logo {
            margin:0 auto; text-align:center;
        }
    </style>

</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String id = (String)session.getAttribute("id");
    String url = "jdbc:sqlserver://DESKTOP-L8MUV15:1433;databaseName=swp";
    String uid = "User1";  String pass = "1234";
%>
<div class ="div_all2">
    <div class = "donga_logo"><a href="main.html"><img src ="img/donga_logo2.jpg"></a></div>
        <%
            String session_subject = "";
        String sql_enroll = "select * from subject " +
                "where st_num = ? " +
                "order by subject.start_time";

        String sql_subjectCount = "select distinct sub_name " +
                "from subject " +
                "where st_num = ?";

        String sql_time = "select * from time";

        String[] day_week = {"월", "화", "수", "목", "금"}; // 요일
        String color[] = {"#1FBCD3","#CBE2B4","#F7BFA8","#F6B6CA","#9BD5BD","#A0B1DE","#F08770","#F6F086"}; // 시간표에 칠할 색
        HashMap<String, Integer> subject = new HashMap<String, Integer>();
        List<String[]> info = new ArrayList<String[]>();

        try{
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection(url, uid, pass);

            PreparedStatement pre = conn.prepareStatement(sql_subjectCount);
            pre.setString(1,id);
            ResultSet rs = pre.executeQuery();

            int cnt = 0;
            while(rs.next()){ // 색을 칠하기 위해 Hashmap에 과목명과 숫자를 mapping (과목명, 순번)
                subject.put(rs.getString("sub_name"), cnt++);
            }

            pre = conn.prepareStatement(sql_enroll);
            pre.setString(1, id);
            rs = pre.executeQuery();

            while(rs.next()){ // 시간표에 과목명을 넣기 위해 미리 ArrayList에 데이터 입력 (과목명, 시작시간, 끝나는 시간, 요일, 강의실 번호)
                String[] start_time = rs.getString("start_time").split(":"); // 12:30:00 형태를 배열에 12 30 00 형태로 받음
                String[] end_time = rs.getString("end_time").split(":");
                String[] temp = {rs.getString("sub_name"), start_time[0] + start_time[1], end_time[0] + end_time[1], rs.getString("day_week"), rs.getString("classroom")};
                info.add(temp);
            }
    %>
    <!-- Table 작성 -->

    <table border = "1">
        <tr>
            <th id ="can">  </th> <th class="dayweek">월</th> <th class="dayweek">화</th> <th class="dayweek">수</th> <th class="dayweek">목</th> <th class="dayweek">금</th>
        </tr>
        <%
            pre = conn.prepareStatement(sql_time);
            rs = pre.executeQuery();

            while(rs.next()) {
                String[] temp1 = rs.getString("start_time").split(":");
                String[] temp2 = rs.getString("end_time").split(":");
                int period_start_time = Integer.parseInt(temp1[0] + temp1[1]);
                int period_end_time = Integer.parseInt(temp2[0] + temp2[1]);
        %>
        <tr>
            <th class = "tableheight"><%=rs.getString("period")%><br><%=rs.getString("start_time").substring(0,5)%> ~ <%=rs.getString("end_time").substring(0,5)%></th>
            <%
                for (int j=0; j<5; j++) {
            %>
            <td>
                    <%
                        for(int k=0;k<info.size();k++){
                            if(day_week[j].equals(info.get(k)[3]) && (period_start_time <= Integer.parseInt(info.get(k)[2])) && (Integer.parseInt(info.get(k)[1]) < period_end_time)) {
                                // 요일이 같고 수강하는 과목의 시작시간이 시간표 교시의 시작시간과 끝나는 시간 사이에 있는 경우

                    %>
                        <form method = "post" action = "subject_middle.jsp">
                        <input type = "hidden" name = "button" value = "<%=info.get(k)[0]%>"/>
                        <input type = "submit" class ="sub_find" style="background-color:<%=color[subject.get(info.get(k)[0])]%>;"  value = "<%=info.get(k)[0]%>"></input></a>
                        </form>
                    <%
                            }
                        } // for k 끝
                    %>
            </td>
            <%
                } // for j 끝
            %>
        </tr>
        <%
            } // rs.next 끝
        %>
    </table>

    <%
        }catch(Exception e){
            e.printStackTrace();
        }
    %>

</div>
</body>
</html>
