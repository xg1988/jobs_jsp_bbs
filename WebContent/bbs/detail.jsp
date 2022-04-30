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
	if(!"Y".equals(session.getAttribute("loginYn"))){
	%>
		<script type="text/javascript">
			alert("해당 게시판을 이용하려면 로그인이 필요합니다.");
			location.href = "<%=request.getContextPath()+"/bbs/login.jsp" %>";
		</script>
	<%
		return; // if문에 해당하면 jsp 종료하기 위해서 return 추가
	}
	//회원정보 세팅
	String user_id = (String)session.getAttribute("webUserId"); 
	String user_name = (String)session.getAttribute("user_name"); 
	String email = (String)session.getAttribute("email"); 
	String birthday = (String)session.getAttribute("birthday"); 
	
	// 입력 값 유효성 검사
	String bbs_id = "0";
	if(!"".equals(request.getParameter("bbs_id")) && request.getParameter("bbs_id") != null){
		bbs_id = request.getParameter("bbs_id");
	}
	System.out.println("pageNo: "+ bbs_id);

	// DB환경 입력
	String db_url = "jdbc:mysql://127.0.0.1:3306/chosu_scheme?useUnicode=true&characterEncoding=euckr";
	String db_username = "root";
	String db_password = "1234";
	
	// DB 커넥션 객체 생성
	Connection connection = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection(db_url, db_username, db_password);
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	// 조회수 업데이트 
	
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
	
	// 게시글 상세 객체 가져오기
	
	statement = null;
	resultset = null;
	
 	// 게시글 목록 가져오는 쿼리문 작성
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
<title>게시글 상세보기</title>
</head>
<body>
<a href="<%=request.getContextPath()%>/bbs/list.jsp">리스트</a>
<h1>게시판 상세보기</h1><br/>
<span>[회원정보] 사용자아이디: <%=user_id %>, 이름: <%=user_name %> , 이메일: <%=email%>, 생일: <%=birthday %></span><!-- 세션으로 회원정보 출력-->
<a href="<%=request.getContextPath()%>/bbs/logoutProcess.jsp">[로그아웃]</a> <!-- 로그아웃 처리 이동 -->
<table border="1">
	<tr>
		<td>게시글 아이디</td>
		<td><%=map.get("bbs_id") %></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><%=map.get("user_name") %></td>
	</tr>
	<tr>
		<td>게시글 제목</td>
		<td><%=map.get("subject") %></td>
	</tr>
	<tr>
		<td>게시글 내용</td>
		<td><%=map.get("contents") %></td>
	</tr>
	<tr>
		<td>조회수</td>
		<td><%=map.get("hits") %></td>
	</tr>
	<tr>
		<td>등록일자</td>
		<td><%=map.get("regist_date") %></td>
	</tr>
</table>
<!-- 세션의 user_id와 DB에서 꺼내온 게시글의 user_id가 일치할 경우에만 수정 삭제 가능 -->
<%
	if(user_id.equals(map.get("user_id"))){
%>
<input type="button" onclick="location.href='<%=request.getContextPath()%>/bbs/update.jsp?bbs_id=<%=bbs_id%>'" value="수정">
<form action="<%=request.getContextPath()%>/bbs/deleteProcess.jsp?bbs_id=<%=bbs_id%>" name="deleteForm" id="deleteForm" method="post">
	<input type="submit"  value="삭제">
</form>
<%		
	}
%>

</body>
</html>