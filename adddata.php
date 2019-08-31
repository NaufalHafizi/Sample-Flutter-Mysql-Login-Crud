<?php
	include 'conn.php';
	
	$itemEmail = $_POST['email'];
	$itemPassword = $_POST['password'];
	$sekolah = $_POST['sekolah'];
	
	$connect->query("INSERT INTO user (Teacher_email,Teacher_password,Teacher_sekolah) VALUES ('".$itemEmail."','".$itemPassword."','".$sekolah."')")
?>