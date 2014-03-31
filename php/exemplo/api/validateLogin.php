<?php
    /* Try to load the database */
    try {
        $db = new PDO('sqlite:../db/database.db');
    } catch(PDOException $e) {
        echo 'Something went wrong: ';
        echo $e->getMessage();
		exit();
    }
	
	$username=$_GET['username'];
	$password_sha1=sha1($_GET['password']);
	$email_original=$_GET['email'];
	$permission_original=$_GET['permission'];
	
	$date_of_expiry = time() -1000;
	
	$results = $db->query("SELECT Users.UserId, Users.Id, Users.Password, Users.Email, Users.PermissionLevel FROM Users WHERE Users.UserId= '$username'");
	
	foreach( $results as $result) {					
		$passwordReal=$result["Password"];
		$email=$result["Email"];
    	$permission=$result["PermissionLevel"];
	}
	
	if($password_sha1 === $passwordReal && $email_original === $email && $permission === $permission_original) {
	 	return;
	 }
	 else {
	 	/* Invalidate cookies */
		setcookie('username',$username, $date_of_expiry, '/');
    	setcookie('password',$password_sha1, $date_of_expiry, '/');
    	setcookie('email',$email,$date_of_expiry, '/');
    	setcookie('permission',$permission,$date_of_expiry, '/'	);	
	 }
?>