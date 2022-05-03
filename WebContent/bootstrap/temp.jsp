<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script>
	function formSubmit(){
		
	}
	
</script>
</head>
<body>
	<form action="https://www.tistory.com/apis/post/write" method="post" name="testFrm" accept-charset="UTF-8">
		<input type="hidden" name="access_token" value="785112b5245fd942f58ff21317dff666_1c2b8fd64e88dd09c2e7a9f435b0eee1">
		<input type="hidden" name="output" value="json">
		<input type="hidden" name="blogName" value="scflow">
		<input type="hidden" name="title" value="API테스트">
		<input type="hidden" name="content" value="API테스트 <img src='https://www.happycampus.com/images/mainTopImage/1/47jkqrsxCR.jpg' alt='test'> <br/><br/><br/><br/>테스트입니다<br/><br/>잡스">
		<input type="hidden" name="visibility" value="3">
		<input type="hidden" name="category" value="496190">
		<input type="hidden" name="published" value="3">
		<input type="hidden" name="slogan" value="">
		<input type="hidden" name="tag" value="test, whod">
		<input type="hidden" name="acceptComment" value="1">
		<input type="hidden" name="password" value="">
		<input type="submit" value="입력">
	</form>
</body>
</html>