<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	session.invalidate();	// 세션 종료 처리
%>
<script type="text/javascript"> 
	alert("로그아웃 되었습니다.");
	location.href = "<%=request.getContextPath()+"/bbs/login.jsp" %>";
</script>