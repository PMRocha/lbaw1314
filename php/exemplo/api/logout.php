<?php
	/* Cookie monster disapproves of this function */
	$username=$_COOKIE['username'];
	$password_sha1=$_COOKIE['password'];
	$email_original=$_COOKIE['email'];
	$permission_original=$_COOKIE['permission'];
	$date_of_expiry = time() -1000;
	setcookie('username',$username, $date_of_expiry, '/');
    setcookie('password',$password_sha1, $date_of_expiry, '/');
    setcookie('email',$email_original,$date_of_expiry, '/');
    setcookie('permission',$permission_original,$date_of_expiry, '/');
	header('Location: ../index.html');
?>