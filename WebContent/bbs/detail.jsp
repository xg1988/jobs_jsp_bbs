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
	System.out.println("pageNo: "+ bbs_id);

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
	
	String sql = "UPDATE basic_bbs SET hits=(SELECT IFNULL(MAX(hits)+1, 0) FROM basic_bbs ALIAS_FOR_SUBQUERY WHERE bbs_id=?) WHERE bbs_id=?";
	
	System.out.println("sql: "+ sql);
	
	int resultCount = 0;
	try {
		statement = connection.prepareStatement(sql);
		statement.setInt(1, Integer.parseInt(bbs_id));
		statement.setInt(2, Integer.parseInt(bbs_id));
		resultCount = statement.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	} 
	System.out.println("resultCount: "+ resultCount);
	
	// �Խñ� �� ��ü ��������
	
	statement = null;
	resultset = null;
	
 	// �Խñ� ��� �������� ������ �ۼ�
	String sql2 = "SELECT bbs_id, subject, `contents`, user_id , user_name, hits, regist_date";
	sql2+= " FROM basic_bbs WHERE bbs_id= ?";
	
	System.out.println("sql2: "+ sql2);
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	try {
		statement = connection.prepareStatement(sql2);
		statement.setInt(1, Integer.parseInt(bbs_id));
		resultset = statement.executeQuery();
		while(resultset.next()) {
			map.put("bbs_id", resultset.getString("bbs_id"));
			map.put("subject", resultset.getString("subject"));
			map.put("user_id", resultset.getString("user_id"));
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
<title>�Խñ� �󼼺���</title>
</head>
<body>
<a href="<%=request.getContextPath()%>/bbs/list.jsp">����Ʈ</a>
<h1>�Խ��� �󼼺���</h1><br/>
<span>[ȸ������] ����ھ��̵�: <%=user_id %>, �̸�: <%=user_name %> , �̸���: <%=email%>, ����: <%=birthday %></span><!-- �������� ȸ������ ���-->
<a href="<%=request.getContextPath()%>/bbs/logoutProcess.jsp">[�α׾ƿ�]</a> <!-- �α׾ƿ� ó�� �̵� -->
<table border="1">
	<tr>
		<td>�Խñ� ���̵�</td>
		<td><%=map.get("bbs_id") %></td>
	</tr>
	<tr>
		<td>�̸�</td>
		<td><%=map.get("user_name") %></td>
	</tr>
	<tr>
		<td>�Խñ� ����</td>
		<td><%=map.get("subject") %></td>
	</tr>
	<tr>
		<td>�Խñ� ����</td>
		<td><%=map.get("contents") %></td>
	</tr>
	<tr>
		<td>��ȸ��</td>
		<td><%=map.get("hits") %></td>
	</tr>
	<tr>
		<td>�������</td>
		<td><%=map.get("regist_date") %></td>
	</tr>
</table>
<!-- ������ user_id�� DB���� ������ �Խñ��� user_id�� ��ġ�� ��쿡�� ���� ���� ���� -->
<%
	if(user_id.equals(map.get("user_id"))){
%>
<input type="button" onclick="location.href='<%=request.getContextPath()%>/bbs/update.jsp?bbs_id=<%=bbs_id%>'" value="����">
<form action="<%=request.getContextPath()%>/bbs/deleteProcess.jsp?bbs_id=<%=bbs_id%>" name="deleteForm" id="deleteForm" method="post">
	<input type="submit"  value="����">
</form>
<%		
	}
%>

</body>
</html>