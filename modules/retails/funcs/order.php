<<<<<<< HEAD
<?php
	
	/**
		* @Project NUKEVIET 4.x
		* @Author VINADES.,JSC <contact@vinades.vn>
		* @Copyright (C) 2020 VINADES.,JSC. All rights reserved
		* @License GNU/GPL version 2 or any later version
		* @Createdate Thu, 24 Dec 2020 01:27:14 GMT
	*/
	
	if (!defined('NV_IS_MOD_RETAILSHOPS'))
	die('Stop!!!');
	if (!defined('NV_IS_USER')) {
		echo '<script language="javascript">';
		echo 'window.location = "'.nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users' . '&' . NV_OP_VARIABLE . '=login',true).'"';
		echo '</script>';
		}else{
		$check_seller=$db->query('SELECT count(*) FROM '.TABLE.'_seller_management where userid='.$user_info['userid'])->fetchColumn();
		if($check_seller>0){
			echo '<script language="javascript">';
			echo 'alert("Bạn đã là người bán nên không thể mua hàng. Vui lòng tạo lại tài khoản người mua");window.location = "'.nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=retails' . '&' . NV_OP_VARIABLE . '=main',true).'"';
			echo '</script>';
		}
	}
	$mod = $nv_Request->get_string('mod', 'post, get', 0);
	
	if($mod=="add_address_ajax"){
		// xu ly load form them dia chi nhan hang cho tai khoan
		
		$form_address = form_address();
		die($form_address);
	}
	
	
	
	if($mod=="set_default"){
		$id = $nv_Request->get_int('id', 'get',0);
		$userid = $nv_Request->get_int('userid', 'get',0);
		$db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_address SET status = 0 WHERE userid = ' . $userid);
		$db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_address SET status = 1 WHERE id = ' . $id);
		$json[] = ['status'=>'OK', 'text'=>'Đặt địa chỉ mặc định thành công'];
		print_r(json_encode($json[0]));die(); 
	}
	$info_order_old=$db->query('SELECT * FROM ' . TABLE . '_order where userid=' . $user_info['userid'] . ' and status>=3 order by id DESC limit 1')->fetch(); 
	$status_check=0;
	foreach($_SESSION[$module_name . '_cart'] as $value){
		foreach($value as $value_store){
			foreach($value_store as $value_product){
				if($value_product['status_check']==1){
					$status_check=1;
				}
			}
		}
	}
	
	
	
	
	if($status_check==0){
		
		// kiểm tra trạng thái session đã thanh toán chưa. giỏ hàng trống
		if(isset($_SESSION[$module_name . '_vnpay']) and !$_SESSION[$module_name . '_vnpay'])
		{
			$_SESSION[$module_name . '_vnpay'] = true;
			
			echo '<script language="javascript">';
			echo 'alert("Thanh toán thất bại!");window.location = "'.nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=retails' . '&' . NV_OP_VARIABLE . '=re-payment',true).'"';
			echo '</script>';
		}
		else
		{
			echo '<script language="javascript">';
			echo 'alert("Vui lòng chọn ít nhất 1 sản phẩm để thực hiện chức năng này");window.location = "'.NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' .$module_name. '&' . NV_OP_VARIABLE . '=cart'.'"';
			echo '</script>';
		}
	}
	$list_address = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_address WHERE userid = ' . $user_info['userid'] )->fetchAll();
	
	// kiểm tra user đã có địa chỉ chưa
	$check_address = $db->query('SELECT COUNT(id) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_address WHERE userid = ' . $user_info['userid'] )->fetchColumn();
	if(!$check_address){
		echo '<script language="javascript">';
		echo 'alert("Bạn chưa thiết lập địa chỉ!");window.location = "'.nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=retails' . '&' . NV_OP_VARIABLE . '=address&id=0',true).'"';
		echo '</script>';
	}
	
	//print_r($list_address);
	$address_df = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_address WHERE userid = ' . $user_info['userid'] . ' AND status = 1' )->fetch();
	
	
	$contents = nv_theme_retailshops_order($_SESSION[$module_name . '_cart'],$info_order_old,$list_address,$address_df);
	$page_title = $lang_module['order'];
	
	
	$_SESSION[$module_name . '_vnpay'] = false;
	unset($_SESSION['shop']);
	$_SESSION['back_link'] = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '='. $module_name .'&amp;' . NV_OP_VARIABLE . '=' . $op, true);
	
	
	$array_mod_title[] = array(
	'catid' => 0,
	'title' => $lang_module['cart'],
	'link' => NV_MY_DOMAIN .'/'. $module_name .'/cart/'
	);
	$array_mod_title[] = array(
	'catid' => 0,
	'title' => $lang_module['order'],
	'link' => NV_MY_DOMAIN .'/'. $module_name .'/'.$op.'/'
	);
	include NV_ROOTDIR . '/includes/header.php';
	echo nv_site_theme($contents);
