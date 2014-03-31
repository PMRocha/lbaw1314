<?php
	header("Content-type: text/javascript");
    /* Try to load the database */
    try {
        $db = new PDO('sqlite:../db/database.db');
    } catch(PDOException $e) {
        echo 'Something went wrong: ';
        echo $e->getMessage();
		exit();
    }
    $results = $db->query("SELECT Product.ProductCode, Product.ProductDescription, Product.UnitOfMesure, Product.UnitPrice FROM Product");
	
	$rA = array();	
    foreach( $results as $row) {
		$info = array("ProductCode"=>$row["ProductCode"],"ProductDescription"=>$row["ProductDescription"],"UnitOfMesure"=>$row["UnitOfMesure"],"UnitPrice"=>$row["UnitPrice"]);
		array_push($rA, $info);
	}
	
	echo json_encode($rA);
?>
