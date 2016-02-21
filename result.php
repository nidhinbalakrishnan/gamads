<?php
$search = $_GET["search"];
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "sensordb";

?>
<html>
<head>
    <title>Sensor Test</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  
  </head>
<body>
 <script>   
   
google.charts.load('current', {packages: ['corechart', 'line']});
google.charts.setOnLoadCallback(drawBasic);
var data,chart,options;
function drawBasic() {

       data = new google.visualization.DataTable();
      data.addColumn('number', 'X');
      data.addColumn('number', 'value');
      var url = "send.php?search=";
      var para=<?php echo $search;?>;
      url=url.concat(para);
         options = {
        hAxis: {
          title: 'Time'
        },
        vAxis: {
          title: 'Value'
        }
      };

       chart = new google.visualization.LineChart(document.getElementById('chart_div'));

      //alert(url);
 
    $.ajax({
    url: url, // returns "[1,2,3,4,5,6]"
    dataType: 'json', // jQuery will parse the response as JSON
    success: function (outputfromserver) {
    	
        for (var i = 0; i < outputfromserver.length; i++) {
 		{
		myVal = parseFloat($.trim(outputfromserver[i])); 
	    console.log("F"+myVal);
	    data.addRow([i, {v: myVal, f: myVal.toFixed(6)}]);
		}
		chart.draw(data, options);
	 }
    }
});
  

    
      
    }
    var index= 1;
      setInterval(drawBasic,1500);
    </script>
    
<div id="chart_div"></div>
</body>
</html>