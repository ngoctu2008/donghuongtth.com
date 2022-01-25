<?php


	sleep(2);
	$order_code = $nv_Request->get_title('order_code', 'get', '', 1);
	if($order_code == '' ){
		nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name );
	}else{
		$order = explode(",",$order_code);

		$orders = $db->query('SELECT * FROM ' . TABLE . '_order where id IN (' . $order_code . ' )')->fetchAll(); 
		$i = 0;
		$max_i = count($orders);
		$flag = false;
		if($max_i > 1){
			foreach($orders as $key=>$order){
				if($i<$max_i && $orders[$i+1]['time_add'] == $orders[$i]['time_add'] && $orders[$i+1]['payment_method'] == $orders[$i]['payment_method']){
					$flag = true;
				}
				$i++;
			}
		}else{
			$flag = true;
		}
		
		if($flag == false){
			nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name );
		}
		if($payment_method == 'vnpay'){

			
			$_SESSION[$module_name . '_vnpay'] = true;
		}
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
			$xtpl->assign('OP', $op);
			
			$thanhtoan = false;
		if($payment_method == 'vnpay'){
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
		}elseif($payment_method == 'recieve'){
			
			$thanhtoan = true;
			$inputData = array();
			$inputData['order_code'] = $nv_Request->get_title('order_code', 'get', '', 1);

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

	if ($thanhtoan)
	{
		// thông tin đơn hàng
		// lấy thông tin order code
		if($payment_method == 'vnpay'){
			$order_code = $inputData['vnp_TxnRef'];
		}elseif($payment_method == 'recieve'){
			$order_code = $inputData['order_code'];
		}	
		$array_order = array();
		if(!empty($order_code))
		{
			$list_order = $db->query('SELECT order_code FROM ' . TABLE .'_order WHERE id IN('. $order_code .')')->fetchAll();
			foreach($list_order as $order)
			{
				$array_order[] = $order['order_code'];
			}
			
			$info_order = $db->query('SELECT * FROM ' . TABLE .'_order WHERE id IN('. $order_code .')')->fetch();
			
			
			$xtpl->assign('LOGO_SRC', NV_BASE_SITEURL . $global_config['site_logo']);
			
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
			
			$inputData['format_Amount'] = number_format($info_order['total'],0,",",",");
			$xtpl->assign('thanhtoan', $inputData);
		}elseif($payment_method == 'momo'){
			require_once(NV_ROOTDIR.'modules/retails/payment/momo.complete.php');
			
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
	


