<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @copyright (C) 2017 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 04/18/2017 09:47
 */

if (! defined('NV_IS_MOD_RETAILSHOPS')) {
    die('Stop!!!');
}


foreach ($data as $key => $value)
{
        $inputData[$key] = $value;
}
$error = CheckPaymentOrder($payment_method,$order_code,$inputData);	
$data = GetPaymentStatus($payment_method,$order_code,$error,$inputData);


