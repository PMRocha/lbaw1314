<?php
    /* Try to load the database */
    try {
        $db = new PDO('sqlite:../db/database.db');
    } catch(PDOException $e) {
        echo 'Something went wrong: ';
        echo $e->getMessage();
		exit();
    }
	
	/* Get parameters */
	$field=$_GET['field'];
	$value=$_GET['value'];
	$valueMin=$_GET['minvalue'];
	$valueMax=$_GET['maxvalue'];
	$operation=$_GET['op'];
	$actualAddress=0;
		
	if($operation === 'range') {
		$results = $db->query("SELECT Client.Id, Client.BillingAddressId, Client.CompanyName, Client.CustomerId, Client.CustomerTaxId, Client.Email, BillingAddress.AddressDetail, BillingAddress.City, BillingAddress.Country, BillingAddress.PostalCode FROM Client LEFT JOIN BillingAddress ON Client.BillingAddressId=BillingAddress.Id WHERE $field >= '$valueMin' AND $field <= '$valueMax'");
	} else if($operation === 'equal') {
		$results = $db->query("SELECT Client.Id, Client.BillingAddressId, Client.CompanyName, Client.CustomerId, Client.CustomerTaxId, Client.Email FROM Client WHERE $field = '$value'");
	} else if($operation === 'contains') {
		$results = $db->query("SELECT Client.Id, Client.BillingAddressId, Client.CompanyName, Client.CustomerId, Client.CustomerTaxId, Client.Email FROM Client WHERE CAST($field AS TEXT) LIKE '%$value'");
	} else if($operation === 'min') {
		$results = $db->query("SELECT Client.Id, Client.BillingAddressId, Client.CompanyName, Client.CustomerId, Client.CustomerTaxId, Client.Email FROM Client WHERE $field >= '$value'");
		} else if($operation === 'max') {
		$results = $db->query("SELECT Client.Id, Client.BillingAddressId, Client.CompanyName, Client.CustomerId, Client.CustomerTaxId, Client.Email FROM Client WHERE $field <= '$value'");
	}else {
		echo 'Invalid operation: ';
		echo $operation;
		exit();
	}

	$rA = array();

	$output = "<table border=\"0\" cellspacing=\"8\" cellpadding=\"8\">";
	$output = $output."<tr><td><h4>Id</h4></td><td><h4>BillingAddressId</h4></td><td><h4>CompanyName</h4></td><td><h4>CustomerTaxId</h4></td><td><h4>Email</h4></td></tr>";
	
	/* Search through the results */
	foreach( $results as $row) {
		$output = $output."<tr>";
		$output = $output."<td>".$row["Id"]."</td>";
		$output = $output."<td>".$row["BillingAddressId"]."</td>";
		$output = $output."<td>".$row["CompanyName"]."</td>";
		$output = $output."<td>".$row["CustomerTaxId"]."</td>";
		$output = $output."<td>".$row["Email"]."</td>";
		$info = array("Id"=>$row["Id"],"BillingAddressId"=>$row["BillingAddressId"],
						"CompanyName"=>$row["CompanyName"],
						"CustomerId"=>$row["CustomerId"],
						"CustomerTaxId"=>$row["CustomerTaxId"],
						"Email"=>$row["Email"]);
		$actualAddress=$row["BillingAddressId"];
		array_push($rA, $info);
		$active = $db->query("SELECT BillingAddress.AddressDetail , BillingAddress.PostalCode, BillingAddress.City, BillingAddress.Country FROM BillingAddress WHERE BillingAddress.Id = '$actualAddress'");
		
		$output2 = "<table border=\"0\" cellspacing=\"8\" cellpadding=\"8\">";
		$output2 = $output2."<tr><td><h4>AddressDetail</h4></td><td><h4>PostalCode</h4></td><td><h4>City</h4></td><td><h4>Country</h4></td></tr>";
		
		foreach( $active as $rw) {
		$output2 = $output2."<td>".$rw["AddressDetail"]."</td>";
		$output2 = $output2."<td>".$rw["PostalCode"]."</td>";
		$output2 = $output2."<td>".$rw["City"]."</td>";
		$output2 = $output2."<td>".$rw["Country"]."</td>";
		$info = array("AddressDetail"=>$rw["AddressDetail"],
						"PostalCode"=>$rw["PostalCode"],
						"City"=>$rw["City"],
						"Country"=>$rw["Country"]);
		array_push($rA, $info);
		$output2 = $output2."</tr>";
	}
	}
	$output = $output."</table>";
	$output2 = $output2."</table>";
	echo $output;
	echo'<br>';
	echo $output2;
	echo json_encode($rA);
?>
