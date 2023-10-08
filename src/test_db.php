<?php

$servername = "mysql";
$username = "root";
$password = getenv("MYSQL_ROOT_PASSWORD");
$database = getenv("MYSQL_DATABASE");

$password = "secret";
$database = "khalid";


$conn = "";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$database", $username, $password);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo nl2br("Connected successfully\n");
} catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
    die;
}

$stmt = $conn->query("SELECT * FROM tests")->fetchAll();
print_r($stmt);

#echo getenv("MYSQL_DATABASE");

    
?>
