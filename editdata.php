<?php

    include 'conn.php';

    $id = $_POST['ID'];
    $itemEmail = $_POST['email'];
	$itemPassword = $_POST['password'];
	$itemsekolah = $_POST['sekolah'];

    $connect->query("UPDATE user SET Teacher_email='".$itemEmail."', Teacher_password='".$itemPassword."', Teacher_sekolah='".$itemsekolah."' WHERE id=" . $id);
?>