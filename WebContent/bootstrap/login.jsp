<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 페이지</title>
<!--부트스트랩 CDN 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style type="text/css">
	.login_container{
		position: absolute;
		top:0;
		bottom: 0;
		left: 0;
		right: 0;
		margin: auto;
		width: 95%;
	}
</style>
</head>
<body>
<form action="<%=request.getContextPath()%>/bbs/loginProcess.jsp" method="post">
	<div class="login_container">
	<nav class="navbar navbar-light bg-light">
	  <div class="container-fluid">
	    <span class="navbar-text ">
			<h4>로그인 페이지</h4>
			
	    </span>
	  </div>
	</nav><br/>
	<div class="mb-3">
	    <label for="webUserId" class="form-label">아이디</label>
	    <input type="text" class="form-control" id="webUserId" name="webUserId">
	  </div>
	  <div class="mb-3">
	    <label for="webUserPassword" class="form-label">비밀번호</label>
	    <input type="password" class="form-control" id="webUserPassword" name="webUserPassword">
	  </div>
	  <button type="submit" class="btn btn-primary">로그인</button>
	  <a href="<%=request.getContextPath()%>/bootstrap/registUser.jsp" class="btn btn-primary">회원가입<a>
	  </div>
</form>
</body>
</html>