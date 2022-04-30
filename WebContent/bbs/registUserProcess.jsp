<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	// �Էº�
	request.setCharacterEncoding("euc-kr"); // requset ��ü�� ���ڵ��� �����ش�. (�������� ������ �ѱ� ����)
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
	
	//DBȯ�� �Է�
	String db_url = "jdbc:mysql://127.0.0.1:3306/chosu_scheme?useUnicode=true&characterEncoding=euckr";
	String db_username = "root";
	String db_password = "1234";
	
	// DB Ŀ�ؼ� ��ü ����
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
	MariaDB(or MySQL) 1093 ���� �߻� ��
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
		
		//�������࿡ ���� �����ϸ� 1 �����ϸ� 0 �� return
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
		// ������ ����Ʈ ȭ������
		alert("ȸ�������� �Ϸ�Ǿ����ϴ�.");
		location.href = "<%=request.getContextPath()+"/bbs/login.jsp" %>";
		</script>
	<%
}else{
	%>
		<script type="text/javascript">
		//���н� �ڷΰ���
		alert("ȸ�������� �����Ͽ����ϴ�.");
		<%-- location.href = "<%=request.getContextPath()+"/bbs/insert.jsp" %>"; --%>
		history.back();
		</script>
	<%
}


%>
</body>
</html>
