<?php

$connect = new  mysqli("localhost","root","","YOURNAMEFILE");

if($connect) {
    
} else {
    echo "Connection Failed";
    exit();
}

?>