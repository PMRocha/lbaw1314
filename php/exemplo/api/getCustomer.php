<?php
        header("Content-Type:application/json");
        if(isset($_GET['CustomerId'])){

        }
        else{
                $error;
                $error_values;
                $error_values['code']=601;
                $error_values['reason']='Permission denied';
                $error['error'] = $error_values;
                $error = json_encode($error);
                print $error;
        }
?>

