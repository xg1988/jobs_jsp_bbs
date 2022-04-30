<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


</head>
<body onload="start()">
<div>001153/033fd090addea2382485344aa31027d92323420cd714a2bc4acf64288f2d8ccc

<script type="text/javascript">

const config = {
		  type: 'line',
		  data: {
			  labels: [
				  'January',
				  'February',
				  'March',
				  'April',
				  'May',
				  'June',
				  'June',
				],
			  datasets: [{
			    label: '환율정보추이 (일주일)',
			    backgroundColor: 'rgb(255, 99, 132)',
			    borderColor: 'rgb(255, 99, 132)',
			    data: [0, 10, 5, 2, 20, 30, 45, 50],
			  }]
			},
		  options: {}
		};

function start(){
	
	// === include 'setup' then 'config' above ===

	  var myChart = new Chart(
	    document.getElementById('myChart'),
	    config
	  );
	  var myChart2 = new Chart(
			    document.getElementById('myChart2'),
			    config
			  );
}	


</script>
  <canvas id="myChart"></canvas>
  <canvas id="myChart2"></canvas>
</div>
</body>
</html>