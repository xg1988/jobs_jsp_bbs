<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="java.sql.Connection" %>
 <%@ page import="java.sql.DriverManager" %>
 <%@ page import="java.sql.PreparedStatement" %>
 <%@ page import="java.sql.ResultSet" %>
 <%@ page import="java.sql.SQLException" %>
 <%@ page import="java.sql.Statement" %>
 <%@ page import="java.util.ArrayList" %>
 <%@ page import="java.util.List" %>   
 <%
 	//�ڹ� ����
 	
 	// �Է� �� ��ȿ�� �˻�
 	String pageNo = "1";
 	if(!"".equals(request.getParameter("pageNo")) && request.getParameter("pageNo") != null){
 		pageNo = request.getParameter("pageNo");
 	}
 	System.out.println("pageNo: "+ pageNo);
 	
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
	
	// �Խñ� ��ü ���� ��������
	
	PreparedStatement statement = null;
	ResultSet resultset = null;
	
	String sql = "SELECT COUNT(*) FROM basic_bbs";
	
	System.out.println("sql: "+ sql);
	
	int totalRowCount = 0;
	try {
		statement = connection.prepareStatement(sql);
		resultset = statement.executeQuery();
		while(resultset.next()) {
			totalRowCount = resultset.getInt(1);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} 
	
	// �Խñ� ��� ��ü ��������
	
	statement = null;
	resultset = null;
	
	int tmpPageNo = Integer.parseInt(pageNo); 
 	int beginRow = (tmpPageNo -1) *10;
 	int bbsPerRow = 10;
 	
 	// �Խñ� ��� �������� ������ �ۼ�
	String sql2 = "SELECT bbs_id, subject, `contents`, user_name, hits, regist_date";
	sql2+= " FROM basic_bbs ORDER BY regist_date DESC LIMIT ?, ?";
	
	System.out.println("sql: "+ sql2);
	System.out.println("beginRow: "+ beginRow);
	System.out.println("bbsPerRow: "+ bbsPerRow);
	
	List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	try {
		statement = connection.prepareStatement(sql2);
		statement.setInt(1, beginRow);
		statement.setInt(2, bbsPerRow);
		resultset = statement.executeQuery();
		while(resultset.next()) {
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("bbs_id", resultset.getString("bbs_id"));
			map.put("subject", resultset.getString("subject"));
			map.put("contents", resultset.getString("contents"));
			map.put("user_name", resultset.getString("user_name"));
			map.put("hits", resultset.getInt("hits"));
			map.put("regist_date", resultset.getString("regist_date"));
			
			list.add(map);
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
<h1>��α��� �Խ���</h1>
��ü �ۼ� :<%=totalRowCount %>/ ����Ʈ������: <%=list.size()%>
<br/>
<a href="<%=request.getContextPath()%>/bbs/nologin/insert.jsp">�Խñ� �Է�</a>

<table border="1">
        <thead>
            <tr>
            	<th>����</th>
                <th>����</th>
                <th>�ۼ����̸�</th>
                <th>��ȸ��</th>
                <th>�ۼ�����</th>
            </tr>
        </thead>
        <tbody>
        	<%
				if(list != null && list.size() > 0){
					for(HashMap<String, Object> map: list){
			%>
					<tr>
						<td><%=map.get("bbs_id") %></td>
						<td>
							<a href="<%=request.getContextPath()%>/bbs/nologin/detail.jsp?bbs_id=<%=map.get("bbs_id") %>">
								<%=map.get("subject") %>
							</a>
						</td>
						<td><%=map.get("user_name") %></td>
						<td><%=map.get("hits") %></td>
						<td><%=map.get("regist_date") %></td>
					</tr>
			<%
					}
				}
			%>
        </tbody>
</table>

<%-- 
    <div>
        <a href="<%=request.getContextPath()%>/board/boardAddForm.jsp">�Խñ� �Է�</a>
    </div> --%>
<%
    int lastPage = totalRowCount/bbsPerRow;
    if(totalRowCount%bbsPerRow != 0) {
        lastPage++;
    }
    
    System.out.println("lastPage: "+ lastPage);
	System.out.println("tmpPageNo: "+ tmpPageNo);
	System.out.println("request.getContextPath(): "+ request.getContextPath());
%>
    <div>
<%
        if(tmpPageNo>1) {
%>
            <a href="<%=request.getContextPath()%>/bbs/nologin/list.jsp?pageNo=<%=tmpPageNo-1%>">����</a>
<%}%>

<%
	for(int i= 1; i<= lastPage; i++){
%>
	[<a href="<%=request.getContextPath()%>/bbs/nologin/list.jsp?pageNo=<%=i%>"><%=i%></a>] 
<%
	}
%>

<%
        if(tmpPageNo < lastPage) {
%>
 
            <a href="<%=request.getContextPath()%>/bbs/nologin/list.jsp?pageNo=<%=tmpPageNo+1%>">����</a>
<%
        }
%>
    </div>

</body>
</html>