<%@page import="java.sql.SQLException"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	//자바 시작

	// 입력 값 유효성 검사
	String bbs_id = "0";
	if (!"".equals(request.getParameter("bbs_id")) && request.getParameter("bbs_id") != null) {
		bbs_id = request.getParameter("bbs_id");
	}
	System.out.println("bbs_id: " + bbs_id);

	//DB환경 입력
		String db_url = "jdbc:mysql://us-cdbr-east-05.cleardb.net:3306/heroku_03024d82a802629?characterEncoding=UTF-8&serverTimezone=UTC";
		String db_username = "bb5fc12e7ab829";
		String db_password = "316e7fa5";
		
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

	// 게시글 목록 가져오는 쿼리문 작성
	String sql = "SELECT bbs_id, subject, `contents`, user_name, hits, regist_date";
	sql += " FROM basic_bbs WHERE bbs_id= ?";

	System.out.println("sql: " + sql);

	HashMap<String, Object> map = new HashMap<String, Object>();

	try {
		statement = connection.prepareStatement(sql);
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
<title>Insert title here</title>
</head>
<body>
	게시글 수정
	<br />
	<form
		action="<%=request.getContextPath()%>/bbs/nologin/updateProcess.jsp?bbs_id=<%=bbs_id%>"
		method="post">
		<table>
			<tr>
				<td>이름 :</td>
				<td><input type="text" id="user_name" name="user_name"
					value="<%=map.get("user_name")%>" size="50"></td>
			</tr>
			<tr>
				<td>비밀번호 :</td>
				<td><input type="password" id="password" name="password"
					value="" size="50"></td>
			</tr>
			<tr>
				<td>제목 :</td>
				<td><input type="text" id="subject" name="subject"
					value="<%=map.get("subject")%>" size="50"></td>
			</tr>
			<tr>
				<td>내용 :</td>
				<td><textarea rows="30" cols="50" id="contents" name="contents">
				<%=map.get("contents")%></textarea></td>
			</tr>
		</table>
		<input type="submit" value="수정"><input type="button"
			value="취소"
			onclick="location.href='<%=request.getContextPath()%>/bbs/nologin/list.jsp'">
	</form>
</body>
</html>