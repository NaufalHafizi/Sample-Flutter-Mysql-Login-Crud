<?php

include conn.php;

$image = $_FILES['imageDB']['name'];

$imagePath = "uploads'".$image;

move_uploaded_file($_FILES['imageDB']['tmp_name'], $imagePath);

?>