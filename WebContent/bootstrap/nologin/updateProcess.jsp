<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	// �Էº�
	request.setCharacterEncoding("euc-kr"); // requset ��ü�� ���ڵ��� �����ش�. (�������� ������ �ѱ� ����)
	String user_name = request.getParameter("user_name");
	System.out.println("user_name:"+user_name);
	String subject = request.getParameter("subject");
	System.out.println("subject:"+subject);
	String contents = request.getParameter("contents");
	System.out.println("contents:"+contents);
	String password = request.getParameter("password");
	System.out.println("password:"+password);
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
	
	// �Խñ� ��� �������� ������ �ۼ�
	String sql = "SELECT COUNT(*) AS passCnt FROM basic_bbs WHERE  bbs_id = ? AND password = ?";
	
	System.out.println("sql: "+ sql);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	int passCnt = 0;
	try {
		statement = connection.prepareStatement(sql);
		statement.setInt(1, Integer.parseInt(bbs_id));
		statement.setString(2, password);
		resultset = statement.executeQuery();
		while(resultset.next()) {
			passCnt = resultset.getInt("passCnt");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("passCnt: "+ passCnt);
	
	if(passCnt != 1){
		%>
			<script type="text/javascript" >
				alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
				history.back();
			</script>
		<%
		return;
	}
	
	/**
	MariaDB(or MySQL) 1093 ���� �߻� ��
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
		alert("�Խñ��� �����Ͽ����ϴ�.");
		location.href = "<%=request.getContextPath()+"/bootstrap/nologin/list.jsp" %>";
		</script>
	<%
}else{
	%>
		<script type="text/javascript">
		//���н� �ڷΰ���
		alert("�Խñ��� ������ �����Ͽ����ϴ�.");
		<%-- location.href = "<%=request.getContextPath()+"/bbs/insert.jsp" %>"; --%>
		history.back();
		</script>
	<%
}


%>
</body>
</html>