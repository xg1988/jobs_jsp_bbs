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
 	String pageNo = "1";
 	if(!"".equals(request.getParameter("pageNo")) && request.getParameter("pageNo") != null){
 		pageNo = request.getParameter("pageNo");
 	}
 	System.out.println("pageNo: "+ pageNo);
 	

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
	
	// 게시글 전체 갯수 가져오기
	
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
	
	// 게시글 목록 객체 가져오기
	
	statement = null;
	resultset = null;
	
	int tmpPageNo = Integer.parseInt(pageNo); 
 	int beginRow = (tmpPageNo -1) *10;
 	int bbsPerRow = 10;
 	
 	// 게시글 목록 가져오는 쿼리문 작성
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
<h1>로그인 게시판</h1><br/>

<span>[회원정보] 사용자아이디: <%=user_id %>, 이름: <%=user_name %> , 이메일: <%=email%>, 생일: <%=birthday %></span><!-- 세션으로 회원정보 출력-->
<a href="<%=request.getContextPath()%>/bbs/logoutProcess.jsp">[로그아웃]</a> <!-- 로그아웃 처리 이동 -->
<br/>
전체 글수 :<%=totalRowCount %>/ 리스트사이즈: <%=list.size()%>
<br/>
<a href="<%=request.getContextPath()%>/bbs/insert.jsp">게시글 입력</a>

<table border="1">
        <thead>
            <tr>
            	<th>순번</th>
                <th>제목</th>
                <th>작성자이름</th>
                <th>조회수</th>
                <th>작성일자</th>
            </tr>
        </thead>
        <tbody>
        	<%
				if(list != null && list.size() > 0){
					for(HashMap<String, Object> map: list){
			%>
					<tr>
						<td><%=map.get("bbs_id") %></td>
						<td><a href="<%=request.getContextPath()%>/bbs/detail.jsp?bbs_id=<%=map.get("bbs_id") %>"><%=map.get("subject") %></a></td>
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
        <a href="<%=request.getContextPath()%>/board/boardAddForm.jsp">게시글 입력</a>
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
            <a href="<%=request.getContextPath()%>/bbs/list.jsp?pageNo=<%=tmpPageNo-1%>">이전</a>
<%}%>

<%
	for(int i= 1; i<= lastPage; i++){
%>
	[<a href="<%=request.getContextPath()%>/bbs/list.jsp?pageNo=<%=i%>"><%=i%></a>] 
<%
	}
%>

<%
        if(tmpPageNo < lastPage) {
%>
 
            <a href="<%=request.getContextPath()%>/bbs/list.jsp?pageNo=<%=tmpPageNo+1%>">다음</a>
<%
        }
%>
    </div>

</body>
</html>