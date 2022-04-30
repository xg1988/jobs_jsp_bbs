<%@page import="java.sql.SQLException"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	//�ڹ� ����

	// �Է� �� ��ȿ�� �˻�
	String bbs_id = "0";
	if (!"".equals(request.getParameter("bbs_id")) && request.getParameter("bbs_id") != null) {
		bbs_id = request.getParameter("bbs_id");
	}
	System.out.println("pageNo: " + bbs_id);

	// DBȯ�� �Է�
	String db_url = "jdbc:mysql://127.0.0.1:3306/chosu_scheme?useUnicode=true&characterEncoding=euckr";
	String db_username = "root";
	String db_password = "1234";

	// DB Ŀ�ؼ� ��ü ����
	Connection connection = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection(db_url, db_username, db_password);
	} catch (Exception e) {
		e.printStackTrace();
	}

	// ��ȸ�� ������Ʈ 

	PreparedStatement statement = null;
	ResultSet resultset = null;

	String sql = "UPDATE basic_bbs SET hits=(SELECT IFNULL(MAX(hits)+1, 0) ";
	sql += "FROM basic_bbs ALIAS_FOR_SUBQUERY WHERE bbs_id=?) WHERE bbs_id=?";

	System.out.println("sql: " + sql);

	int resultCount = 0;
	try {
		statement = connection.prepareStatement(sql);
		statement.setInt(1, Integer.parseInt(bbs_id));
		statement.setInt(2, Integer.parseInt(bbs_id));
		resultCount = statement.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("resultCount: " + resultCount);

	// �Խñ� �� ��ü ��������

	statement = null;
	resultset = null;

	// �Խñ� ��� �������� ������ �ۼ�
	String sql2 = "SELECT bbs_id, subject, `contents`, user_name, hits, regist_date";
	sql2 += " FROM basic_bbs WHERE bbs_id= ?";

	System.out.println("sql2: " + sql2);

	HashMap<String, Object> map = new HashMap<String, Object>();

	try {
		statement = connection.prepareStatement(sql2);
		statement.setInt(1, Integer.parseInt(bbs_id));
		resultset = statement.executeQuery();
		while (resultset.next()) {
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
		if (resultset != null) {
			try {
				resultset.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (statement != null) {
			try {
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (connection != null) {
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
<title>�Խñ� �󼼺���</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/bbs/nologin/list.jsp">����Ʈ</a>
	<table border="1">
		<tr>
			<td>�Խñ� ���̵�</td>
			<td><%=map.get("bbs_id")%></td>
		</tr>
		<tr>
			<td>�̸�</td>
			<td><%=map.get("user_name")%></td>
		</tr>
		<tr>
			<td>�Խñ� ����</td>
			<td><%=map.get("subject")%></td>
		</tr>
		<tr>
			<td>�Խñ� ����</td>
			<td><%=map.get("contents")%></td>
		</tr>
		<tr>
			<td>��ȸ��</td>
			<td><%=map.get("hits")%></td>
		</tr>
		<tr>
			<td>�������</td>
			<td><%=map.get("regist_date")%></td>
		</tr>
	</table>
	<input type="button"
		onclick="location.href='<%=request.getContextPath()%>/bbs/nologin/update.jsp?bbs_id=<%=bbs_id%>'"
		value="����">
	<form
		action="<%=request.getContextPath()%>/bbs/nologin/deleteProcess.jsp?bbs_id=<%=bbs_id%>"
		name="deleteForm" id="deleteForm" method="post">
		<input type="password" id="password" name="password"
			placeholder="��й�ȣ �Է�"> <input type="submit" value="����">
	</form>
</body>
</html>