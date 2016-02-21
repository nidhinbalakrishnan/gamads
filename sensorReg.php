<?php

if (!empty($_POST))
{
$sensorName = $_POST["sensorName"];
$type = $_POST["type"];
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "sensordb";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
     die("Connection failed: " . $conn->connect_error);
} 
 $sid =  uniqid();
$sql = "INSERT INTO `device`(`sid`, `name`) VALUES ("."\"".$sid."\"".",\"".$sensorName."\")";
$result = $conn->query($sql);
echo '<script language="javascript">';
echo 'alert("Device successfully registered with sid : '.$sid.'")';
echo '</script>';


}
else
{


}

?>
<html>
<head>
<link rel="stylesheet" type="text/css" href="bootstrap.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.js"></script>
</head>
<body>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Sensor Framework</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="register.php">Search <span class="sr-only">(current)</span></a></li>
  
      </ul>

      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">Show My Sensors</a></li>
      </ul>
       <ul class="nav navbar-nav navbar-right">
        <li class="active"><a href="#" >Register a sensor</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
 <div class="container">
  <div class="row">
         <form method ="post" action="sensorReg.php" class="form-signin">
        <h2 class="form-signin-heading">Register Sensor</h2>
        <label for="sensorName" class="sr-only">Sensor Name</label>
        <input type="text" name="sensorName" class="form-control" placeholder="Sensor Name" required autofocus>
        <label for="sensor type" class="sr-only">Type</label>
        <input type="text" name="type" class="form-control" placeholder="Type" required>
        
        <button class="btn btn-lg btn-primary btn-block" type="submit">Register</button>
      </form>
  </div>
</div>
</body>


</html>