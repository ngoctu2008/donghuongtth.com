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
$mm_TransactionNo=$order_full;
$mm_OrderInfo='Thanh toan giao dich '.$list_order_code.' vao thoi gian '.date('d-m-Y H:i',NV_CURRENTTIME);


$mm_ReturnUrl= nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=payment' , true );

// lấy thông tin ip server
$vmm_IpAddr = $_SERVER['REMOTE_ADDR'];

$check_momo = send_momo($total_full,$mm_OrderInfo,$config_setting['website_code_vnpay'],$mm_TransactionNo,$config_setting['checksum_vnpay'],$vnp_ReturnUrl,$mm_IpAddr);
$contents1 = array(
'status' => 'OK_MOMO',
'link' => $check_momo
);

print_r( json_encode($contents1));
die();