=======
<?php
	
	/**
		* @Project NUKEVIET 4.x
		* @Author VINADES.,JSC <contact@vinades.vn>
		* @Copyright (C) 2020 VINADES.,JSC. All rights reserved
		* @License GNU/GPL version 2 or any later version
		* @Createdate Thu, 24 Dec 2020 01:27:14 GMT
	*/
	
	if (!defined('NV_IS_MOD_RETAILSHOPS'))
	die('Stop!!!');
	if (!defined('NV_IS_USER')) {
		echo '<script language="javascript">';
		echo 'window.location = "'.nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users' . '&' . NV_OP_VARIABLE . '=login',true).'"';
		echo '</script>';
		}else{
		$check_seller=$db->query('SELECT count(*) FROM '.TABLE.'_seller_management where userid='.$user_info['userid'])->fetchColumn();
		if($check_seller>0){
			echo '<script language="javascript">';
			echo 'alert("Bạn đã là người bán nên không thể mua hàng. Vui lòng tạo lại tài khoản người mua");window.location = "'.nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=retails' . '&' . NV_OP_VARIABLE . '=main',true).'"';
			echo '</script>';
		}
	}
	$mod = $nv_Request->get_string('mod', 'post, get', 0);
	
	if($mod=="add_address_ajax"){
		// xu ly load form them dia chi nhan hang cho tai khoan
		
		$form_address = form_address();
		die($form_address);
	}
	
	
	
	if($mod=="set_default"){
		$id = $nv_Request->get_int('id', 'get',0);
		$userid = $nv_Request->get_int('userid', 'get',0);
		$db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_address SET status = 0 WHERE userid = ' . $userid);
		$db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_address SET status = 1 WHERE id = ' . $id);
		$json[] = ['status'=>'OK', 'text'=>'Đặt địa chỉ mặc định thành công'];
		print_r(json_encode($json[0]));die(); 
	}
	$info_order_old=$db->query('SELECT * FROM ' . TABLE . '_order where userid=' . $user_info['userid'] . ' and status>=3 order by id DESC limit 1')->fetch(); 
	$status_check=0;
	foreach($_SESSION[$module_name . '_cart'] as $value){
		foreach($value as $value_store){
			foreach($value_store as $value_product){
				if($value_product['status_check']==1){
					$status_check=1;
				}
			}
		}
	}
	
	
	
	
	if($status_check==0){
		
		// kiểm tra trạng thái session đã thanh toán chưa. giỏ hàng trống
		if(isset($_SESSION[$module_name . '_vnpay']) and !$_SESSION[$module_name . '_vnpay'])
		{
			$_SESSION[$module_name . '_vnpay'] = true;
			
			echo '<script language="javascript">';
			echo 'alert("Thanh toán thất bại!");window.location = "'.nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=retails' . '&' . NV_OP_VARIABLE . '=re-payment',true).'"';
			echo '</script>';
		}
		else
		{
			echo '<script language="javascript">';
			echo 'alert("Vui lòng chọn ít nhất 1 sản phẩm để thực hiện chức năng này");window.location = "'.NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' .$module_name. '&' . NV_OP_VARIABLE . '=cart'.'"';
			echo '</script>';
		}
	}
	$list_address = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_address WHERE userid = ' . $user_info['userid'] )->fetchAll();
	
	// kiểm tra user đã có địa chỉ chưa
	$check_address = $db->query('SELECT COUNT(id) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_address WHERE userid = ' . $user_info['userid'] )->fetchColumn();
	if(!$check_address){
		echo '<script language="javascript">';
		echo 'alert("Bạn chưa thiết lập địa chỉ!");window.location = "'.nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=retails' . '&' . NV_OP_VARIABLE . '=address&id=0',true).'"';
		echo '</script>';
	}
	
	//print_r($list_address);
	$address_df = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_address WHERE userid = ' . $user_info['userid'] . ' AND status = 1' )->fetch();
	
	
	$contents = nv_theme_retailshops_order($_SESSION[$module_name . '_cart'],$info_order_old,$list_address,$address_df);
	$page_title = $lang_module['order'];
	
	
	$_SESSION[$module_name . '_vnpay'] = false;
	unset($_SESSION['shop']);
	$_SESSION['back_link'] = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '='. $module_name .'&amp;' . NV_OP_VARIABLE . '=' . $op, true);
	
	
	$array_mod_title[] = array(
	'catid' => 0,
	'title' => $lang_module['cart'],
	'link' => NV_MY_DOMAIN .'/'. $module_name .'/cart/'
	);
	$array_mod_title[] = array(
	'catid' => 0,
	'title' => $lang_module['order'],
	'link' => NV_MY_DOMAIN .'/'. $module_name .'/'.$op.'/'
	);
	include NV_ROOTDIR . '/includes/header.php';
	echo nv_site_theme($contents);
>>>>>>> ef5fa8aaa78785a2fbdffa493fb4f01b450fd53c
include NV_ROOTDIR . '/includes/footer.php';