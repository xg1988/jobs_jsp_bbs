<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α��� ������</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/bbs/loginProcess.jsp" method="post">
	<h1>�α��� ������</h1><br/>
	���̵�: <input type="text" id="webUserId" name="webUserId" placeholder="���̵�"><br/>
	��й�ȣ: <input type="password" id="webUserPassword" name="webUserPassword" placeholder="��й�ȣ"><br/>
	<input type="hidden" id="webLoginType" name="webLoginType" value="�Ϲ�">
	
	<input type="submit" value="�α���">
	<input type="button" value="ȸ������" onclick="location.href='<%=request.getContextPath()%>/bbs/registUser.jsp'"><br/>
	<!-- <input type="button" value="���̵�/��й�ȣ ã��"> --> <!-- ���İ��� -->
</form>
</body>
</html>