<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	// �Էº�
	request.setCharacterEncoding("euc-kr"); // requset ��ü�� ���ڵ��� �����ش�. (�������� ������ �ѱ� ����)
	String password = request.getParameter("password");
	System.out.println("password:"+password);
	String bbs_id = request.getParameter("bbs_id");
	System.out.println("bbs_id:"+bbs_id);
	
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
		location.href = "<%=request.getContextPath()+"/bbs/nologin/list.jsp" %>";
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
