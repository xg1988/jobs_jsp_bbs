<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	// 입력부
	request.setCharacterEncoding("euc-kr"); // requset 객체의 인코딩을 맞춰준다. (세팅하지 않으면 한글 깨짐)
	
	String bbs_id = request.getParameter("bbs_id");
	System.out.println("bbs_id:"+bbs_id);
	

	// DB환경 입력
	String db_url = "jdbc:mysql://us-cdbr-east-05.cleardb.net:3306/heroku_03024d82a802629?characterEncoding=UTF-8&serverTimezone=UTC";
	String db_username = "bb5fc12e7ab829";
	String db_password = "316e7fa5";
	// DB 커넥션 객체 생성
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
	MariaDB(or MySQL) 1093 오류 발생 시
	https://finkle.tistory.com/118
	**/
	
	String sql2 = "DELETE FROM basic_bbs WHERE bbs_id=?";
	System.out.println("sql2: "+ sql2);
	
	int resultCnt = 0;
	try {
		statement = connection.prepareStatement(sql2);
		statement.setString(1, bbs_id);
		//쿼리실행에 따라서 성공하면 1 실패하면 0 을 리턴
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
		// 성공시 리스트 화면으로
		alert("게시글을 삭제하였습니다.");
		location.href = "<%=request.getContextPath()+"/bbs/list.jsp" %>";
		</script>
	<%
}else{
	%>
		<script type="text/javascript">
		//실패시 뒤로가기
		alert("게시글 삭제에 실패하였습니다.");
		<%-- location.href = "<%=request.getContextPath()+"/bbs/insert.jsp" %>"; --%>
		history.back();
		</script>
	<%
}


%>
</body>
</html>
