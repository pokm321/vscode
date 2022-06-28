<!-- examtable에 데이터를 모두 보여주는 jsp파일 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %> <!-- 자바 import하기 -->
<html>
  <head>
  </head>
  <% 
    // JDBC 드라이버를 로드 (초기화)
    Class.forName("com.mysql.cj.jdbc.Driver");

    // 지정된 ip, port, name, password로 MySQL에 연결을 하겠다.
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo21"); 

    // 그 연결에서 query문을 보내기위한 객체 생성
    Statement stmt = conn.createStatement();
  
    String ckey = request.getParameter("key"); // 받아온 key파라미터 저장
    stmt.execute("USE kopoctc;"); // DB선택
    ResultSet rset = stmt.executeQuery("SELECT * FROM examtable;"); // examtable 내용 저장
  %>
  
  <h1>전체 조회</h1> <!-- 제목 -->

  <table cellspacing="1" width="600" border="1">
    <tr> <!-- 테이블의 레이블 row 생성 -->
      <td width="50"><p align="center">이름</p></td>
      <td width="50"><p align="center">학번</p></td>
      <td width="50"><p align="center">국어</p></td>
      <td width="50"><p align="center">영어</p></td>
      <td width="50"><p align="center">수학</p></td>
    </tr>

  <%
    while (rset.next()) { // 데이터들을 테이블에 출력
      out.println("<tr>");
      
      // 클릭하면 이름을 key파라미터로 가진채 oneviewDB.jsp를 여는 버튼생성
      out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + rset.getString(1) + "'>" + rset.getString(1) + "</a></p></td>");
      out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(2)) + "</p></td>");
      out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
      out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
      out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
      out.println("</tr>");
    }
  
    rset.close(); // 객체 닫기
    stmt.close(); // 객체 닫기
    conn.close(); // 객체 닫기
  %>
  </table>
  <body>
    
  </body>
  </html>