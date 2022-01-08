<?php
	
	/**
		* @Project TMS HOLDINGS
		* @Author TMS Holdings <contact@tms.vn>
		* @Copyright (C) 2020 TMS Holdings. All rights reserved
		* @License GNU/GPL version 2 or any later version
		* @Createdate Mon, 21 Dec 2020 09:08:19 GMT
	*/
	
	if (!defined('NV_SYSTEM'))
    die('Stop!!!');
	define('NV_IS_MOD_RETAILSHOPS', true);
	
	require_once NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
	
	$array_wishlist_id = [];
	$arr_cat_title = [];
	$catid = 0;
	$parentid = 0;
	$set_viewcat = '';
	
	$alias_detail = isset($array_op[0]) ? $array_op[0] : '';
	
	$array_page = explode('-', $alias_detail);
	$id = intval(end($array_page));
	
	if(!empty($array_op[0])){
		if(!empty(get_info_user_shops_username($array_op[0]))){
			$shop_id=get_info_user_shops_username($array_op[0])['id'];
			
			$userid_shop=get_info_user_shops_username($array_op[0])['userid_shop'];
			}else{
			$shop_id='';
			$userid_shop='';
		}
	}   
	if($id > 0){
		if($array_page[0]=='brand'){
			
			$op='view-brand';   
			}else{
			
			$info_product=get_info_product($id);
			
			if(($info_product['status']==1) and ($array_op[0] == $info_product['alias'] . '-'. $info_product['id']))
			{	
				$op='detail';	
				}else{
				echo '<script language="javascript">';
				echo 'window.location = "' . NV_BASE_SITEURL .'"';
				echo '</script>';
			}
		}
		}else{
		
		if(!empty($shop_id)){
			
			$op='viewcatshops';
			}else{
			if($alias_detail !=''){
				
				$cat_info=get_info_category_alias($alias_detail);
				$cat_info1 = get_info_category_shop_alias($alias_detail);
				
				if(!empty($cat_info)){
					$op='viewcat';
				}
				elseif(!empty($cat_info1)){
					$op='viewcatofshop';
				}
				elseif($array_op[0] =='block' and !empty($array_op[1]))
				{
					// kiểm tra block sản phẩm
					$check_block_product = $db->query('SELECT id FROM '. TABLE .'_block WHERE keyword ="'. $array_op[1] .'"')->fetchColumn();
					if($check_block_product)
					{
						$op = 'product-shock';
					}
				}
				
				}else{
				//Tìm kiếm sản phẩm
				
			}
		}
	}
	function gltJsonResponse($error = array(), $data = array())
	{
		$contents = array(
        'jsonrpc' => '2.0',
        'error' => $error,
        'data' => $data
		);
		
		header('Content-Type: application/json');
		echo json_encode($contents);
		die();
	}
	function nv_image_logo($fileupload)
	{
		global $global_config, $module_upload;
		
		if (empty($fileupload) or ! file_exists($fileupload)) {
			return;
		}
		
		$autologomod = explode(',', $global_config['autologomod']);
		
		if ($global_config['autologomod'] == 'all' or in_array($module_upload, $autologomod)) {
			if (! empty($global_config['upload_logo']) and file_exists(NV_ROOTDIR . '/' . $global_config['upload_logo'])) {
				
				$logo_size = getimagesize(NV_ROOTDIR . '/' . $global_config['upload_logo']);
				$file_size = getimagesize($fileupload);
				
				if ($file_size[0] <= 150) {
					$w = ceil($logo_size[0] * $global_config['autologosize1'] / 100);
					} elseif ($file_size[0] < 350) {
					$w = ceil($logo_size[0] * $global_config['autologosize2'] / 100);
					} else {
					if (ceil($file_size[0] * $global_config['autologosize3'] / 100) > $logo_size[0]) {
						$w = $logo_size[0];
						} else {
						$w = ceil($file_size[0] * $global_config['autologosize3'] / 100);
					}
				}
				
				$h = ceil($w * $logo_size[1] / $logo_size[0]);
				$x = $file_size[0] - $w - 5;
				$y = $file_size[1] - $h - 5;
				
				$config_logo = array();
				$config_logo['w'] = $w;
				$config_logo['h'] = $h;
				
				$config_logo['x'] = $file_size[0] - $w - 5; // Horizontal: Right
				$config_logo['y'] = $file_size[1] - $h - 5; // Vertical: Bottom
				
				// Logo vertical
				if (preg_match("/^top/", $global_config['upload_logo_pos'])) {
					$config_logo['y'] = 5;
					} elseif (preg_match("/^center/", $global_config['upload_logo_pos'])) {
					$config_logo['y'] = round(($file_size[1] / 2) - ($h / 2));
				}
				
				// Logo horizontal
				if (preg_match("/Left$/", $global_config['upload_logo_pos'])) {
					$config_logo['x'] = 5;
					} elseif (preg_match("/Center$/", $global_config['upload_logo_pos'])) {
					$config_logo['x'] = round(($file_size[0] / 2) - ($w / 2));
				}
				
				$createImage = new NukeViet\Files\Image($fileupload, NV_MAX_WIDTH, NV_MAX_HEIGHT);
				$createImage->addlogo(NV_ROOTDIR . '/' . $global_config['upload_logo'], '', '', $config_logo);
				$createImage->save(dirname($fileupload), basename($fileupload), 90);
			}
		}
	}
	function nv_resize_crop_images($img_path, $width, $height, $module_name = '', $id = 0)
	{
		$new_img_path = str_replace(NV_ROOTDIR, '', $img_path);
		if (file_exists($img_path)) {
			$imginfo = nv_is_image($img_path);
			$basename = basename($img_path);
			
			$basename = preg_replace('/^\W+|\W+$/', '', $basename);
			$basename = preg_replace('/[ ]+/', '_', $basename);
			$basename = strtolower(preg_replace('/\W-/', '', $basename));
			
			if ($imginfo['width'] > $width or $imginfo['height'] > $height) {
				$basename = preg_replace('/(.*)(\.[a-zA-Z]+)$/', $module_name . '_' . $id . '_\1_' . $width . '-' . $height . '\2', $basename);
				if (file_exists(NV_ROOTDIR . '/' . NV_TEMP_DIR . '/' . $basename)) {
					$new_img_path = NV_BASE_SITEURL . NV_TEMP_DIR . '/' . $basename;
					} else {
					$img_path = new NukeViet\Files\Image($img_path, NV_MAX_WIDTH, NV_MAX_HEIGHT);
					
					$thumb_width = $width;
					$thumb_height = $height;
					$maxwh = max($thumb_width, $thumb_height);
					if ($img_path->fileinfo['width'] > $img_path->fileinfo['height']) {
						$width = 0;
						$height = $maxwh;
						} else {
						$width = $maxwh;
						$height = 0;
					}
					
					$img_path->resizeXY($width, $height);
					$img_path->cropFromCenter($thumb_width, $thumb_height);
					$img_path->save(NV_ROOTDIR . '/' . NV_TEMP_DIR, $basename);
					
					if (file_exists(NV_ROOTDIR . '/' . NV_TEMP_DIR . '/' . $basename)) {
						$new_img_path = NV_BASE_SITEURL . NV_TEMP_DIR . '/' . $basename;
					}
				}
			}
		}
		return $new_img_path;
	}
	
	//print_r($op);
	//die($op);
