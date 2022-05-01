<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<!--부트스트랩 CDN 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

</head>
<body>
<form action="<%=request.getContextPath()%>/bootstrap/nologin/insertProcess.jsp" method="post">
<div class="container">
	<nav class="navbar navbar-light bg-light">
  <div class="container-fluid">
    <span class="navbar-text ">
		<h4>부트스트랩 게시판 테스트 [프로젝트명: 비로그인 게시판]</h4>
    </span>
  </div>
</nav>
<div class="btnGroup">
  <button type="submit" class="btn btn-primary">저장</button>
  <a href="<%=request.getContextPath()%>/bootstrap/nologin/list.jsp" class="btn btn-primary">목록</a>
  </div>
  
  
  <div class="row mb-3">
    <label for="inputEmail3" class="col-sm-2 col-form-label">제목</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="subject" name="subject">
    </div>
  </div>
  <div class="row mb-3">
    <label for="inputEmail3" class="col-sm-2 col-form-label">글쓴이</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="user_name" name="user_name" value="" size="50">
    </div>
  </div>
  <!-- <div class="row mb-3">
    <label for="inputEmail3" class="col-sm-2 col-form-label">등록일자</label>
    <div class="col-sm-10">
      <input type="email" class="form-control" id="inputEmail3">
    </div>
  </div> -->
  <div class="row mb-3">
    <label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="password" name="password">
    </div>
  </div>
  <div class="mb-3">
	  <label for="exampleFormControlTextarea1" class="form-label">내용</label>
	  <textarea class="form-control" id="contents" name="contents" rows="5"></textarea>
	</div>
 <!--  <fieldset class="row mb-3">
    <legend class="col-form-label col-sm-2 pt-0">Radios</legend>
    <div class="col-sm-10">
      <div class="form-check">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
        <label class="form-check-label" for="gridRadios1">
          First radio
        </label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
        <label class="form-check-label" for="gridRadios2">
          Second radio
        </label>
      </div>
      <div class="form-check disabled">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios3" value="option3" disabled>
        <label class="form-check-label" for="gridRadios3">
          Third disabled radio
        </label>
      </div>
    </div>
  </fieldset> 
  <div class="row mb-3">
    <div class="col-sm-10 offset-sm-2">
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="gridCheck1">
        <label class="form-check-label" for="gridCheck1">
          Example checkbox
        </label>
      </div>
    </div>
  </div>
   <div class="row mb-3">
    <label for="inputEmail3" class="col-sm-2 col-form-label">댓글입력</label>
    <div class="col-sm-10">
    
    	<textarea class="form-control" id="exampleFormControlTextarea1" rows="2"></textarea>
    </div>
    <div class="mb-3">
	  <button type="submit" class="btn btn-primary">저장</button>
	</div>
   <!--  <button type="submit" class="btn btn-primary">저장</button> -->
    
    <!-- 
  <div class="row mb-3">
    <label for="inputEmail3" class="col-sm-2 col-form-label">댓글</label>
    <div class="col-sm-10">
    
     <ul class="list-group">
  <li class="list-group-item">An item</li>
  <li class="list-group-item">A second item</li>
  <li class="list-group-item">A third item</li>
  <li class="list-group-item">A fourth item</li>
  <li class="list-group-item">And a fifth one</li>
</ul>
    </div> -->
    
     <div class="btnGroup">
  <button type="submit" class="btn btn-primary">저장</button>
  <a href="<%=request.getContextPath()%>/bootstrap/nologin/list.jsp" class="btn btn-primary">목록</a>
  </div>
  </div>
 
  
</form>

</body>
</html>