<?php

$servername = "mysql";
$username = "root";
$password = getenv("MYSQL_ROOT_PASSWORD");
$database = getenv("MYSQL_DATABASE");

$password = "secret";
$database = "khalid";

try {
  $conn = new PDO("mysql:host=$servername;dbname=$database", $username, $password);
  // set the PDO error mode to exception
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  echo "Connected successfully";
} catch(PDOException $e) {
  echo "Connection failed: " . $e->getMessage();
}

#echo getenv("MYSQL_DATABASE");

    
?>
