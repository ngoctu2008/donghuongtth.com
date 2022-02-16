<?php

sleep(2);

$order_code = $nv_Request->get_title('orderId', 'get', '', 1);

if($order_code == '' ){
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name );
}else{
    $order_code = str_replace('-',',',$order_code);
    $payment_method = GetPaymentMethodOrder($order_code);
    $xtpl = new XTemplate('payment_' . $payment_method . '_success.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_BASE_SITEURL', NV_BASE_SITEURL);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('MODULE_UPLOAD', $module_upload);
    $xtpl->assign('NV_ASSETS_DIR', NV_ASSETS_DIR);
    $xtpl->assign('children_fund', $config_setting['children_fund'] . 'đ');
    $xtpl->assign('OP', $op);
    $xtpl->assign('HISTORY', nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=ordercustomer',true));	
    $xtpl->assign('LOGO_SRC', NV_BASE_SITEURL . $global_config['site_logo']);
    if($user_info['userid']){
        $xtpl->assign('RE_PAYMENT', nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=re-payment',true));
    }else{
        $xtpl->assign('RE_PAYMENT', nv_url_rewrite(NV_BASE_SITEURL,true));
    }
    
    $status = false;
    $inputData = array();
    $returnData = array();
    if($payment_method == 'momo'){
        $data = $_REQUEST;
        if(empty($data))
        {
            nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '='. $module_name, true);
        }
        
        
        require_once(NV_ROOTDIR.'/modules/retails/payment/momo.complete.php');
        
        if($user_info['userid']){
            $xtpl->parse('main.thanhcong.history');
        }
        
        $xtpl->parse('main.thanhcong');
    }

    $xtpl->parse('main');
    $contents = $xtpl->text('main');

    $page_title = 'Thông tin thanh toán';

    include NV_ROOTDIR . '/includes/header.php';
    echo nv_site_theme($contents);
    include NV_ROOTDIR . '/includes/footer.php';
}



