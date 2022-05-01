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

	String sql = "UPDATE basic_bbs SET hits = hits+1 WHERE bbs_id=?";

	System.out.println("sql: " + sql);

	int resultCount = 0;
	try {
		statement = connection.prepareStatement(sql);
		statement.setInt(1, Integer.parseInt(bbs_id));
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
<!--부트스트랩 CDN 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

</head>
<body>
<div class="container">
	<nav class="navbar navbar-light bg-light">
  <div class="container-fluid">
    <span class="navbar-text ">
		<h4>부트스트랩 게시판 테스트 [프로젝트명: 비로그인 게시판]</h4>
    </span>
  </div>
</nav>
<br/>
<form>
  <div class="row mb-3">
    <label for="inputEmail3" class="col-sm-2 col-form-label">제목</label>
    <div class="col-sm-10">
      [<%=map.get("bbs_id")%>] <%=map.get("subject")%>
    </div>
  </div>
  <div class="row mb-3">
    <label for="inputEmail3" class="col-sm-2 col-form-label">글쓴이</label>
    <div class="col-sm-10">
      <%=map.get("user_name")%>
    </div>
  </div>
  <div class="row mb-3">
    <label for="inputEmail3" class="col-sm-2 col-form-label">조회수</label>
    <div class="col-sm-10">
      <%=map.get("hits")%>
    </div>
  </div>
  <div class="row mb-3">
    <label for="inputEmail3" class="col-sm-2 col-form-label">등록일자</label>
    <div class="col-sm-10">
     <%=map.get("regist_date")%>
    </div>
  </div>
  <div class="row mb-3">
    <label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
    <div class="col-sm-10">
      <input type="password" id="password" name="password" value="" size="50" class="form-control">
    </div>
  </div>
  <div class="mb-3" style="border: 1px solid grey; padding:20px;">
	  <!-- <label for="exampleFormControlTextarea1" class="form-label">내용</label>
	  <textarea class="form-control" id="exampleFormControlTextarea1" rows="5">
		
	  </textarea> -->
	  <%=map.get("contents")%>
	</div>
  <!-- <fieldset class="row mb-3">
    <legend class="col-form-label col-sm-2 pt-0">Radios</legend>
    <div class="col-sm-10">
      <div class="form-check">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
        <label class="form-check-label" for="gridRadios1">
          First radio
        </label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
        <label class="form-check-label" for="gridRadios2">
          Second radio
        </label>
      </div>
      <div class="form-check disabled">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios3" value="option3" disabled>
        <label class="form-check-label" for="gridRadios3">
          Third disabled radio
        </label>
      </div>
    </div>
  </fieldset> 
  <div class="row mb-3">
    <div class="col-sm-10 offset-sm-2">
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="gridCheck1">
        <label class="form-check-label" for="gridCheck1">
          Example checkbox
        </label>
      </div>
    </div>
  </div>-->
  
  
  <!-- <a href="<%=request.getContextPath()%>/bootstrap/nologin/list.jsp" class="btn btn-primary">저장</a> 
  <a href="<%=request.getContextPath()%>/bootstrap/nologin/updateProcess.jsp" class="btn btn-primary">수정</a>
  <a href="<%=request.getContextPath()%>/bootstrap/nologin/deleteProcess.jsp" class="btn btn-primary">삭제</a>
  -->
  <a href="<%=request.getContextPath()%>/bootstrap/nologin/list.jsp" class="btn btn-primary">목록</a>
</form>
	
	<!-- <table border="1">
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
	</form> -->
</body>
</html>