<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
 <%
 
 //�ڹ� ����
 	if(!"Y".equals(session.getAttribute("loginYn"))){
 	%>
 		<script type="text/javascript">
 			alert("�ش� �Խ����� �̿��Ϸ��� �α����� �ʿ��մϴ�.");
 			location.href = "<%=request.getContextPath()+"/bbs/login.jsp" %>";
 		</script>
 	<%
 		return; // if���� �ش��ϸ� jsp �����ϱ� ���ؼ� return �߰�
 	}
	//ȸ������ ����
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
<h1>�Խñ� �Է�</h1>
<br/>
<span>[ȸ������] ����ھ��̵�: <%=user_id %>, �̸�: <%=user_name %> , �̸���: <%=email%>, ����: <%=birthday %></span><!-- �������� ȸ������ ���-->
<a href="<%=request.getContextPath()%>/bbs/logoutProcess.jsp">[�α׾ƿ�]</a> <!-- �α׾ƿ� ó�� �̵� --><br/>
<form action="<%=request.getContextPath()%>/bbs/insertProcess.jsp" method="post">
<table>
	<!-- �α��� �Խ��ǿ��� �̸�, ��й�ȣ�� �ʿ����� �ʴ�. -->
	<!-- <tr>
		<td>�̸� :</td>
		<td><input type="text" id="user_name" name="user_name" value="" size="50"></td>
	</tr>
	<tr>
		<td>��й�ȣ :</td>
		<td><input type="password" id="password" name="password" value="" size="50"></td>
	</tr> -->
	<tr>
		<td>���� :</td>
		<td><input type="text" id="subject" name="subject" value="" size="50"></td>
	</tr>
	<tr>
		<td>���� :</td>
		<td><textarea rows="30" cols="50" id="contents" name="contents"></textarea></td>
	</tr>
</table>
	<input type="submit" value="�Է�"><input type="button" value="���" onclick="location.href='<%=request.getContextPath()%>/bbs/list.jsp'">
</form>
</body>
</html>