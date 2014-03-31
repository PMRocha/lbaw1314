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
		$results = $db->query("SELECT Product.ProductCode, Product.ProductDescription,Product.UnitOfMesure, Product.UnitPrice
												FROM Product WHERE $field >= '$valueMin' AND $field <= '$valueMax'");
	} else if($operation === 'equal') {
		$results = $db->query("SELECT Product.ProductCode, Product.ProductDescription,Product.UnitOfMesure, Product.UnitPrice
												FROM Product WHERE $field = '$value'");
	} else if($operation === 'contains') {
		$results = $db->query("SELECT Product.ProductCode, Product.ProductDescription,Product.UnitOfMesure, Product.UnitPrice
												FROM Product WHERE CAST($field AS TEXT) LIKE '%$value'");
	} else if($operation === 'min') {
		$results = $db->query("SELECT Product.ProductCode, Product.ProductDescription,Product.UnitOfMesure, Product.UnitPrice
												FROM Product WHERE  $field >= '$value'");
	} else if($operation === 'max') {
		$results = $db->query("SELECT Product.ProductCode, Product.ProductDescription,Product.UnitOfMesure, Product.UnitPrice
												FROM Product WHERE $field <= '$value'");
	} else {
		echo 'Invalid operation: ';
		echo $operation;
		exit();
	}

	$rA = array();
	
	$output = "<table border=\"0\" cellspacing=\"8\" cellpadding=\"8\">";
	$output = $output."<tr><td><h4>Code</h4></td><td><h4>Description</h4></td><td><h4>UnitOfMeasure</h4></td><td><h4>UnitPrice</h4></td></tr>";

	
	/* Search through the results */
	foreach( $results as $row) {
		$output = $output."<tr>";
		$output = $output."<td>".$row["ProductCode"]."</td>";
		$output = $output."<td>".$row["ProductDescription"]."</td>";
		$output = $output."<td>".$row["UnitOfMesure"]."</td>";
		$output = $output."<td>".$row["UnitPrice"]."</td>";
		$output = $output."</tr>";
		$info = array("ProductCode"=>$row["ProductCode"],
						"ProductDescription"=>$row["ProductDescription"],
						"UnitOfMesure"=>$row["UnitOfMesure"],
						"UnitPrice"=>$row["UnitPrice"]);
		array_push($rA, $info);
	}
	$output = $output."</table>";
	echo $output;

	echo json_encode($rA);
?>
