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
	
	if($operation === 'range') {
		$results = $db->query("SELECT Invoices.InvoiceNo, Invoices.InvoiceDate, Invoices.CustomerId
												FROM Invoices WHERE $field >= '$valueMin' AND $field <= '$valueMax'");
	} else if($operation === 'equal') {
		$results = $db->query("SELECT Invoices.InvoiceNo, Invoices.InvoiceDate, Invoices.CustomerId
												FROM Invoices WHERE $field = '$value'");
	} else if($operation === 'contains') {
		$results = $db->query("SELECT Invoices.InvoiceNo, Invoices.InvoiceDate, Invoices.CustomerId
												FROM Invoices WHERE CAST($field AS TEXT) LIKE '%$value'");
	} else if($operation === 'min') {
		$results = $db->query("SELECT Invoices.InvoiceNo, Invoices.InvoiceDate, Invoices.CustomerId
												FROM Invoices WHERE  $field >= '$value'");
	} else if($operation === 'max') {
		$results = $db->query("SELECT Invoices.InvoiceNo, Invoices.InvoiceDate, Invoices.CustomerId
												FROM Invoices WHERE $field <= '$value'");
	} else {
		echo 'Invalid operation: ';
		echo $operation;
		exit();
	}

	$rA = array();
	
	$output = "<table border=\"0\" cellspacing=\"8\" cellpadding=\"8\">";
	$output = $output."<tr><td><h4>InvoiceNo</h4></td><td><h4>InvoiceDate</h4></td><td><h4>CustomerId</h4></td></tr>";
	
	/* Search through the results */
	foreach( $results as $row) {
		$output = $output."<tr>";
		$output = $output."<td>".$row["InvoiceNo"]."</td>";
		$output = $output."<td>".$row["InvoiceDate"]."</td>";
		$output = $output."<td>".$row["CustomerId"]."</td>";
		$output = $output."</tr>";
		$info = array("InvoiceNo"=>$row["InvoiceNo"],
						"InvoiceDate"=>$row["InvoiceDate"],
						"CustomerId"=>$row["CustomerId"]);
		array_push($rA, $info);
	}
	$output = $output."</table>";
	echo $output;
	
	echo json_encode($rA);
?>