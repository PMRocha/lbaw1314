<?php
    /* Try to load the database */
    try {
        $db = new PDO('sqlite:../db/database.db');
    } catch(PDOException $e) {
        echo 'Something went wrong: ';
        echo $e->getMessage();
		exit();
    }
	
    session_start();
    $username=$_GET['username'];
    $rememberme=$_GET['rememberme'];
	/* Encode the password as a sha1 sum */
    $password_sha1=sha1($_GET['password']);

	/* That is a long lasting cookie */
    $date_of_expiry = time() + 60*60*24*365 ;
    
	/* There can only be one user on the DB with one email */
    $results = $db->query("SELECT Users.UserId, Users.Id, Users.Password, Users.Email, Users.PermissionLevel FROM Users WHERE Users.UserId= '$username'");

	/* TODO: Check if user exists here */

	/* TODO: Get rid of the foreach */
	foreach( $results as $result) {					
		$passwordReal=$result["Password"];
		$email=$result["Email"];
    	$permission=$result["PermissionLevel"];
	}

	/* Compare passwords sums */
    if($password_sha1 === $passwordReal) { 
    	/* If the user selects the remember me check box, keep the cookies for a year */
    	if(isset($_GET['rememberme'])){
    		setcookie('username',$username, $date_of_expiry, '/');
    		setcookie('password',$password_sha1, $date_of_expiry, '/');
    		setcookie('email',$email,$date_of_expiry, '/');
    		setcookie('permission',$permission,$date_of_expiry, '/');	
    	} else {
    	/* Keep them only until the user closes the browser */
    		setcookie('username',$username, false, '/');
			setcookie('password',$password_sha1, false, '/');
			setcookie('email',$email,false, '/');
    		setcookie('permission',$permission,false, '/');
    	}
		/* Take the user do the index page */
    	header("Location: ../index.html");
    } else {
		/* TODO: Invalid password */
    	header("Location: ../login.html");
    }   	
?>
