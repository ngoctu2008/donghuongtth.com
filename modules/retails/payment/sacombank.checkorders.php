<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @copyright (C) 2017 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 04/18/2017 09:47
 */

if (!defined('NV_IS_MOD_RETAILSHOPS'))
die('Stop!!!');
//$data = add_order($list_transporters,$info_customer);
$list_order = $data['list_order'];
$list_order_code = $data['list_order_code'];
$order_full=implode(',',$list_order);
$list_order_code=implode(',',$list_order_code);
$mm_OrderInfo='Thanh toan giao dich '.$list_order_code.' vao thoi gian '.date('d-m-Y H:i',NV_CURRENTTIME);

$check_sacombank = send_payment('sacombank', $total_full,$mm_OrderInfo,$list_order);
$contents1 = array(
'status' => 'OK_SACOMBANK',
'link' => $check_sacombank
);

print_r( json_encode($contents1));
die();






