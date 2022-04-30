<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 페이지</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/bbs/loginProcess.jsp" method="post">
	<h1>로그인 페이지</h1><br/>
	아이디: <input type="text" id="webUserId" name="webUserId" placeholder="아이디"><br/>
	비밀번호: <input type="password" id="webUserPassword" name="webUserPassword" placeholder="비밀번호"><br/>
	<input type="hidden" id="webLoginType" name="webLoginType" value="일반">
	
	<input type="submit" value="로그인">
	<input type="button" value="회원가입" onclick="location.href='<%=request.getContextPath()%>/bbs/registUser.jsp'"><br/>
	<!-- <input type="button" value="아이디/비밀번호 찾기"> --> <!-- 추후개발 -->
</form>
</body>
</html>