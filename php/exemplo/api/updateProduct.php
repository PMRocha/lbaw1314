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
		
		$pc = $_POST['ProductCode'];
		$pd = $_POST['ProductDescription'];
		$uom= $_POST['UnitOfMesure'];
		$up = $_POST['UnitPrice'];
		$sql="";
		
        if(isset($_POST['ProductCode'])){
		
			$db->exec("SET CHARACTER SET utf8");
		
			$sql =  "UPDATE Product
					SET ProductCode=:ProductCode,
					Id=:ProductCode,
					ProductDescription=:ProductDescription,
					UnitOfMesure=:UnitOfMesure,
					UnitPrice=:UnitPrice
					WHERE ProductCode=:ProductCode";
			
			$statement = $db->prepare($sql);
			$statement->bindValue(':ProductCode', $pc);
			$statement->bindValue(':ProductDescription', $pd);
			$statement->bindValue(':UnitOfMesure', $uom);
			$statement->bindValue(':UnitPrice', $up);
			$count = $statement->execute();
        }else{
			$sql = "INSERT INTO Product('ProductDescription', 'UnitOfMesure', 'UnitPrice') VALUES(:ProductDescription, :UnitOfMesure, :UnitPrice)";
			
			$statement = $db->prepare($sql);
			$statement->bindValue(':ProductDescription', $pd);
			$statement->bindValue(':UnitOfMesure', $uom);
			$statement->bindValue(':UnitPrice', $up);
			$count = $statement->execute();
			
			$numberId = "SELECT Id from Product";
			$numberId2 = $db->query($numberId);
			
			$newId = "";
			foreach($numberId2 as $row){
				$newId = $row['Id'];
			}
			
			$sql2 =  "UPDATE Product
					SET ProductCode=:Id
					WHERE Id=:Id";
					
			$statement = $db->prepare($sql2);
			$statement->bindValue(':Id', $newId);
			$count = $statement->execute();
		}
		
		
        /*else{
                $error;
                $error_values;
                $error_values['code']=404;
                $error_values['reason']='Invoice not found';
                $error['error'] = $error_values;
                $error = json_encode($error);
                print $error;
        }*/
?>

