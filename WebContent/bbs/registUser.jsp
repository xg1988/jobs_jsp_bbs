<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������ ������</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/bbs/registUserProcess.jsp" method="post">
<h1>ȸ������ ������</h1><br/>
	���̵�: <input type="text" id="webUserId" name="webUserId" placeholder="���̵�"><br/>
	��й�ȣ: <input type="password" id="webUserPassword" name="webUserPassword" placeholder="��й�ȣ"><br/>
	�̸�(�г���):<input type="text" id="user_name" name="user_name" placeholder="�̸�(�г���)"><br/>
	����:<input type="date" id="birthday" name="birthday"><br/>
	�̸���: <input type="email" id="email" name="email" placeholder="�̸����ּ�"><br/>
	
	<input type="hidden" id="webLoginType" name="webLoginType" value="�Ϲ�">
	
	<input type="submit" value="����">
	<input type="button" value="���" onclick="location.href='<%=request.getContextPath()%>/bbs/login.jsp'"><br/>
	<!-- <input type="button" value="���̵�/��й�ȣ ã��"> --> <!-- ���İ��� -->
</form>
</body>
</html>