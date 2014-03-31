<?php
		
		header("Location: ../products.html");
		/* Try to load the database */
		try {
			$db = new PDO('sqlite:../db/database.db');
		} catch(PDOException $e) {
			echo 'Something went wrong: ';
			echo $e->getMessage();
			exit();
		}
		$username = $_POST['username'];
		$password_old=sha1($_GET['oldPassword']);
		$password_new=sha1($_GET['newPassword']);
		$email = $_POST['email'];
		$sql="";
		
		$db->exec("SET CHARACTER SET utf8");
		
		$sql =  "UPDATE Users
					SET UserId=:UserId,
					Id=:Id,
					Password=:Password,
					Email=:Email,
					PermissionLevel=:PermissionLevel
					WHERE $password_old=:Password";
			
		$statement = $db->prepare($sql);
		$statement->bindValue(':UserId', $username);
		$statement->bindValue(':Password', $password_new);
		$statement->bindValue(':Email', $email);
		$count = $statement->execute();
		$sql2 =  "UPDATE Users
					SET Id=:Id
					WHERE UserId=:UserId";	
		$statement = $db->prepare($sql2);
		$statement->bindValue(':Id', $newId);
		$count = $statement->execute();
?>