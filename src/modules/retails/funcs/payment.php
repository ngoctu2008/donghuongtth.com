<?php

<<<<<<< HEAD
if (!defined('NV_IS_USER') or !$global_config['allowuserlogin']) {
        nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users');
}

	sleep(2);
	$_SESSION[$module_name . '_vnpay'] = true;
	
	$xtpl = new XTemplate('payment_vnpay_success.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
	$xtpl->assign('LANG', $lang_module);
	$xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
	$xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
	$xtpl->assign('NV_BASE_SITEURL', NV_BASE_SITEURL);
	$xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
	$xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
	$xtpl->assign('MODULE_NAME', $module_name);
	$xtpl->assign('MODULE_UPLOAD', $module_upload);
	$xtpl->assign('NV_ASSETS_DIR', NV_ASSETS_DIR);
	$xtpl->assign('OP', $op);
	
	$thanhtoan = false;

	$xtpl->assign('HISTORY', nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=ordercustomer',true));
	
	$xtpl->assign('RE_PAYMENT', nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=re-payment',true));

	// xử lý cập nhật vnpay
	
    $inputData = array();
    $returnData = array();
    $data = $_REQUEST;
	
	if(empty($data))
	{
		nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '='. $module_name, true);
	}
	
    foreach ($data as $key => $value)
    {
        if (substr($key, 0, 4) == "vnp_")
        {
            $inputData[$key] = $value;
        }
    }

    $vnp_SecureHash = $inputData['vnp_SecureHash'];
    unset($inputData['vnp_SecureHashType']);
    unset($inputData['vnp_SecureHash']);
    ksort($inputData);
    $i = 0;
    $hashData = "";
    foreach ($inputData as $key => $value)
    {
        if ($i == 1)
        {
            $hashData = $hashData . '&' . $key . "=" . $value;
        }
        else
        {
            $hashData = $hashData . $key . "=" . $value;
            $i = 1;
        }
    }
    $vnp_HashSecret = $config_setting['checksum_vnpay'];

	$order_text = $inputData['vnp_TxnRef'];
	
    if(!$order_text)
	{
		$returnData['RspCode'] = '01';
		$returnData['Message'] = 'Order not found!';
		echo json_encode($returnData);die;
	}
	

	// tính tổng tiền thanh toán
	$tongtien_thanhtoan = $db->query('SELECT sum(total) FROM ' . TABLE . '_order WHERE id IN('. $order_text .')')->fetchColumn(); 

	//print_r($tongtien_thanhtoan);die;

	$check_orderid = $db->query('SELECT id FROM ' . TABLE . '_order WHERE userid ='. $user_info['userid'] .' AND id IN('. $order_text .')')->fetchColumn(); 

	$check_thanhtoan = $db->query('SELECT id FROM ' . TABLE . '_order WHERE status_payment_vnpay = 1 AND id IN('. $order_text .')')->fetchColumn(); 

   
    $secureHash = hash('sha256', $vnp_HashSecret . $hashData);
    //print_r($id_order);die;
   
    $vnp_Amount = $inputData['vnp_Amount'];
    $vnp_Amount = (int)$vnp_Amount / 100;

    // checksum
    //print_r($vnp_SecureHash);die;
    if ($secureHash == $vnp_SecureHash)
    {
        // check OrderId
        if ($check_orderid)
        {
			if($tongtien_thanhtoan && $tongtien_thanhtoan == $vnp_Amount ){
                // check Status
                if ($check_thanhtoan) {
                    
                        if ($inputData['vnp_ResponseCode'] == '00')
						{
							 $thanhtoan = true;
						
						}
						elseif ($inputData['vnp_ResponseCode'] == '02')
						{
							$error[] = 'Đơn hàng đã được xác nhận!';
						}
						elseif ($inputData['vnp_ResponseCode'] == '04')
						{
							$error[] = 'Số tiền không hợp lệ!';
						}
						elseif ($inputData['vnp_ResponseCode'] == '01')
						{
							$error[] = 'Không tìm thấy giao dịch xác nhận!';
						}
						elseif ($inputData['vnp_ResponseCode'] == '97')
						{
							$error[] = 'Chữ ký không hợp lệ!';
						}
						elseif ($inputData['vnp_ResponseCode'] == '99')
						{
							$error[] = 'Lỗi hệ thống khác!';
						}
						elseif ($inputData['vnp_ResponseCode'] == '24')
						{
							$error[] = 'Giao dịch không thành công!';
						}
						
                    
                } else {
                    $error[] = 'Thanh toán thất bại!';
                }
            }
            else
            {
                $error[] = 'Số tiền không hợp lệ!';
            }
            

        }
		else
		{
			$error[] = 'Đơn hàng không tìm thấy!';
		}
    }
    else
    {
        $error[] = 'Chữ ký không hợp lệ!';
    }

    // ket thuc xu ly chuan
    

if (!empty($error))
{	
	
    $xtpl->assign('ERROR', implode('<br />', $error));
    $xtpl->parse('main.error');
	/*
	if(!empty($inputData['vnp_TxnRef']))
	{
		send_mail_payment_fail($inputData['vnp_TxnRef']);
	}*/
}

if ($thanhtoan)
{
	// thông tin đơn hàng
	// lấy thông tin order code
	$array_order = array();
	if(!empty($inputData['vnp_TxnRef']))
	{
		$list_order = $db->query('SELECT order_code FROM ' . TABLE .'_order WHERE id IN('. $inputData['vnp_TxnRef'] .')')->fetchAll();
		foreach($list_order as $order)
		{
			$array_order[] = $order['order_code'];
		}
		
		$info_order = $db->query('SELECT * FROM ' . TABLE .'_order WHERE id IN('. $inputData['vnp_TxnRef'] .')')->fetch();
		
		
		$xtpl->assign('LOGO_SRC', NV_BASE_SITEURL . $global_config['site_logo']);
		
		$xtpl->assign('info_order', $info_order);
	}
	
	$inputData['vnp_txnref'] = implode(' - ',$array_order);
	
	$nam = substr( $inputData['vnp_PayDate'],  0, 4);
	$thang = substr( $inputData['vnp_PayDate'],  4, 2);
	$ngay = substr( $inputData['vnp_PayDate'],  6, 2);
	$gio = substr( $inputData['vnp_PayDate'],  8, 2);
	$phut = substr( $inputData['vnp_PayDate'],  10, 2);
	
	$inputData['date_create'] = $ngay . '/' . $thang . '/' . $nam . ' - ' . $gio . ':' . $phut;
	
	$inputData['format_vnp_Amount'] = number_format($inputData['vnp_Amount']/100,0,",",",");
	$xtpl->assign('thanhtoan', $inputData);
    $xtpl->parse('main.thanhcong');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

$page_title = $lang_module['payment_vnpay_success'];

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
=======
	sleep(2);

	$order_code = $nv_Request->get_title('order_code', 'get', '', 1);

	if($order_code == '' ){
		nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name );
	}else{
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
		if($payment_method == 'vnpay'){
			$data = $_REQUEST;
		
			if(empty($data))
			{
				nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '='. $module_name, true);
			}
			
			foreach ($data as $key => $value)
			{
				if (substr($key, 0, 4) == "vnp_")
				{
					$inputData[$key] = $value;
				}
			}
		}
		$error = CheckPaymentOrder($payment_method,$order_code,$inputData);	
		$data = GetPaymentStatus($payment_method,$order_code,$error,$inputData);
		 if($data['status']==0){
			$error = $data['error'];
		} 
		if (!empty($error))
		{	
			
			$xtpl->assign('ERROR', implode('<br />', $error));
			$xtpl->parse('main.error');
			/*
			if(!empty($inputData['vnp_TxnRef']))
			{
				send_mail_payment_fail($inputData['vnp_TxnRef']);
			}*/
		}
			
		

		if ($data['status'])
		{
			// thông tin đơn hàng
			// lấy thông tin order code
		/* 	if($payment_method == 'vnpay'){
				$order_code = $inputData['vnp_TxnRef'];
			}elseif($payment_method == 'recieve'){
				$order_code = $inputData['order_code'];
			} */	
			$array_order = array();
			if(!empty($order_code))
			{
				$list_orders = GetInfoOrderByID($order_code);
				$order_code_array = explode(",",$order_code);
				$info_order = $list_orders[$order_code_array[0]];
				//$list_order = $db->query('SELECT order_code FROM ' . TABLE .'_order WHERE id IN('. $order_code .')')->fetchAll();
				foreach($list_orders as $order)
				{
					$array_order[] = $order['order_code'];
				}
				$xtpl->assign('info_order', $info_order);
				
				
			}
			if($payment_method == 'vnpay'){
				$inputData['vnp_txnref'] = implode(' - ',$array_order);
				
				$nam = substr( $inputData['vnp_PayDate'],  0, 4);
				$thang = substr( $inputData['vnp_PayDate'],  4, 2);
				$ngay = substr( $inputData['vnp_PayDate'],  6, 2);
				$gio = substr( $inputData['vnp_PayDate'],  8, 2);
				$phut = substr( $inputData['vnp_PayDate'],  10, 2);
				
				$inputData['date_create'] = $ngay . '/' . $thang . '/' . $nam . ' - ' . $gio . ':' . $phut;
				
				$inputData['format_vnp_Amount'] = number_format($inputData['vnp_Amount']/100,0,",",",");
				$xtpl->assign('thanhtoan', $inputData);
			}elseif($payment_method == 'recieve'){
				$inputData['vnp_txnref'] = implode(' - ',$array_order);
				
				$inputData['date_create'] = date("d/m/Y H:i",$info_order['time_add']);//$ngay . '/' . $thang . '/' . $nam . ' - ' . $gio . ':' . $phut;
				
				$inputData['format_Amount'] = number_format($data['sum_total_payment'],0,",",",");
				$xtpl->assign('thanhtoan', $inputData);
			}elseif($payment_method == 'momo'){
				require_once(NV_ROOTDIR.'modules/retails/payment/momo.complete.php');
				
			}
			
			if($user_info['userid']){
				$xtpl->parse('main.thanhcong.history');
			}
			
			$xtpl->parse('main.thanhcong');
		}

		$xtpl->parse('main');
		$contents = $xtpl->text('main');

		$page_title = $lang_module['payment_' . $payment_method . '_success'];

		include NV_ROOTDIR . '/includes/header.php';
		echo nv_site_theme($contents);
		include NV_ROOTDIR . '/includes/footer.php';
	}
	
>>>>>>> dev


