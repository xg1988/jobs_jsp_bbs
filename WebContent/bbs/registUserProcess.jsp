<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	// 입력부
	request.setCharacterEncoding("euc-kr"); // requset 객체의 인코딩을 맞춰준다. (세팅하지 않으면 한글 깨짐)
	String webUserId = request.getParameter("webUserId");
	System.out.println("webUserId:"+webUserId);
	String webUserPassword = request.getParameter("webUserPassword");
	System.out.println("webUserPassword:"+webUserPassword);
	
	String user_name = request.getParameter("user_name");
	System.out.println("user_name:"+user_name);
	String birthday = request.getParameter("birthday");
	System.out.println("birthday:"+birthday);
	String email = request.getParameter("email");
	System.out.println("email:"+email);
	
	String webLoginType = request.getParameter("webLoginType");;
	System.out.println("webLoginType:"+webLoginType);
	
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
	String sql = "INSERT INTO basic_user (user_id, id_type, user_name, email, birthday, password, login_date, regist_date)";
	sql += "VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())";
	System.out.println("sql: "+ sql);
	
	int resultCnt = 0;
	try {
		statement = connection.prepareStatement(sql);
		statement.setString(1, webUserId);
		statement.setString(2, webLoginType);
		statement.setString(3, user_name);
		statement.setString(4, email);
		statement.setString(5, birthday);
		statement.setString(6, webUserPassword);
		
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
		alert("회원가입이 완료되었습니다.");
		location.href = "<%=request.getContextPath()+"/bbs/login.jsp" %>";
		</script>
	<%
}else{
	%>
		<script type="text/javascript">
		//실패시 뒤로가기
		alert("회원가입을 실패하였습니다.");
		<%-- location.href = "<%=request.getContextPath()+"/bbs/insert.jsp" %>"; --%>
		history.back();
		</script>
	<%
}


%>
</body>
</html>
