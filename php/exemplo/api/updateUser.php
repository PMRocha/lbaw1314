<?php
		header("Location: ../users.html");
		/* Try to load the database */
		try {
			$db = new PDO('sqlite:../db/database.db');
		} catch(PDOException $e) {
			echo 'Something went wrong: ';
			echo $e->getMessage();
			exit();
		}   
		
		$username = $_GET['username'];
		$password = sha1($_GET['password']);
		
		$email = $_GET['email'];
		$permission = $_GET['$permission']; 
		$sql="";
		$sql = "INSERT INTO Users('UserId', 'Password', 'Email', 'PermissionLevel') VALUES(:UserIdIn, :PasswordIn, :EmailIn, :PermissionLevelIn)";	
		
		$statement = $db->prepare($sql);
		$statement->bindValue(':UserIdIn', $username);
		$statement->bindValue(':PasswordIn', $password);
		$statement->bindValue(':EmailIn', $email);
		$statement->bindValue(':PermissionLevelIn', $permission);
		$count = $statement->execute();
		
		$numberId = "SELECT Id from Users";
		$numberId2 = $db->query($numberId);
		$newId = "";
		foreach($numberId2 as $row){
				$newId = $row['Id'];
		}	
		$sql2 =  "UPDATE Users
					SET Id=:Id
					WHERE UserId=:UserId";	
		$statement = $db->prepare($sql2);
		$statement->bindValue(':Id', $newId);
		$count = $statement->execute();
?>		
