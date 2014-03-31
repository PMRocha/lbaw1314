<?php
    /* Try to load the database */
    try {
        $db = new PDO('sqlite:../db/database.db');
    } catch(PDOException $e) {
        echo 'Something went wrong: ';
        echo $e->getMessage();
		exit();
    }
	
    $id=$_GET['id'];
	$id2=0;
    $rA = array();
    $lines=array();
    $products=array();
    
    $results = $db->query("SELECT DocumentTotals.GrossTotal, DocumentTotals.NetTotal, DocumentTotals.TaxPayable  FROM DocumentTotals WHERE DocumentTotals.Id = '$id'");
    
    foreach($results as $row) {
		$info = array("GrossTotal"=>$row["GrossTotal"],
						"NetTotal"=>$row["NetTotal"],
						"TaxPayable"=>$row["TaxPayable"]);				
		array_push($rA, $info);
	}
    array_push($rA,'<br>');
    $results = $db->query("SELECT Invoices.InvoiceNo ,Invoices.InvoiceDate, Invoices.CustomerId FROM Invoices WHERE Invoices.DocumentTotalsId = '$id'");
    foreach( $results as $row) {
		$info = array("InvoiceNo"=>$row["InvoiceNo"],
						"InvoiceDate"=>$row["InvoiceDate"]);
		array_push($rA, $info);
		$id=$row["InvoiceNo"];
		$id2=$row["CustomerId"];
	}
    array_push($rA,'<br>'); 
    $results = $db->query("SELECT Client.BillingAddressId ,Client.CompanyName, Client.CustomerId, Client.CustomerTaxId, Client.Email FROM Client WHERE Client.Id = '$id2'");
    foreach( $results as $row) {
		$info = array("CompanyName"=>$row["CompanyName"],"CustomerId"=>$row["CustomerId"],"CustomerTaxId"=>$row["CustomerTaxId"],
						"Email"=>$row["Email"]);
		array_push($rA, $info);
		$id2=$row["BillingAddressId"];
	}
    array_push($rA,'<br>');     
    $results = $db->query("SELECT BillingAddress.AddressDetail ,BillingAddress.Country, BillingAddress.PostalCode FROM BillingAddress WHERE BillingAddress.Id = '$id2'");
    foreach( $results as $row) {
		$info = array("AddressDetail"=>$row["AddressDetail"],
						"Country"=>$row["Country"],
						"PostalCode"=>$row["PostalCode"]);
		array_push($rA, $info);
	}
    $results = $db->query("SELECT LineInvoice.LineId FROM LineInvoice WHERE LineInvoice.InvoiceNo = '$id'");
     foreach( $results as $row) {
		$idLine =$row["LineId"]; 
		array_push($lines, $idLine);
	}
    
    //tenho que guardar o id das linhas
    foreach($lines as $idLine)
    {
    	$results = $db->query("SELECT Line.CreditAmount ,Line.ProductCode, Line.Quantity, Line.TaxId, Line.UnitPrice FROM Line WHERE Line.Id = '$idLine'");
    	foreach( $results as $row) {
			$info = array("CreditAmount"=>$row["CreditAmount"],
			"ProductCode"=>$row["ProductCode"],"Quantity"=>$row["Quantity"],
			"UnitPrice"=>$row["UnitPrice"]);
			array_push($rA,'<br>'); 
			array_push($rA, $info); 
			$idProduct =$row["ProductCode"]; 
			array_push($products, $idProduct);
		}
    } 
    //tenho que guardar o id dos produtos
    foreach($products as $idProduct)
    {
    $results = $db->query("SELECT Product.ProductCode ,Product.ProductDescription, Product.UnitOfMesure, Product.UnitPrice FROM Product WHERE Product.Id = '$idProduct'");
    
    foreach( $results as $row) {
		$info = array("ProductCode"=>$row["ProductCode"],
						"ProductDescription"=>$row["ProductDescription"],
						"UnitPrice"=>$row["UnitPrice"]);
		array_push($rA,'<br>'); 
		array_push($rA, $info); 
		}
    }
	
	
    echo json_encode($rA);
?>
