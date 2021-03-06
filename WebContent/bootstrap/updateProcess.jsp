<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	// 입력부
	request.setCharacterEncoding("euc-kr"); // requset 객체의 인코딩을 맞춰준다. (세팅하지 않으면 한글 깨짐)
	/* String user_name = request.getParameter("user_name");
	System.out.println("user_name:"+user_name); */
	String subject = request.getParameter("subject");
	System.out.println("subject:"+subject);
	String contents = request.getParameter("contents");
	System.out.println("contents:"+contents);
	/* String password = request.getParameter("password");
	System.out.println("password:"+password); */
	String bbs_id = request.getParameter("bbs_id");
	System.out.println("bbs_id:"+bbs_id);
	
	//회원정보 세팅
	String user_id = (String)session.getAttribute("webUserId"); 
	String user_name = (String)session.getAttribute("user_name"); 
	String email = (String)session.getAttribute("email"); 
	String birthday = (String)session.getAttribute("birthday"); 
	

	// DB환경 입력
	String db_url = "jdbc:mysql://us-cdbr-east-05.cleardb.net:3306/heroku_03024d82a802629?characterEncoding=UTF-8&serverTimezone=UTC";
	String db_username = "bb5fc12e7ab829";
	String db_password = "316e7fa5";
	// DB 커넥션 객체 생성
	Connection connection = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection(db_url, db_username, db_password);
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	PreparedStatement statement = null;
	ResultSet resultset = null;
	
	
	/**
	MariaDB(or MySQL) 1093 오류 발생 시
	https://finkle.tistory.com/118
	**/
	
	String sql2 = "UPDATE basic_bbs ";
	sql2 += "SET bbs_id=?, subject=?,`contents`=?, user_name=?, regist_date=NOW() WHERE bbs_id=?";
	System.out.println("sql2: "+ sql2);
	
	int resultCnt = 0;
	try {
		statement = connection.prepareStatement(sql2);
		statement.setString(1, bbs_id);
		statement.setString(2, subject);
		statement.setString(3, contents);
		statement.setString(4, user_name);
		statement.setString(5, bbs_id);
		//쿼리실행에 따라서 성공하면 1 실패하면 0 을 return
		resultCnt = statement.executeUpdate(); 
	} catch (Exception e) {
		e.printStackTrace();
	} finally{
		if(resultset != null) {
			try {
				resultset.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(statement != null) {
			try {
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
System.out.println("resultCnt : "+ resultCnt);
if(resultCnt == 1){
	%>
		<script type="text/javascript">
		// 성공시 리스트 화면으로
		alert("게시글을 수정하였습니다.");
		location.href = "<%=request.getContextPath()+"/bbs/list.jsp" %>";
		</script>
	<%
}else{
	%>
		<script type="text/javascript">
		//실패시 뒤로가기
		alert("게시글을 수정에 실패하였습니다.");
		<%-- location.href = "<%=request.getContextPath()+"/bbs/insert.jsp" %>"; --%>
		history.back();
		</script>
	<%
}


%>
</body>
</html>
