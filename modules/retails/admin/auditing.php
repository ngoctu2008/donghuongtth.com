<?php
	
	/**
		* @Project NUKEVIET 4.x
		* @Author VINADES.,JSC <contact@vinades.vn>
		* @Copyright (C) 2021 VINADES.,JSC. All rights reserved
		* @License GNU/GPL version 2 or any later version
		* @Createdate Wed, 27 Jan 2021 10:01:19 GMT
	*/
	
	if (!defined('NV_IS_FILE_ADMIN'))
	die('Stop!!!');
	
	$xtpl = new XTemplate($op . '.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
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
	
	$status = $nv_Request->get_int( 'status', 'post,get', 0);
	$sea_flast = $nv_Request->get_int( 'sea_flast', 'post,get' );
	$ngay_den = $nv_Request->get_title( 'ngay_den', 'post,get' );
	$ngay_tu = $nv_Request->get_title( 'ngay_tu', 'post,get' );
	$store_id = $nv_Request->get_int('store_id', 'post,get',0);
	
	$real_week = nv_get_week_from_time( NV_CURRENTTIME );
	$week = $real_week[0];
	$year = $real_week[1];
	$this_year = $real_week[1];
	$time_per_week = 86400 * 7;
	$time_start_year = mktime( 0, 0, 0, 1, 1, $year );
	$time_first_week = $time_start_year - ( 86400 * ( date( 'N', $time_start_year ) - 1 ) );
	
	$tuannay = array(
	'from' => nv_date( 'd-m-Y', $time_first_week + ( $week - 1 ) * $time_per_week ),
	'to' => nv_date( 'd-m-Y', $time_first_week + ( $week - 1 ) * $time_per_week + $time_per_week - 1 ),
	);
	$tuantruoc = array(
	'from' => nv_date( 'd-m-Y', $time_first_week + ( $week - 2 ) * $time_per_week ),
	'to' => nv_date( 'd-m-Y', $time_first_week + ( $week - 2 ) * $time_per_week + $time_per_week - 2 ),
	);
	$tuankia = array(
	'from' => nv_date( 'd-m-Y', $time_first_week + ( $week - 3 ) * $time_per_week ),
	'to' => nv_date( 'd-m-Y', $time_first_week + ( $week - 3 ) * $time_per_week + $time_per_week - 3 ),
	);
	
	$thangnay = array(
	'from' => date( 'd-m-Y', strtotime( 'first day of this month' ) ),
	'to' => date( 'd-m-Y', strtotime( 'last day of this month' ) ),
	);
	$thangtruoc = array(
	'from' => date( 'd-m-Y', strtotime( 'first day of last month' ) ),
	'to' => date( 'd-m-Y', strtotime( 'last day of last month' ) ),
	);
	$namnay = array(
	'from' => date( 'd-m-Y', strtotime( 'first day of january this year' ) ),
	'to' => date( 'd-m-Y', strtotime( 'last day of december this year' ) ),
	);
	$namtruoc = array(
	'from' => date( 'd-m-Y', strtotime( 'first day of january last year' ) ),
	'to' => date( 'd-m-Y', strtotime( 'last day of december last year' ) ),
	);
	$xtpl->assign( 'TUANNAY', $tuannay );
	
	$xtpl->assign( 'TUANTRUOC', $tuantruoc );
	
	$xtpl->assign( 'TUANKIA', $tuankia );
	
	$xtpl->assign( 'HOMNAY', date( 'd-m-Y', NV_CURRENTTIME ) );
	$xtpl->assign( 'HOMQUA', date( 'd-m-Y', strtotime( 'yesterday' ) ) );
	$xtpl->assign( 'THANGNAY', $thangnay );
	
	$xtpl->assign( 'THANGTRUOC', $thangtruoc );
	
	$xtpl->assign( 'NAMNAY', $namnay );
	
	$xtpl->assign( 'NAMTRUOC', $namtruoc );
	
	if ( preg_match( '/^([0-9]{1,2})-([0-9]{1,2})-([0-9]{4})$/', $ngay_tu, $m ) )
	{
		$_hour = 0;
		$_min = 0;
		$ngay_tu = mktime( $_hour, $_min, 0, $m[2], $m[1], $m[3] );
		} else {
		$ngay_tu = 0;
	}
	
	if ( preg_match( '/^([0-9]{1,2})-([0-9]{1,2})-([0-9]{4})$/', $ngay_den, $m ) )
	{
		$_hour = 23;
		$_min = 59;
		$ngay_den = mktime( $_hour, $_min, 0, $m[2], $m[1], $m[3] );
		} else {
		$ngay_den = 0;
	}
	
	$where = '';
	$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op. '&sea_flast=' . $sea_flast;
	
	if ( $sea_flast != 9 ) {
		
		if ( $ngay_tu > 0 and $ngay_den > 0 )
		{
			$where .= ' AND time_edit >= '. $ngay_tu . ' AND time_edit <= '. $ngay_den;
			$base_url .= '&ngay_tu='. date('d-m-Y', $ngay_tu) . '&ngay_den='. date('d-m-Y', $ngay_den);
		} else if ( $ngay_tu > 0 )
		{
			$where .= ' AND time_edit >= '. $ngay_tu;
			$xtpl->assign( 'ngay_den', date( 'd-m-Y', NV_CURRENTTIME ));
			$base_url .= '&ngay_tu='. date('d-m-Y', $ngay_tu);
		} else if ( $ngay_den > 0 )
		{
			$where .= ' AND time_edit <= '. $ngay_den;
			$base_url .= '&ngay_den='. date('d-m-Y', $ngay_den);
			$xtpl->assign( 'ngay_tu', date( 'd-m-Y', $ngay_den ));
			} else{
			$ngay_tu = $time_first_week + ( $week - 1 ) * $time_per_week ;
			$ngay_den = $time_first_week + ( $week - 1 ) * $time_per_week + $time_per_week - 1 ;
			$sea_flast = 3;
			$where .= ' AND time_edit >= '. $ngay_tu . ' AND time_edit <= '. $ngay_den;
			$base_url .= '&ngay_tu='. date('d-m-Y', $ngay_tu) . '&ngay_den='. date('d-m-Y', $ngay_den);
		}
	}
	
	if($status == 0){
		$where .= ' AND status = 7';
		$xtpl->assign( 'SELECT_SUCCESS', 'selected="selected"' );
	} else if($status == 1){
		$where .= ' AND (status = 3 OR status = 2)';
		$xtpl->assign( 'SELECT_DELIVERING', 'selected="selected"' );
	} else if($status == 2){
		$where .= ' AND status = 6';
		$xtpl->assign( 'SELECT_FAIL', 'selected="selected"' );
	}
	
	if ( $sea_flast == '1' ) {
		$xtpl->assign( 'SELECT1', 'selected="selected"' );
	}
	if ( $sea_flast == '2' ) {
		$xtpl->assign( 'SELECT2', 'selected="selected"' );
	}
	if ( $sea_flast == '3' ) {
		$xtpl->assign( 'SELECT3', 'selected="selected"' );
	}
	if ( $sea_flast == '4' ) {
		$xtpl->assign( 'SELECT4', 'selected="selected"' );
	}
	if ( $sea_flast == '5' ) {
		$xtpl->assign( 'SELECT5', 'selected="selected"' );
	}
	if ( $sea_flast == '6' ) {
		$xtpl->assign( 'SELECT6', 'selected="selected"' );
	}
	if ( $sea_flast == '7' ) {
		$xtpl->assign( 'SELECT7', 'selected="selected"' );
	}
	if ( $sea_flast == '8' ) {
		$xtpl->assign( 'SELECT8', 'selected="selected"' );
	}
	if ( $sea_flast == '9' ) {
		$xtpl->assign( 'SELECT9', 'selected="selected"' );
	}
	
	if ( $ngay_tu > 0 )
	$xtpl->assign( 'ngay_tu', date( 'd-m-Y', $ngay_tu ) );
	if ( $ngay_den > 0 )
	$xtpl->assign( 'ngay_den', date( 'd-m-Y', $ngay_den ) );
	
	if ($store_id) {
		$where .= ' AND store_id ='. $store_id;
        $base_url .= '&store_id=' . $store_id;
	}
	
	$mod = $nv_Request->get_title('mod', 'post,get','');
	if($mod == 'download')
	{
		$file_name = $nv_Request->get_string( 'file_name', 'get', '' );
		
		$file_path = NV_ROOTDIR . '/' . NV_TEMP_DIR . '/' . $file_name;
		
		if( file_exists( $file_path ) )
		{
			header( 'Content-Description: File Transfer' );
			header( 'Content-Type:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' );
			header( 'Content-Disposition: attachment; filename=' . $file_name );
			header( 'Content-Transfer-Encoding: binary' );
			header( 'Expires: 0' );
			header( 'Cache-Control: must-revalidate' );
			header( 'Pragma: public' );
			header( 'Content-Length: ' . filesize( $file_path ) );
			readfile( $file_path );
			// ob_clean();
			flush();
			nv_deletefile( $file_path );
			
			exit();
		}else
		{
			die('File not exists !');
		}
	}
	
	if($mod=='is_download'){
		ini_set( 'memory_limit', '512M' );
		set_time_limit( 0 );
		
		$list_order = $db->query('SELECT store_id, sum(total_product) as sum_total_product FROM ' . TABLE .'_order WHERE 1 '. $where . ' GROUP BY store_id ORDER BY sum_total_product DESC')->fetchAll();
		
		$stt = 0;
		foreach ($list_order as $view) {
			
			$data_array = array();
			
			// tên seller
			$data_array['company_name'] = get_info_store($view['store_id'])['company_name'];
			
			// Tổng tiền hàng
			$data_array['sum_total_product'] = $view['sum_total_product'];
			
			// phí sàn
			$data_array['phisan'] = phisan_ecng($view['store_id'], $status, $ngay_tu, $ngay_den);
			$data_array['ecng_nhan'] = $data_array['phisan'];
			
			// phí bảo hiểm hàng hóa
			$data_array['insurance'] = phi_baohiem($view['store_id'], $status, $ngay_tu, $ngay_den);
			$data_array['ecng_nhan'] += $data_array['insurance'];
			$data_array['payment_method_name'] = $global_payport[$view['payment_method']]['paymentname'];
			// phí vnpay
			$data_array['vnpay'] = phi_vnpay($view['store_id'], $status, $ngay_tu, $ngay_den);
			$data_array['ecng_nhan'] += $data_array['vnpay'];
			
			// phí ship
			$data_array['sum_ship'] = phi_ship($view['store_id'], $status, $ngay_tu, $ngay_den);
			
			// voucher
			$data_array['sum_voucher'] = voucher($view['store_id'], $status, $ngay_tu, $ngay_den);
			
			// phí phạt
			$data_array['phi_phat'] = phi_phat($view['store_id'], $status, $ngay_tu, $ngay_den);
			$data_array['ecng_nhan'] += $data_array['phi_phat'];
			
			// seller nhận
			$data_array['seller_nhan'] = $data_array['sum_total_product'] - $data_array['ecng_nhan'];
			
			$dataContent[] = $data_array;	
		}
		
		
		$page_title = 'DANH SÁCH ĐƠN HÀNG';
		
		$Excel_Cell_Begin = 3; // Dong bat dau viet du lieu
		
		$spreadsheet = \PhpOffice\PhpSpreadsheet\IOFactory::load(NV_ROOTDIR . '/modules/' . $module_file . '/template_excel/doisoat.xlsx');
		
		
		$worksheet = $spreadsheet->getActiveSheet();
		
		$worksheet->setTitle( $page_title );
		
		// Set page orientation and size
		$worksheet->getPageSetup()->setOrientation( phpOffice\PhpSpreadsheet\Worksheet\PageSetup::ORIENTATION_LANDSCAPE );
		$worksheet->getPageSetup()->setPaperSize( phpOffice\PhpSpreadsheet\Worksheet\PageSetup::PAPERSIZE_A4 );
		$worksheet->getPageSetup()->setHorizontalCentered( true );
		
		$spreadsheet->getActiveSheet()->getPageSetup()->setRowsToRepeatAtTopByStartAndEnd( 1, $Excel_Cell_Begin );
		
		// ngày xuất
		$TextColumnDate = PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex( 2 );
		if(!$ngay_tu && !$ngay_den){
			$worksheet->setCellValue( $TextColumnDate . 2, 'Toàn thời gian');
			} else{
			$worksheet->setCellValue( $TextColumnDate . 2, date( 'd-m-Y', $ngay_tu ) . ' - ' . date( 'd-m-Y', $ngay_den ));
		}
		// Du lieu
		$array_key_data = array();
		$array_key_data[] = 'company_name';
		$array_key_data[] = 'sum_total_product';
		$array_key_data[] = 'phisan';
		$array_key_data[] = 'insurance';
		$array_key_data[] = 'payment';
		$array_key_data[] = 'vnpay';
		$array_key_data[] = 'sum_ship';
		$array_key_data[] = 'sum_voucher';
		$array_key_data[] = 'phi_phat';
		$array_key_data[] = 'ecng_nhan';
		$array_key_data[] = 'seller_nhan';
		
		$pRow = $Excel_Cell_Begin;
		
		foreach ($dataContent as $row) 
		{
			$columnIndex2 = 0;
			$pRow++;
			foreach( $array_key_data as $key_data )
			{
				++$columnIndex2;
				$TextColumnIndex = PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex( $columnIndex2 );
				$highestColumn = $TextColumnIndex; 
				$highestRow = $pRow; 
				$worksheet->setCellValue( $TextColumnIndex . $pRow, $row[$key_data] );
			}
		}
		
		
		
		$file_name = 'Doi_soat.xlsx';
		
		$file_path = NV_ROOTDIR . '/' . NV_TEMP_DIR . '/' . $file_name;
		
		header( 'Content-Type: application/vnd.ms-excel' );
		header( 'Content-Disposition: attachment;filename="'. $file_name .'"' );
		header( 'Cache-Control: max-age=0' );
		
		$writer = \PhpOffice\PhpSpreadsheet\IOFactory::createWriter($spreadsheet, 'Xlsx');
		$writer->save($file_path);
		
		$link = NV_BASE_ADMINURL . "index.php?" . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '='.$op.'&mod=download&file_name=' . $file_name;  
		
		die($link);	
		
	}
	
	$show_view = false;
	if (!$nv_Request->isset_request('id', 'post,get')) {
		$show_view = true;
		$per_page = 20;
		$page = $nv_Request->get_int('page', 'post,get', 1);
		
		$num_items = $db->query('SELECT COUNT(DISTINCT(store_id)) FROM ' . TABLE .'_order WHERE 1 '. $where)->fetchColumn();
		
		$db->sqlreset()
		->select('store_id, sum(total_product) as sum_total_product')
		->from(' '.TABLE .'_order')
		->where(' 1 '. $where)
		->group('store_id')
        ->order(' sum_total_product DESC')
        ->limit($per_page)
        ->offset(($page - 1) * $per_page);
		$sth = $db->prepare($db->sql());
		$sth->execute();
	}
	// Fetch Limit
	//$list_order = $db->query('SELECT store_id, sum(total_product) as sum_total_product FROM ' . TABLE .'_order WHERE status = 3'. $where . ' GROUP BY store_id ORDER BY sum_total_product DESC')->fetchAll();
	//$total_product_seller = $db->query('SELECT store_id, sum(total_product) as sum_total_product FROM '.TABLE .'_order WHERE (status = 3 OR status = 7) '. $where .' GROUP BY store_id ORDER BY sum_total_product DESC limit '. $per_page .' offset ' . ($page - 1) * $per_page)->fetchAll();
	
	$list_store = get_full_store();
	foreach ( $list_store as $value2 ) {
		$xtpl->assign( 'store_id_list', array(
        'key' => $value2['id'],
        'title' => $value2['company_name'],
        'selected' => ( $value2['id'] == $store_id ) ? ' selected="selected"' : '' ) );
        $xtpl->parse( 'main.store_id' );
	}
	if ($show_view) {
		$generate_page = nv_generate_page($base_url, $num_items, $per_page, $page);
		if (!empty($generate_page)) {
			$xtpl->assign('NV_GENERATE_PAGE', $generate_page);
			$xtpl->parse('main.generate_page');
		}
		$number = $page > 1 ? ($per_page * ($page - 1)) + 1 : 1;
		
		
		
		$sum_total_product = 0;
		$insurance = 0;
		$phisan = 0;
		$vnpay = 0;
		$ship = 0;
		$voucher = 0;
		$phi_phat = 0;
		$ecng_nhan = 0;
		$seller_nhan = 0;
		$key = -1;
		while ($view = $sth->fetch()) {
			$key++;
			$xtpl->assign('weight', $number);
			$number++;
			
			$view['seller_nhan'] = 0;
			
			$info_store = get_info_store($view['store_id']);
			$xtpl->assign('info_store', $info_store);
			
			// tổng tiền hàng
			$view['sum_total_product_format'] = number_format($view['sum_total_product']);
			$sum_total_product = $sum_total_product + $view['sum_total_product'];
			
			// link tổng sp
			$link_sp = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=listorder&status_search=3&store_id='. $view['store_id'] .'&ngay_tu=' . date('d-m-Y',$ngay_tu) .'&ngay_den=';
			if($ngay_den > 0){
				$view['link_total_product'] = $link_sp . date('d-m-Y',$ngay_den) .'';
				} else{
				$view['link_total_product'] = $link_sp . date('d-m-Y', NV_CURRENTTIME) .'';
			}
			
			// phí bảo hiểm hàng hóa
			$view['insurance'] = phi_baohiem($view['store_id'], $status, $ngay_tu, $ngay_den);
			$view['insurance_format'] = number_format($view['insurance']);
			$insurance = $insurance + $view['insurance'];
			$view['ecng_nhan'] = $view['insurance'];
			
			// phí sàn
			$view['phisan'] = phisan_ecng($view['store_id'], $status, $ngay_tu, $ngay_den);
			$view['phisan_format'] = number_format($view['phisan']);
			$phisan = $phisan + $view['phisan'];
			$view['ecng_nhan'] += $view['phisan'];
			$view['payment_method_name'] = $global_payport[$view['payment_method']]['paymentname'];
			// phí vnpay
			$view['vnpay'] = phi_vnpay($view['store_id'], $status, $ngay_tu, $ngay_den);
			$view['vnpay_format'] = number_format($view['vnpay']);
			$vnpay = $vnpay + $view['vnpay'];
			$view['ecng_nhan'] += $view['vnpay'];
			
			// Phí ship
			$view['sum_ship'] = phi_ship($view['store_id'], $status, $ngay_tu, $ngay_den);
			$view['ship_format'] = number_format($view['sum_ship']);
			$ship += $view['sum_ship'];
			
			// Voucher
			$view['sum_voucher'] = voucher($view['store_id'], $status, $ngay_tu, $ngay_den);
			$view['voucher_format'] = number_format($view['sum_voucher']);
			$voucher += $view['sum_voucher'];
			$view['ecng_nhan'] += $view['sum_voucher'];
			
			// phí phạt	
			$view['phi_phat'] = phi_phat($view['store_id'], $status, $ngay_tu, $ngay_den);
			$view['phi_phat_format'] = number_format($view['phi_phat']);
			$phi_phat = $phi_phat + $view['phi_phat'];
			$view['ecng_nhan'] += $view['phi_phat'];
			
			// link xem chi tiết đối soát shop
			$view['link'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=auditing_detail&store_id='. $view['store_id'] .'&ngay_tu=' . date('d-m-Y',$ngay_tu) .'&ngay_den=' . date('d-m-Y',$ngay_den) .'&sea_flast=' . $sea_flast . '&status=' . $status;
			
			// seller nhận
			$view['seller_nhan'] = $view['sum_total_product'] - $view['ecng_nhan'];
			$view['seller_nhan_format'] = number_format($view['seller_nhan']);
			
			// ecng nhận
			$view['ecng_nhan_format'] = number_format($view['ecng_nhan']);
			
			$ecng_nhan += $view['ecng_nhan'];
			$seller_nhan += $view['seller_nhan'];
			
			$xtpl->assign('VIEW', $view);
			$xtpl->parse('main.loop');
		}
	}
	
	
	$xtpl->assign('sum_total_product', number_format($sum_total_product));
	$xtpl->assign('insurance', number_format($insurance));
	$xtpl->assign('phisan', number_format($phisan));
	$xtpl->assign('ship', number_format($ship));
	$xtpl->assign('voucher', number_format($voucher));
	$xtpl->assign('vnpay', number_format($vnpay));
	$xtpl->assign('phi_phat', number_format($phi_phat));
	$xtpl->assign('ecng_nhan', number_format($ecng_nhan));
	$xtpl->assign('seller_nhan', number_format($seller_nhan));
	
	$xtpl->parse('main');
	$contents = $xtpl->text('main');
	
	$page_title = $lang_module['auditing'];
	
	include NV_ROOTDIR . '/includes/header.php';
	echo nv_admin_theme($contents);
	include NV_ROOTDIR . '/includes/footer.php';
