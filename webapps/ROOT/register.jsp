<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
</head>

<body>

<h1>회원가입</h1>

<form method="post">
    <label for="username">아이디:</label>
    <input type="text" id="username" name="username"><br>

    <label for="name">이름:</label>
    <input type="text" id=name name=name><br>

    <label for=password>비밀번호:</label>
    <input type="text" id=password name=password><br>

    <input type=submit value= 가입하기 >
</form>


<%
request.setCharacterEncoding("UTF-8");
   String username = request.getParameter("username");
   String name = request.getParameter("name");
   String password = request.getParameter("password");

   if (username != null && name != null && password != null) {
       // 데이터베이스 연결 및 회원 정보 저장 로직
       try {
          Class.forName("oracle.jdbc.driver.OracleDriver");
          Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "this", "7531");

          // Check if the username already exists
          String checkSql = "SELECT * FROM REGISTER WHERE ID=?";
          PreparedStatement checkPstmt = conn.prepareStatement(checkSql);
          checkPstmt.setString(1, username);

          ResultSet rs = checkPstmt.executeQuery();
          
         if (rs.next()) {
             // Username already exists
             out.println("<script>alert('아이디가 중복되었습니다.'); location.href='register.jsp';</script>");
         } else {
            // Insert the new user into the database
            String sql = "INSERT INTO REGISTER (ID, NAME, PASSWORD) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, name);
            pstmt.setString(3, password);

            int result = pstmt.executeUpdate();

           if (result == 1) {
               out.println("<script>alert('회원가입에 성공하였습니다.'); location.href='test';</script>");
             } else {
               out.println("<script>alert('회원가입에 실패하였습니다.'); history.back();</script>");
             }
         }

        } catch (Exception e) {
            e.printStackTrace();
        }
   }
%>


</body>
</html>
