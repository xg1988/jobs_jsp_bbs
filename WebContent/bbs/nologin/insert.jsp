<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
게시글 입력
<br/>
<form action="<%=request.getContextPath()%>/bbs/nologin/insertProcess.jsp" method="post">
<table>
	<tr>
		<td>이름 :</td>
		<td><input type="text" id="user_name" name="user_name" value="" size="50"></td>
	</tr>
	<tr>
		<td>비밀번호 :</td>
		<td><input type="password" id="password" name="password" value="" size="50"></td>
	</tr>
	<tr>
		<td>제목 :</td>
		<td><input type="text" id="subject" name="subject" value="" size="50"></td>
	</tr>
	<tr>
		<td>내용 :</td>
		<td><textarea rows="30" cols="50" id="contents" name="contents"></textarea></td>
	</tr>
</table>
	<input type="submit" value="입력">
	<input type="button" value="취소" onclick="location.href='<%=request.getContextPath()%>/bbs/nologin/list.jsp'">
</form>
</body>
</html>