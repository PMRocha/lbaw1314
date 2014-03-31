<?php
        header("Content-Type:application/json");
        if(isset($_GET['ProductId'])){

        }
        else{
                $error;
                $error_values;
                $error_values['code']=404;
                $error_values['reason']='Product not found';
                $error['error'] = $error_values;
                $error = json_encode($error);
                print $error;
        }
?>

