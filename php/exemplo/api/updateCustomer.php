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
		
		$ci = $_POST['CustomerId'];
		$cn = $_POST['CompanyName'];
		$cti= $_POST['CustomerTaxId'];
		$em = $_POST['Email'];
		$bai = $_POST['BillingAddressId'];
		
		$ad = $_POST['AddressDetail'];
		$ct = $_POST['City'];
		$cy = $_POST['Country'];
		$pc = $_POST['PostalCode'];
		
		$sql="";
		
        if(isset($_POST['CustomerId'])){
		
		echo "4";
			$db->exec("SET CHARACTER SET utf8");
		
			$sql =  "UPDATE Client
					SET CustomerId=:CustomerId,
					CompanyName=:CompanyName,
					CustomerTaxId=:CustomerTaxId,
					Email=:Email,
					BillingAddressId=:BillingAddressId
					WHERE CustomerId=:CustomerId";
			
			$statement = $db->prepare($sql);
			$statement->bindValue(':CustomerId', $ci);
			$statement->bindValue(':CompanyName', $cn);
			$statement->bindValue(':CustomerTaxId', $cti);
			$statement->bindValue(':Email', $em);
			$statement->bindValue(':BillingAddressId', $bai);
			$count = $statement->execute();
			
			$sql2 = "UPDATE BillingAddress
					SET AddressDetail=:AddressDetail,
					City=:City,
					Country=:Country,
					PostalCode=:PostalCode
					WHERE Id=:BillingAddressId";
			
			$statement = $db->prepare($sql2);
			$statement->bindValue(':AddressDetail', $ad);
			$statement->bindValue(':City', $ct);
			$statement->bindValue(':Country', $cy);
			$statement->bindValue(':PostalCode', $pc);
			$statement->bindValue(':BillingAddressId', $bai);
			$count = $statement->execute();
			
        }else{
		
			$sql2 = "INSERT INTO BillingAddress('AddressDetail', 'City', 'Country', 'PostalCode') VALUES(:AddressDetail, :City, :Country, :PostalCode)";
			
			$statement = $db->prepare($sql2);
			$statement->bindValue(':AddressDetail', $ad);
			$statement->bindValue(':City', $cn);
			$statement->bindValue(':Country', $cti);
			$statement->bindValue(':PostalCode', $em);
			$count = $statement->execute();
			
			
			$sql = "INSERT INTO Client('CustomerId', 'CompanyName', 'CustomerTaxId', 'Email') VALUES(:CustomerId, :CompanyName, :CustomerTaxId, :Email)";
			
			$statement = $db->prepare($sql);
			$statement->bindValue(':CustomerId', $ci);
			$statement->bindValue(':CompanyName', $cn);
			$statement->bindValue(':CustomerTaxId', $cti);
			$statement->bindValue(':Email', $em);
			$count = $statement->execute();
			
			$numberId = "SELECT max(Id) as maxId from BillingAddress";
			$numberId2 = $db->query($numberId);
			
			$newAddId = "";
			foreach($numberId2 as $row){
				$newAddId = $row['maxId'];
			}
			
			$numberIdClient = "SELECT max(Id) as maxId from Client";
			$numberIdClient2 = $db->query($numberIdClient);
			
			$newClientId = "";
			foreach($numberIdClient2 as $row){
				$newClientId = $row['maxId'];
			}
			
			$sql3 =  "UPDATE Client
					SET BillingAddressId=:BillingAddressId, CustomerId = Id
					WHERE Id = :ClientId";
			
			$statement = $db->prepare($sql3);
			$statement->bindValue(':BillingAddressId', $newAddId);
			$statement->bindValue(':ClientId', $newClientId);
			$count = $statement->execute();
			
			
		}
?>

