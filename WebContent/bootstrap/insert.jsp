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
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>게시글 입력</h1>
<br/>
<span>[회원정보] 사용자아이디: <%=user_id %>, 이름: <%=user_name %> , 이메일: <%=email%>, 생일: <%=birthday %></span><!-- 세션으로 회원정보 출력-->
<a href="<%=request.getContextPath()%>/bbs/logoutProcess.jsp">[로그아웃]</a> <!-- 로그아웃 처리 이동 --><br/>
<form action="<%=request.getContextPath()%>/bbs/insertProcess.jsp" method="post">
<table>
	<!-- 로그인 게시판에는 이름, 비밀번호가 필요하지 않다. -->
	<!-- <tr>
		<td>이름 :</td>
		<td><input type="text" id="user_name" name="user_name" value="" size="50"></td>
	</tr>
	<tr>
		<td>비밀번호 :</td>
		<td><input type="password" id="password" name="password" value="" size="50"></td>
	</tr> -->
	<tr>
		<td>제목 :</td>
		<td><input type="text" id="subject" name="subject" value="" size="50"></td>
	</tr>
	<tr>
		<td>내용 :</td>
		<td><textarea rows="30" cols="50" id="contents" name="contents"></textarea></td>
	</tr>
</table>
	<input type="submit" value="입력"><input type="button" value="취소" onclick="location.href='<%=request.getContextPath()%>/bbs/list.jsp'">
</form>
</body>
</html>