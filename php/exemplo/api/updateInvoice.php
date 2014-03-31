<?php
        header("Location: ../invoices.html");
		/* Try to load the database */
		try {
			$db = new PDO('sqlite:../db/database.db');
		} catch(PDOException $e) {
			echo 'Something went wrong: ';
			echo $e->getMessage();
			exit();
		}
		
		$in = $_POST['InvoiceNo'];
		$id= $_POST['InvoiceDate'];
		$ci = $_POST['CustomerId'];
		$sql="";
		
        if(isset($_POST['InvoiceNo'])){
		
			$db->exec("SET CHARACTER SET utf8");
		
			$sql =  "UPDATE Invoices
					SET InvoiceNo=:InvoiceNo,
					Id=:InvoiceNo,
					InvoiceDate=:InvoiceDate,
					CustomerId=:CustomerId
					WHERE InvoiceNo=:InvoiceNo";
			
			$statement = $db->prepare($sql);
			$statement->bindValue(':InvoiceNo', $in);
			$statement->bindValue(':InvoiceDate', $id);
			$statement->bindValue(':CustomerId', $ci);
			$count = $statement->execute();
        }else{
			$sql = "INSERT INTO Invoices('InvoiceNo', 'InvoiceDate', 'CustomerId') VALUES(:InvoiceNo, :InvoiceDate, :CustomerId)";
			
			$statement = $db->prepare($sql);
			$statement->bindValue(':InvoiceDate', $id);
			$statement->bindValue(':CustomerId', $ci);
			$count = $statement->execute();
			
			$numberId = "SELECT Id from Invoices";
			$numberId2 = $db->query($numberId);
			
			$newId = "";
			foreach($numberId2 as $row){
				$newId = $row['Id'];
			}
			
			$sql2 =  "UPDATE Invoices
					SET InvoiceNo=:Id
					WHERE Id=:Id";
					
			$statement = $db->prepare($sql2);
			$statement->bindValue(':Id', $newId);
			$count = $statement->execute();
		}
?>

