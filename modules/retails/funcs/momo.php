<?php

sleep(2);

$order_code = $nv_Request->get_title('orderId', 'get', '', 1);

if($order_code == '' ){
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name );
}else{
    $order_code = str_replace('-',',',$order_code);
    $payment_method = GetPaymentMethodOrder($order_code);
    $inputData = array();
    $returnData = array();
    if($payment_method == 'momo'){
        $data = $_REQUEST;
        if(empty($data))
        {
            nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '='. $module_name, true);
        }
     
        require_once(NV_ROOTDIR.'/modules/retails/payment/momo.complete.php');
        
    }   

}



