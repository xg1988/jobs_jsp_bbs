<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
�Խñ� �Է�
<br/>
<form action="<%=request.getContextPath()%>/bbs/nologin/insertProcess.jsp" method="post">
<table>
	<tr>
		<td>�̸� :</td>
		<td><input type="text" id="user_name" name="user_name" value="" size="50"></td>
	</tr>
	<tr>
		<td>��й�ȣ :</td>
		<td><input type="password" id="password" name="password" value="" size="50"></td>
	</tr>
	<tr>
		<td>���� :</td>
		<td><input type="text" id="subject" name="subject" value="" size="50"></td>
	</tr>
	<tr>
		<td>���� :</td>
		<td><textarea rows="30" cols="50" id="contents" name="contents"></textarea></td>
	</tr>
</table>
	<input type="submit" value="�Է�">
	<input type="button" value="���" onclick="location.href='<%=request.getContextPath()%>/bbs/nologin/list.jsp'">
</form>
</body>
</html>