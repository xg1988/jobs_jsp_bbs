<%@page import="java.sql.SQLException"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//�ڹ� ����
	if(!"Y".equals(session.getAttribute("loginYn"))){
	%>
		<script type="text/javascript">
			alert("�ش� �Խ����� �̿��Ϸ��� �α����� �ʿ��մϴ�.");
			location.href = "<%=request.getContextPath()+"/bbs/login.jsp" %>";
		</script>
	<%
		return; // if���� �ش��ϸ� jsp �����ϱ� ���ؼ� return �߰�
	}
	//ȸ������ ����
	String user_id = (String)session.getAttribute("webUserId"); 
	String user_name = (String)session.getAttribute("user_name"); 
	String email = (String)session.getAttribute("email"); 
	String birthday = (String)session.getAttribute("birthday"); 
	
	// �Է� �� ��ȿ�� �˻�
	String bbs_id = "0";
	if(!"".equals(request.getParameter("bbs_id")) && request.getParameter("bbs_id") != null){
		bbs_id = request.getParameter("bbs_id");
	}
	System.out.println("bbs_id: "+ bbs_id);

	// DBȯ�� �Է�
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
	
	// ��ȸ�� ������Ʈ 
	
	PreparedStatement statement = null;
	ResultSet resultset = null;
	
 	// �Խñ� ��� �������� ������ �ۼ�
	String sql = "SELECT bbs_id, subject, `contents`, user_name, hits, regist_date";
	sql+= " FROM basic_bbs WHERE bbs_id= ?";
	
	System.out.println("sql: "+ sql);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	try {
		statement = connection.prepareStatement(sql);
		statement.setInt(1, Integer.parseInt(bbs_id));
		resultset = statement.executeQuery();
		while(resultset.next()) {
			map.put("bbs_id", resultset.getString("bbs_id"));
			map.put("subject", resultset.getString("subject"));
			map.put("contents", resultset.getString("contents"));
			map.put("user_name", resultset.getString("user_name"));
			map.put("hits", resultset.getInt("hits"));
			map.put("regist_date", resultset.getString("regist_date"));
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
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
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>�Խñ� ����</h1><br/>
<span>[ȸ������] ����ھ��̵�: <%=user_id %>, �̸�: <%=user_name %> , �̸���: <%=email%>, ����: <%=birthday %></span><!-- �������� ȸ������ ���-->
<a href="<%=request.getContextPath()%>/bbs/logoutProcess.jsp">[�α׾ƿ�]</a> <!-- �α׾ƿ� ó�� �̵� -->
<br/>
<form action="<%=request.getContextPath()%>/bbs/updateProcess.jsp?bbs_id=<%=bbs_id %>" method="post">
<table>
	<%-- <tr>
		<td>�̸� :</td>
		<td><input type="text" id="user_name" name="user_name" value="<%=map.get("user_name") %>" size="50"></td>
	</tr>
	<tr>
		<td>��й�ȣ :</td>
		<td><input type="password" id="password" name="password" value="" size="50"></td>
	</tr> --%>
	<tr>
		<td>���� :</td>
		<td><input type="text" id="subject" name="subject" value="<%=map.get("subject") %>" size="50"></td>
	</tr>
	<tr>
		<td>���� :</td>
		<td><textarea rows="30" cols="50" id="contents" name="contents"><%=map.get("contents") %></textarea></td>
	</tr>
</table>
	<input type="submit" value="����"><input type="button" value="���" onclick="location.href='<%=request.getContextPath()%>/bbs/list.jsp'">
</form>
</body>
</html>