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
	
	//회원정보 세팅
	String user_id = (String)session.getAttribute("webUserId"); 
	String user_name = (String)session.getAttribute("user_name"); 
	String email = (String)session.getAttribute("email"); 
	String birthday = (String)session.getAttribute("birthday"); 
	String password = "로그인";
	//DB환경 입력
	String db_url = "jdbc:mysql://127.0.0.1:3306/chosu_scheme?useUnicode=true&characterEncoding=euckr";
	String db_username = "root";
	String db_password = "1234";
	
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
	String sql = "INSERT INTO basic_bbs (bbs_id, subject, user_id, `contents`, user_name, password, hits, regist_date) ";
	sql += "VALUES ((SELECT IFNULL(MAX(bbs_id)+1, 1) FROM basic_bbs ALIAS_FOR_SUBQUERY), ?, ?, ?, ?, ?, 0, NOW());";
	System.out.println("sql: "+ sql);
	
	int resultCnt = 0;
	try {
		statement = connection.prepareStatement(sql);
		statement.setString(1, subject);
		statement.setString(2, user_id);
		statement.setString(3, contents);
		statement.setString(4, user_name);
		statement.setString(5, password);
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
		alert("게시글을 저장하였습니다.");
		location.href = "<%=request.getContextPath()+"/bbs/list.jsp" %>";
		</script>
	<%
}else{
	%>
		<script type="text/javascript">
		//실패시 뒤로가기
		alert("게시글을 저장에 실패하였습니다.");
		<%-- location.href = "<%=request.getContextPath()+"/bbs/insert.jsp" %>"; --%>
		history.back();
		</script>
	<%
}


%>
</body>
</html>
