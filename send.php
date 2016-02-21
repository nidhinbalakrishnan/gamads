<?php
$search = $_GET["search"];
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "sensordb";
$values = array();
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
     die("Connection failed: " . $conn->connect_error);
} 
$sql = "SELECT  value FROM data where sid ='".$search."'";
$result = $conn->query($sql);


if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        array_push($values,$row["value"]);
        

    }
}
echo json_encode($values);
?>