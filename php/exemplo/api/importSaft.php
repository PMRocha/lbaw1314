<?php
/* Check file */
if (isset($_POST['submit'])) {
	if ($_FILES["file"]["error"] > 0) {
		if ($_FILES["file"]["error"] == UPLOAD_ERR_NO_FILE) {
			echo "No file has been uploaded.";
		} else {
			echo "Error: " . $_FILES["file"]["error"] . "<br>";
		}
		return;
	} else {
		echo "Upload    : " . $_FILES["file"]["name"] . "<br>";
		echo "Type      : " . $_FILES["file"]["type"] . "<br>";
		echo "Size      : " . ($_FILES["file"]["size"] / 1024) . " kB<br>";
		echo "Stored in : " . $_FILES["file"]["tmp_name"];
	}
} else {
	return;
}

echo "<br>";

echo 'Here is some more debugging info:';
print_r($_FILES);

/* Parse uploaded saft file */
$saftxml = simplexml_load_file($GET('upload_target'));
echo $saftxml;

/* Try to load the database */
try {
	$db = new PDO('sqlite:../db/database.db');
} catch(PDOException $e) {
	echo 'Something went wrong: ';
	echo $e -> getMessage();
	exit();
}

/* Clean the database */

/* Import the saft entries to the database */
?>