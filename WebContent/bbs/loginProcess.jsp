<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	// �Էº�
	request.setCharacterEncoding("euc-kr"); // requset ��ü�� ���ڵ��� �����ش�. (�������� ������ �ѱ� ����)
	String webUserId = request.getParameter("webUserId");
	System.out.println("webUserId:"+webUserId);
	String webUserPassword = request.getParameter("webUserPassword");
	System.out.println("webUserPassword:"+webUserPassword);
	
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
	String sql = "SELECT COUNT(*),  user_id, user_name, email, birthday FROM basic_user WHERE user_id =? and password=? and id_type='�Ϲ�'";
	System.out.println("sql: "+ sql);
	
	String user_name = "";
	String email = "";
	String birthday = "";
	
	int resultCnt = 0;
	try {
		statement = connection.prepareStatement(sql);
		statement.setString(1, webUserId);
		statement.setString(2, webUserPassword);
		
		resultset = statement.executeQuery();
		
		while(resultset.next()) {
			resultCnt = resultset.getInt(1);
			user_name = resultset.getString("user_name");
			email = resultset.getString("email");
			birthday = resultset.getString("birthday");
		}
		System.out.println("resultCnt:"+resultCnt);
		
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
		session.setAttribute("loginYn", "Y");
		session.setAttribute("webUserId", webUserId);
		session.setAttribute("user_name", user_name);
		session.setAttribute("email", email);
		session.setAttribute("birthday", birthday);
		
	%>
		<script type="text/javascript">
		// ������ ����Ʈ ȭ������
		alert("�α��ο� �����Ͽ����ϴ�.");
		location.href = "<%=request.getContextPath()+"/bbs/list.jsp" %>";
		</script>
	<%
}else{
	%>
		<script type="text/javascript">
		//���н� �ڷΰ���
		alert("���̵� ��й�ȣ�� Ȯ���Ͻʽÿ�.");
		<%-- location.href = "<%=request.getContextPath()+"/bbs/insert.jsp" %>"; --%>
		history.back();
		</script>
	<%
}


%>

