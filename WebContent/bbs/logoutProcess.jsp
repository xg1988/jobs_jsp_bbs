<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	session.invalidate();	// ���� ���� ó��
%>
<script type="text/javascript"> 
	alert("�α׾ƿ� �Ǿ����ϴ�.");
	location.href = "<%=request.getContextPath()+"/bbs/login.jsp" %>";
</script>