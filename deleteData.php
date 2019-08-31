<?php

    include 'conn.php';
    $id = $_POST['ID'];
    $connect->query("DELETE FROM user WHERE ID=".$id);

?>