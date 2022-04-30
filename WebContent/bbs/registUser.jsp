<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입 페이지</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/bbs/registUserProcess.jsp" method="post">
<h1>회원가입 페이지</h1><br/>
	아이디: <input type="text" id="webUserId" name="webUserId" placeholder="아이디"><br/>
	비밀번호: <input type="password" id="webUserPassword" name="webUserPassword" placeholder="비밀번호"><br/>
	이름(닉네임):<input type="text" id="user_name" name="user_name" placeholder="이름(닉네임)"><br/>
	생일:<input type="date" id="birthday" name="birthday"><br/>
	이메일: <input type="email" id="email" name="email" placeholder="이메일주소"><br/>
	
	<input type="hidden" id="webLoginType" name="webLoginType" value="일반">
	
	<input type="submit" value="제출">
	<input type="button" value="취소" onclick="location.href='<%=request.getContextPath()%>/bbs/login.jsp'"><br/>
	<!-- <input type="button" value="아이디/비밀번호 찾기"> --> <!-- 추후개발 -->
</form>
</body>
</html>