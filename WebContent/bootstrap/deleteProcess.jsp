<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	// �Էº�
	request.setCharacterEncoding("euc-kr"); // requset ��ü�� ���ڵ��� �����ش�. (�������� ������ �ѱ� ����)
	
	String bbs_id = request.getParameter("bbs_id");
	System.out.println("bbs_id:"+bbs_id);
	

	// DBȯ�� �Է�
	String db_url = "jdbc:mysql://us-cdbr-east-05.cleardb.net:3306/heroku_03024d82a802629?characterEncoding=UTF-8&serverTimezone=UTC";
	String db_username = "bb5fc12e7ab829";
	String db_password = "316e7fa5";
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
	
	String sql2 = "DELETE FROM basic_bbs WHERE bbs_id=?";
	System.out.println("sql2: "+ sql2);
	
	int resultCnt = 0;
	try {
		statement = connection.prepareStatement(sql2);
		statement.setString(1, bbs_id);
		//�������࿡ ���� �����ϸ� 1 �����ϸ� 0 �� ����
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
		alert("�Խñ��� �����Ͽ����ϴ�.");
		location.href = "<%=request.getContextPath()+"/bbs/list.jsp" %>";
		</script>
	<%
}else{
	%>
		<script type="text/javascript">
		//���н� �ڷΰ���
		alert("�Խñ� ������ �����Ͽ����ϴ�.");
		<%-- location.href = "<%=request.getContextPath()+"/bbs/insert.jsp" %>"; --%>
		history.back();
		</script>
	<%
}


%>
</body>
</html>
