<?php
if (!defined('NV_IS_FILE_ADMIN'))
die('Stop!!!');
$id = $nv_Request->get_int('id', 'post,get', 0);

$view = $db->query('SELECT t1.*, t2.*, t3.address as shop_address, t3.phone_send  FROM ' . TABLE .'_order t1 INNER JOIN ' . TABLE . '_history_ghtk t2 ON t1.id = t2.order_id INNER JOIN ' . TABLE . '_warehouse t3 ON t1.warehouse_id = t3.id  WHERE t1.id = ' . $id)->fetch();


$xtpl = new XTemplate('history_ghtk_detail.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$xtpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('MODULE_UPLOAD', $module_upload);
$xtpl->assign('NV_ASSETS_DIR', NV_ASSETS_DIR);
$xtpl->assign('OP', $op);
$xtpl->assign('ROW', $row);

$view['total_weight'] = $view['total_weight'] / 1000;
if ($view['total_weight'] != $view['weight']) {
    $xtpl->assign('no_equal_weight', 'alert-info');
} else {
    $xtpl->assign('no_equal', '');
}

if ($view['fee'] != $view['fee_update']) {
    $xtpl->assign('no_equal', 'alert-warning');
} else {
    $xtpl->assign('no_equal', '');
}
if($view['for_control']){
    $xtpl->assign('FOR_CONTROL', 'Đã đối soát');
}elseif(!$view['for_control']){
    $xtpl->assign('FOR_CONTROL', 'Chưa đối soát');
}elseif($view['for_control_return']){
    $xtpl->assign('FOR_CONTROL', 'Đã đối soát công nợ trả hàng');
}elseif(!$view['for_control_return']){
    $xtpl->assign('FOR_CONTROL', 'Chưa đối soát công nợ trả hàng');
}


$address_user = get_full_address($view['ward_id'], $view['district_id'], $view['province_id']);
$view['address_user'] = $view['address'] . $address_user;
$view['shop_name'] = get_name_store($view['store_id']);
$view['status_ghtk'] = $global_status_order_ghtk[$view['status_id']]['name'];
$view['total_weight'] = $view['total_weight'] . 'kg';
$view['weight'] = $view['weight'] . 'kg';
$view['fee_transport'] = number_format($view['fee_transport']) . 'đ';
$view['fee'] = number_format($view['fee']) . 'đ';
$view['fee_update'] = number_format($view['fee_update']) . 'đ';
$view['insurance_fee'] = number_format($view['insurance_fee']) . 'đ';
$view['pick_money'] = number_format($view['pick_money']) . 'đ';
       
$view['link_view_order'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . 'view_order' . '&amp;id=' . $view['order_id'];

$xtpl->assign('VIEW', $view);
$xtpl->parse('main');
$contents = $xtpl->text('main');

$page_title = 'Chi tiết đối soát GHTK';

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';