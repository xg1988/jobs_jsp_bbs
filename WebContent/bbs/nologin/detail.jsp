<%@page import="java.sql.SQLException"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	//자바 시작

	// 입력 값 유효성 검사
	String bbs_id = "0";
	if (!"".equals(request.getParameter("bbs_id")) && request.getParameter("bbs_id") != null) {
		bbs_id = request.getParameter("bbs_id");
	}
	System.out.println("pageNo: " + bbs_id);

	// DB환경 입력
	String db_url = "jdbc:mysql://127.0.0.1:3306/chosu_scheme?useUnicode=true&characterEncoding=euckr";
	String db_username = "root";
	String db_password = "1234";

	// DB 커넥션 객체 생성
	Connection connection = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection(db_url, db_username, db_password);
	} catch (Exception e) {
		e.printStackTrace();
	}

	// 조회수 업데이트 

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

	// 게시글 상세 객체 가져오기

	statement = null;
	resultset = null;

	// 게시글 목록 가져오는 쿼리문 작성
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
<title>게시글 상세보기</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/bbs/nologin/list.jsp">리스트</a>
	<table border="1">
		<tr>
			<td>게시글 아이디</td>
			<td><%=map.get("bbs_id")%></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=map.get("user_name")%></td>
		</tr>
		<tr>
			<td>게시글 제목</td>
			<td><%=map.get("subject")%></td>
		</tr>
		<tr>
			<td>게시글 내용</td>
			<td><%=map.get("contents")%></td>
		</tr>
		<tr>
			<td>조회수</td>
			<td><%=map.get("hits")%></td>
		</tr>
		<tr>
			<td>등록일자</td>
			<td><%=map.get("regist_date")%></td>
		</tr>
	</table>
	<input type="button"
		onclick="location.href='<%=request.getContextPath()%>/bbs/nologin/update.jsp?bbs_id=<%=bbs_id%>'"
		value="수정">
	<form
		action="<%=request.getContextPath()%>/bbs/nologin/deleteProcess.jsp?bbs_id=<%=bbs_id%>"
		name="deleteForm" id="deleteForm" method="post">
		<input type="password" id="password" name="password"
			placeholder="비밀번호 입력"> <input type="submit" value="삭제">
	</form>
</body>
</html>