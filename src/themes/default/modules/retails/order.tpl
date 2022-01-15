<!-- BEGIN: main -->
<script>
	var tongphivanchuyen = 0;
	var tongvoucher = 0;
	const isEmpty = sel =>![... document.querySelectorAll(sel)].some(el => el.innerHTML.trim() !== "");
</script>
<div class="container_payment">
	<div class="bg_white mb-3  rounded-lg ">
		<div class="row  text-center">
			
			<div class="col-12">
				<p class="fs_24 secondary_text py-3 mb-0">Thanh toán</p>
			</div>
		</div>
	</div>
	
	<!-- BEGIN: address_list -->
	<div class="payment_address bg_white rounded-lg p-4 my-3">
		<p class="secondary_text fs_18"><i class="fa fa-map-marker pr-2" aria-hidden="true"></i>Địa chỉ nhận hàng</p>
		<div class="row">
			<div class="col-10">
				<p class="fs_16 d-flex justify-content-between">
					<span class="text-break">{ADDRESS.name} </span>
					<span class="ml-2 mr-3">{ADDRESS.phone}</span>
					<span class="text_gray_color text-break">{ADDRESS.address}</span>
				</p>
			</div>
			<div class="col-2 text-center"><button class="btn_none secondary_text ml-3" id="change_address">Thay đổi</button></div>
			
		</div>
		
	</div>
	<!-- END: address_list -->
	
	<div class="payment_addressChange bg_white rounded-lg p-4 my-3 {address_other}">
		<p class="secondary_text fs_18"><i class="fa fa-map-marker pr-2" aria-hidden="true"></i>Địa chỉ nhận hàng</p>
		<!-- BEGIN: address_list1 -->
		<div class="payment_addressChange_item d-flex">
			<label class="ecng_label_radio mr-3">
				<input onchange="change_address({ADDRESS.id},{ADDRESS.userid})" type="radio" name="radio" {ADDRESS.checked}>
				<span class="checkmark"></span>
			</label>
			<div class="fs_16 d-flex"><p id="address_name_ing" >{ADDRESS.name}</p>
				<p class="ml-3">{ADDRESS.phone}</p>
				<p class="text_gray_color ml-3">{ADDRESS.address}</p>
			</div>
		</div>
		<!-- END: address_list1 -->
		<div class="payment_addressChange_save mt-3">
			<a href="{LINK_ADDRESS}" class="btn_ecng botton_add_address">+ Thêm địa chỉ mới</a>
		</div>   
	</div>
	
	<script>
		// payment 
		$('#change_address').click(function() {
			$('.payment_address').hide();
			$('.payment_addressChange').show();
			//Cách đều các thành phần địa chỉ
			var max = 0;
			var items = $('p#address_name_ing');
			var a= items.length;
			//console.log(a)
			$.each(items, function(){
				var current_vari = $(this);
				if(current_vari.width() > max){
					max = current_vari.width();
				}
			})
			//console.log(max);
			items.width(max);
			
		});
		
		$('.botton_add_address').click(function(){
			$.post(nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=order&mod=add_address_ajax', function(res) {
				
			});
		});
		
		function change_address(id, userid){
			$.ajax({
				type : 'POST',
				url: nv_base_siteurl + 'index.php?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '={OP}&mod=set_default&id=' + id + '&userid=' + userid,
				success : function(res){
					res2=JSON.parse(res);
					if(res2.status=="OK"){
						location.reload();
						
                        }else{
						alert('Có lỗi xảy ra!');
						
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
		
	</script>
	
	<div class="panel panel-default panel_add_thong_tin hidden">
		<span>
			<p>
				Tên người mua<sup>(*)</sup>
			</p>
			<input id="b_name" name="order_name1" class="form-control" value="{ADDRESS_DF.name}">
		</span>
		<span>
			<p>
				Email <sup>(*)</sup>
			</p>
			<input id="b_email" type="email" name="order_email1" onchange="check_email_error(this)" value="{USER_INFO.email}" class="form-control">
		</span>
		<span>
			<p>
				Số điện thoại<sup>(*)</sup>
			</p>
			<input id="b_phone" name="order_phone1" class="form-control" onchange="check_phone_error(this)" value="{ADDRESS_DF.phone}">
		</span>
		<div class="row">
			<div class="col-xs-24 col-sm-24 col-md-24 col-lg-24">
				<p>
					Địa chỉ nhận hàng<sup>(*)</sup>
				</p>
				<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 padding_for_select">
					<input type="" name="province_id" value="{ADDRESS_DF.province_id}">
				</div>
				<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 padding_for_select">
					<input type="" name="district_id" value="{ADDRESS_DF.district_id}">
				</div>
				<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 padding_for_select">
					<input type="" name="ward_id" value="{ADDRESS_DF.ward_id}">
				</div>
				<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 padding_for_select">
                    <input type="text" name="address" id="address" class="form-control" value="{ADDRESS_DF.address}"  placeholder="Địa chỉ ngắn gọn" />
				</div>
                <input type="text" name="lat" id="lat" class="form-control hidden" value="{ADDRESS_DF.lat}" />
                <input type="text" name="lng" id="lng" class="form-control hidden" value="{ADDRESS_DF.lng}" />
			</div>
		</div>
	</div>
	
	
	<div class="payment_header bg_white mt-3 pb-2 pt-3 px-4">
		<div class="row text-center ">
			<div class="col-md-6 fs_20">Sản phẩm</div>
			<div class="col-md-2">Đơn giá</div>
			<div class="col-md-2 ">Số lượng</div>
			<div class="col-md-2">Thành tiền</div>
		</div>
	</div>
	
	<!-- BEGIN: store -->
	<div class="payment_listProduct bg_white my-2 pb-2 pt-3 px-4">
		<div class="payment_shopName d-flex">
			<a class="" href="{ALIAS_STORE}">
				<span style="margin-left: 5px;">Cửa hàng: <span class="secondary_text">{info_store.company_name}</span>
				</span>
			</a>
		</div>
		
		<!-- BEGIN: warehouse -->
		<!-- BEGIN: loop -->
		
		<div class="payment_product mb-10 pt-4">
			<div class="row d-flex pl-lg-3 pl-md-0   align-items-center">
				<div class="col-md-1 ">
					<a class="d-flex justify-content-center align-items-center w-100 h-100" href="{LOOP_INFO_PRODUCT.alias}"><img src="{LOOP_INFO_PRODUCT.image}" alt="" style="max-width: 100%; max-height: 100%;"></a>
				</div>
				<div class="col-md-5">
					<div class="cartName px-3">
						<a href="{LOOP_INFO_PRODUCT.alias}">
							<p class="mb-0">{LOOP_INFO_PRODUCT.name_product}</p>
						</a>
						<p class="text_gray_color mb-0 capitalize">{LOOP_INFO_PRODUCT.name_group}</p>
					</div>
				</div>
				<div class="col-md-2 text-center">{LOOP_INFO_PRODUCT.price_format}đ</div>
				<div class="col-md-2 text-center">
					{LOOP_INFO_PRODUCT.quantity}
				</div>
				<div class="col-md-2 secondary_text text-center">{LOOP_INFO_PRODUCT.total}đ</div>
			</div>
		</div>
        
		<!-- END: loop -->
		<input type="hidden" id="total_price_one_shop_{info_store.userid}"  value="{total_price_one_shop}">
		<!-- voucher -->
		<div class="row align-items-center" id="voucher">
			<div class="col-4 col-md-6">
				<div class="row pl-3 py-3 rounded" style="background: rgb(242, 242, 242)">
					<div class="col-8">
						<input type="text" class="form-control cart_coupon" id="voucher_code_{info_store.userid}" name="voucher_code_{info_store.userid}" placeholder="Nhập mã voucher">
					</div>
					<div class="col-4">
						<button type="submit" id="apply_{info_store.userid}" onclick="add_voucher({info_store.userid})" class="btn_ecng">Áp dụng</button>
						<button type="submit" id="delete_{info_store.userid}" onclick="delete_voucher({info_store.userid})" class="btn_ecng d-none" style="width: 87%">Hủy</button>
					</div>
					<div class="notifi_error voucher_id_{info_store.userid} d-none fs_12 pl-2 mt-1"></div>
				</div>
				
			</div>
			<div class="col-4 ml-4 d-none" id='voucher_id_{info_store.userid}' >
				<svg style="filter: drop-shadow(rgba(0, 0, 0, 0.15) 0px 1px 3px);height: 60px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 457 132" class="coupon-bg position-relative"><g fill="none" fill-rule="evenodd"><g><g><g><g><g><g transform="translate(-3160 -2828) translate(3118 80) translate(42 2487) translate(0 140) translate(0 85) translate(0 36)"><path fill="#FFF" d="M449 0c4.418 0 8 3.582 8 8v116c0 4.418-3.582 8-8 8H140.5c0-4.419-3.582-8-8-8s-8 3.581-8 8H8c-4.418 0-8-3.582-8-8V8c0-4.418 3.582-8 8-8h116.5c0 4.418 3.582 8 8 8s8-3.582 8-8H392z"></path><g stroke="#EEE" stroke-dasharray="2 4" stroke-linecap="square" mask="url(#14s2l20tnb)"><path d="M0.5 0L0.5 114" transform="translate(132 11)"></path></g></g></g></g></g></g></g></g></svg>
				<div class="position-absolute d-flex h-100 align-items-center" style="top:0">
					
					<div class="col-3">
						<img src="/themes/default/chonhagiau/images/chonhagiau_voucher.png" class="img-fluid"/>
					</div>
					<div class="col-9 pl-4">
						<p class="secondary_text m-0">Giảm giá sản phẩm</p>
						<div class="pt-2 fw_500">-<span id='voucher_price_{info_store.userid}'></span>đ</div>
					</div>
				</div>
				
			</div>
		</div>
		<!-- voucher -->
		
		<div class="payment_option mt-3">
			<div class="row border-top">
				<div class="col-md-4 border-right pt-3 px-3">
					<p class="secondary_text mb-0">Ghi chú</p>
					<form action="" id="add_address">
						<div class="input-group mb-4 border rounded-lg p-1 input_ecng">
							<input id="note_product_{info_store.id}_{key_warehouse}" type="text" placeholder="Ghi chú cho cửa hàng" name="" aria-describedby="button-addon4" class="form-control bg-none border-0 ">
						</div>
					</form>
				</div>
				<div class="col-md-8">
					<div class="row d-flex px-3 pt-4 align-items-center">
						<!-- BEGIN: transporters -->
						<div class="col-md-3 d-flex align-items-center justify-content-center">
							<span class="secondary_text">Đơn vị vận chuyển</span>
						</div>
						<div class="col-md-5" id="text_phivanchuyen_{info_store.id}_{key_warehouse}">
							<p class="mb-0" id="method_transfer_{info_store.id}_{key_warehouse}"><i class="fa fa-spinner fa-spin" aria-hidden="true"></i></p>
							<p class="mb-0 text_gray_color" id="method_time_{info_store.id}_{key_warehouse}"></p>
						</div>
						
						<div class="col-md-2">
							<button class="btn_none secondary_text" data-toggle="modal" data-target="#transporter_{info_store.id}_{key_warehouse}" id="button_change_method_tranfer_{info_store.id}_{key_warehouse}" >Thay đổi</button>
						</div>
						<div class="col-md-2 secondary_text">
							<span id="shipping_price_{info_store.id}_{key_warehouse}"></span>
						<input class="hidden transporter_store_active" id="transporter_first_{info_store.id}_{key_warehouse}" value="{transporter_first}"/>đ</div>
						<script>			
							$( document ).ready(function() {
								shop_tu_giao({info_store.id}, {key_warehouse});
								
								function shop_tu_giao(store_id, warehouse_id){
									if(transporter_{info_store.id} == ''){
										$('#shipping_price_'+store_id+'_'+warehouse_id).html('0');
										$("#button_change_method_tranfer_"+store_id+"_"+warehouse_id).html('');
										$("#method_transfer_"+store_id+"_"+warehouse_id).html(' <p class="mb-0 text-center text_gray_color" >Cửa hàng giao sản phẩm</p>');
										tongphivanchuyen = tongphivanchuyen + 0;
										sum_phivanchuyen();
									}
								}
								
								load_tranposter_next({info_store.id},{key_warehouse},{total_weight},{total_width},{total_length},{total_height},{total_warehouse},transporter_{info_store.id});
								
								
							});
						</script>
						
						<!-- END: transporters -->
						<!-- BEGIN: notransporters_loop -->
						<p>Đơn hàng này của bạn đã vượt mức cho phép về khối lượng và kích thước không thể vận chuyển</p>
						<!-- END: notransporters_loop -->
						<!-- modal vận chuyển  -->
						
						<div class="modal fade" id="transporter_{info_store.id}_{key_warehouse}">
							<div class="modal-dialog m modal-dialog-centered">
								<div class="modal-content p-4">
									<div class="modal-header pt-0">
										<h5 class="modal-title" id="">Chọn đơn vận chuyển</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<form action="" id="">
										<div id="tranposter_next_{info_store.id}_{key_warehouse}"></div>
										<div class="payment_ship_save text-right hidden">
											<button class="btn_ecng">Lưu</button>
										</div>
									</form>
									
								</div>
							</div>
						</div>
						<!-- thêm vận chuyển  -->
						
						
					</div>
				</div>
				
			</div>
		</div>
		<script>
			var transporter_{info_store.id} = [];
			<!-- BEGIN: transporters_loop_js -->
			
			transporter_{info_store.id}.push({"id":{CARRIER.id},"name_transporters":"{CARRIER.name_transporters}","description":"{CARRIER.description}"});
			<!-- END: transporters_loop_js -->
			
			
		</script>
		
		<!-- END: warehouse -->
		
	</div>
	<!-- END: store -->
	
	<div class="payment_methods bg_white my-2 p-4">
		<div class="fs_18"><span class="secondary_text">Phương thưc thanh toán</span>
			<input type="hidden" checked name="payment_method" value="2">
			<button class="btn_ecng_outline ml-4"><i class="fa fa-id-card-o" aria-hidden="true"></i> VNPAY</button>
		</div>
	</div>
	<div class="payment_total bg_white my-2">
		<div class="row border-bottom">
			<div class="col-6">
				
			</div>
			<div class="col-6 px-4 py-2">
				<table class="table table-borderless mb-0">
					<tbody>
						<tr>
							<td class="text_gray_color">
								Tạm tính
								<input hidden="" type="number" name="total_merchandise" id="total_merchandise" value="{total}">
							</td>
							<td class="float-right">{total_format}đ</td>
							
						</tr>
						<tr>
							<td class="text_gray_color">Phí vận chuyển</td>
							<td class="float-right"><span id="tongphivanchuyen"><i class="fa fa-spinner fa-spin" aria-hidden="true"></i></span>đ</td>
							
						</tr>
						<tr class="row_voucher">
							<td class="text_gray_color">Voucher</td>
							<td class="float-right">- <span id="tongvoucher"><i class="fa fa-spinner fa-spin" aria-hidden="true"></i></span>đ</td>
							
						</tr>
						<tr>
							<td class="mb-0">Tổng thanh toán</td>
							<td class="float-right fs_20 secondary_text mb-0"><span id="tongtienchinhxac">{total_format}</span>đ</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row p-4 align-items-center">
			<div class="col-md-8">
				Khi nhấn hoàn tất đồng nghĩa bạn đã kiểm tra kỹ đơn hàng và đồng ý với <a class="secondary_text" title="Các điều khoản của ECNG" href="https://chonhagiau.com/ecng/quy-dinh-va-hinh-thuc-thanh-toan.html" target="_blank" >các điều khoản của ECNG</a>
			</div>
			<div class="col-md-4 text-right">
				<button id="button-payment-method" class="btn_ecng_lg" onclick="order_product_check_out()"  >Hoàn tất đơn hàng</button>
			</div>
		</div>
	</div>
	
</div>
<script>
	
	function add_voucher(shop_id){
		var voucher_code = $('input[name=voucher_code_' + shop_id + ']').val();
		var voucher_pice_one_shop = $('#total_price_one_shop_' + shop_id).val();
		//alert(voucher_pice_one_shop);
		$.ajax({
			type : 'POST',
			url : nv_base_siteurl + 'index.php?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax',
			dataType: "json",
			data:{
				mod: 'add_voucher',
				voucher_code: voucher_code,
				shop_id: shop_id,
				method: 1,
				voucher_pice_one_shop: voucher_pice_one_shop,
			},
			beforeSend: function() { 
				$('#apply_'+shop_id).prop('disabled', true);
			},	
			complete: function() {
				$('#apply_'+shop_id).prop('disabled', false);
			},
			success : function(res){
				if (res.status == "ERROR")
				{
					notifi_error(res.mess);
					$('.voucher_id_'+shop_id).addClass('d-block');
					//window.location.href = '{list_voucher}';
					}else {
					$('#voucher_price_'+shop_id).append(format_number(res.voucher_price));
					$('#voucher_name_'+shop_id).append(res.voucher_name);
					$('#minimum_price_'+shop_id).append(format_number(res.minimum_price));
					$('#voucher_id_'+shop_id).addClass('d-block');
					
					$('#apply_'+shop_id).addClass('d-none').removeClass('d-block');
					$('#delete_'+shop_id).addClass('d-block').removeClass('d-none');
					$('.voucher_id_'+shop_id).addClass('d-none').removeClass('d-block');
					
					tongvoucher = tongvoucher + Number(res.voucher_price);
					sum_phivanchuyen();
					hien();
				}
			}
			
		});	
		
	}
	
	function delete_voucher(shop_id){
		var voucher_code = $('input[name=voucher_code_' + shop_id + ']').val();
		var voucher_pice_one_shop = $('#total_price_one_shop_' + shop_id).val();
		$.ajax({
			type : 'POST',
			url : nv_base_siteurl + 'index.php?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax',
			dataType: "json",
			data:{
				mod: 'add_voucher',
				voucher_code: voucher_code,
				shop_id: shop_id,
				method: 0,
				voucher_pice_one_shop: voucher_pice_one_shop,
			},
			beforeSend: function() { 
				$('#delete_'+shop_id).prop('disabled', true);
			},	
			complete: function() {
				$('#delete_'+shop_id).prop('disabled', false);
			},
			success : function(res){
				if (res.status == "ERROR")
				{
					notifi_error(res.mess);
					//window.location.href = '{list_voucher}';
					}else if (res.status == "OK"){
					
					$('#voucher_price_'+shop_id).html('');
					$('#voucher_name_'+shop_id).html('');
					$('#minimum_price_'+shop_id).html('');
					$('#voucher_id_'+shop_id).addClass('d-none').removeClass('d-block');
					
					$('#apply_'+shop_id).addClass('d-block');
					$('#delete_'+shop_id).addClass('d-none').removeClass('d-block');
					$('.notifi_error').hide();
					tongvoucher = tongvoucher - Number(res.voucher_price);
					
					//alert( tongvoucher);
					sum_phivanchuyen();
					hien();
				}
			}
			
		});	
	}
</script>
<script>
	
	
	function nv_carrier_change(store_id,warehouse_id,a)
	{ 
		
		$('#method_transfer_'+store_id+'_'+warehouse_id).html(a.title);
		$('#method_time_'+store_id+'_'+warehouse_id).html(a.title2);
		var transporter_first=document.getElementById('transporter_first_'+store_id+'_'+warehouse_id)
		transporter_first.setAttribute("value",a.value);
		var price = document.getElementById('phivanchuyen_'+store_id+'_'+warehouse_id+'_'+a.value).textContent;
		
		var price_old = (document.getElementById("shipping_price_"+store_id+"_"+warehouse_id).textContent).split(" ")[0]
		document.getElementById("shipping_price_"+store_id+"_"+warehouse_id).textContent = price;
		price_old = Number(price_old.replaceAll(",", ""));
		if(Number.isNaN(price_old)){
			price_old=0;
		}
		
		price_new = Number(price.split(" ")[0].replaceAll(",", ""));
		if(Number.isNaN(price_new)){
			price_new=0;
		}
		
		tongphivanchuyen = Number(tongphivanchuyen) - Number(price_old) + Number(price_new);
		sum_phivanchuyen(); 
		
		$('#transporter_'+ store_id +'_'+ warehouse_id).modal('toggle');
		
		
	}
	function load_data_tranposter_next(store_id,warehouse_id,transporter_id,name_transporters,description,phivanchuyen){
		var transporter_first = document.getElementById('transporter_first_'+store_id+'_'+warehouse_id).value;
		var checked = '';
		var onclick = 'onclick="nv_carrier_change('+store_id+','+warehouse_id+',this)"';
		
		if(transporter_id==transporter_first){
			checked = 'checked=checked';
		}
		
		$("#tranposter_next_"+store_id+"_"+warehouse_id).append('<div class="row mb-10"><div class="col-md-1"><label class="ecng_label_radio"><input name="carrier['+store_id+']['+warehouse_id+']" value='+transporter_id+' title="'+name_transporters+'" title2="'+description +'"' + onclick +' '+ checked +' type="radio" name="radio"><span class="checkmark"></span></label></div><div class="col-md-8"><p class="fs_16 mb-0">'+name_transporters+'</p><span class="text_gray_color content_'+store_id+'_'+warehouse_id+'">'+description+'</span></div><div class="col-md-3 text-right secondary_text"><span id="phivanchuyen_'+store_id+'_'+warehouse_id+'_'+transporter_id+'">'+phivanchuyen+' </span>đ</div></div>');
		
		sum_phivanchuyen();
	}
	
	function load_tranposter_next(store_id,warehouse_id,total_weight,total_width,total_length,total_height,total_warehouse,transporter_store){
		
		var province_id = $('input[name=province_id]').val();
		var district_id = $('input[name=district_id]').val();
		var ward_id = $('input[name=ward_id]').val();
		var lat = document.getElementById('lat').value;
		var lng = document.getElementById('lng').value;
		var address = document.getElementById('address').value;
		if(isEmpty("#tranposter_next_"+store_id+"_"+warehouse_id)==true){
			
			transporter_store.forEach((element,index)=>{
				
				if(element.id == 5 || element.id  == 4){
					
					$.ajax({
						type : 'POST',
						url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax' + '&mod=get_transport_fee_vnpost',
						dataType: "json",
						data:{weight: Number(total_weight),
							length : Number(total_length),
							width : Number(total_width),
							height : Number(total_height),
							province_id : province_id,
							district_id : district_id,
							shops_id : warehouse_id, 
							total : Number(total_warehouse),
							transporters_id : element.id,
							lat : lat, 
							lng : lng
						},
						beforeSend: function() { 
							//
						},	
						complete: function() {
							
						},
						success : function(res){
							//
							//console.log(res);
							if(Number(res)==-1){
								load_data_tranposter_next(store_id,warehouse_id,element.id,element.name_transporters,element.description,'Miến phí vận chuyển');
								}else{
								load_data_tranposter_next(store_id,warehouse_id,element.id,element.name_transporters,element.description,format_number(Number(res)));
								
							}
						}
						
					})
					}else if(element.id  == 3){
					
					$.ajax({
						type : 'POST',
						url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax' + '&mod=get_transport_fee_ghn',
						dataType: "json",
						data:{weight: Number(total_weight),
							length : Number(total_length),
							width : Number(total_width),
							height : Number(total_height),
							province_id : province_id,
							ward_id : ward_id,
							district_id : district_id,
							shops_id : warehouse_id, 
							total : Number(total_warehouse),
							transporters_id : element.id,
							lat : lat, 
							lng : lng
						},
						beforeSend: function() { 
							
						},	
						complete: function() {
							
						},
						success : function(res){
							//console.log(res);
							if(Number(res.fee)==-1){
								}else{
								if(Number(res.fee)==0){
									load_data_tranposter_next(store_id,warehouse_id,element.id,element.name_transporters,element.description,'0')
									}else{
									load_data_tranposter_next(store_id,warehouse_id,element.id,element.name_transporters,element.description,format_number(Number(res.fee)));
									$('.content_'+store_id+'_'+warehouse_id  +'').html(res.mess);
								}
							}
						}
						
					})
					
				}
			})
			
		}
	}
	function get_transport_fee(vitri,warehouse_id,store_id,total_weight,total_width,total_length,total_height,total_warehouse,transporter_store){
		
		var province_id = $('input[name=province_id]').val();
		var district_id = $('input[name=district_id]').val();
		var ward_id = $('input[name=ward_id]').val();
		var lat = document.getElementById('lat').value;
		
		var lng = document.getElementById('lng').value;
		var address = document.getElementById('address').value;
		var transporter_first=document.getElementById('transporter_first_'+store_id+'_'+warehouse_id);
		transporter_store.forEach((element,index)=>{
			
			if(index==vitri){
				if(element.id == 5 || element.id  == 4){ 
					
					$.ajax({
						type : 'POST',
						url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax' + '&mod=get_transport_fee_vnpost',
						dataType: "json",
						data:{weight: Number(total_weight),
							length : Number(total_length),
							width : Number(total_width),
							height : Number(total_height),
							province_id : province_id,
							district_id : district_id,
							shops_id : warehouse_id, 
							total : Number(total_warehouse),
							transporters_id : element.id,
							lat : lat, 
							lng : lng
						},
						beforeSend: function() { 
							
						},	
						complete: function() {
							
						},
						success : function(res){
							//console.log(res);
							if(Number(res)==-1){
								if(vitri+1==transporter.length){
									$('#shipping_price_'+store_id+'_'+warehouse_id).html('Đơn hàng của bạn hiện không có nhà vận chuyển nào đáp ứng được. Vui lòng tách đơn');
									$('#text_phivanchuyen_'+store_id+'_'+warehouse_id).addClass('hidden');
									$('#button_change_method_tranfer').addClass('hidden');
									}else{
									get_transport_fee(index+1,warehouse_id,store_id,total_weight,total_width,total_length,total_height,total_warehouse,transporter_store);
								}
								}else{
								$('#shipping_price_'+store_id+'_'+warehouse_id).html('Đang cập nhật cước phí tạm tính, vui lòng đợi chút');
								$('#method_transfer_'+store_id+'_'+warehouse_id).html(element.name_transporters);
								$('#method_time_'+store_id+'_'+warehouse_id).html(element.description);
								transporter_first.setAttribute("value",element.id);
								
								if(Number(res)==0){
									$('#shipping_price_'+store_id+'_'+warehouse_id).html('0');
									tongphivanchuyen = tongphivanchuyen + 0;
									sum_phivanchuyen();
									}else{
									$('#shipping_price_'+store_id+'_'+warehouse_id).html(format_number(Number(res)));
									tongphivanchuyen = tongphivanchuyen + Number(res);
									sum_phivanchuyen();
								}
							}
						}
						
					})
					}else if(element.id  == 3 ){
					
					$.ajax({
						type : 'POST',
						url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax' + '&mod=get_transport_fee_ghn',
						dataType: "json",
						data:{weight: Number(total_weight),
							length : Number(total_length),
							width : Number(total_width),
							height : Number(total_height),
							province_id : province_id,
							ward_id : ward_id,
							district_id : district_id,
							shops_id : warehouse_id, 
							total : Number(total_warehouse),
							transporters_id : element.id,
							lat : lat, 
							lng : lng
						},
						beforeSend: function() { 
							$('#button-payment-method').prop('disabled', true);
						},	
						complete: function() {
							$('#button-payment-method').prop('disabled', false);
						},
						success : function(res){
							//console.log(res);
							if(Number(res.fee)==-1){
								if(vitri+1==transporter.length){
									$('#shipping_price_'+store_id+'_'+warehouse_id).html('Đơn hàng của bạn hiện không có nhà vận chuyển nào đáp ứng được. Vui lòng tách đơn')
									$('#text_phivanchuyen_'+store_id+'_'+warehouse_id).addClass('hidden');
									$('#button_change_method_tranfer').addClass('hidden');
									}else{
									get_transport_fee(index+1,warehouse_id,store_id,total_weight,total_width,total_length,total_height,total_warehouse);
								}
								}else{
								transporter_first.setAttribute("value",element.id)
								$('#shipping_price_'+store_id+'_'+warehouse_id).html('Đang cập nhật cước phí tạm tính, vui lòng đợi chút')
								$('#method_transfer_'+store_id+'_'+warehouse_id).html(element.name_transporters)
								$('#method_time_'+store_id+'_'+warehouse_id).html(res.mess)
								if(Number(res.fee)==0){
									$('#shipping_price_'+store_id+'_'+warehouse_id).html('0')
									}else{
									$('#shipping_price_'+store_id+'_'+warehouse_id).html(format_number(Number(res.fee)));
									tongphivanchuyen = tongphivanchuyen + Number(res.fee);
									//$('#method_time_'+store_id+'_'+warehouse_id ).html(res.mess);
									sum_phivanchuyen();
								}
							}
						}
						
					})
					
				}
			}
		})
		
	}
</script>
<script> 
	
	get_free_warehouse();
	async function get_free_warehouse(){
		tongphivanchuyen = await 0;
		<!-- BEGIN: storejs -->
		<!-- BEGIN: warehousejs -->
		get_transport_fee(0,{key_warehouse},{info_store.id},{total_weight},{total_width},{total_length},{total_height},{total_warehouse},transporter_{info_store.id})
		<!-- END: warehousejs -->
		<!-- END: storejs -->
		
	} 
	function sum_phivanchuyen(){
		var total_merchandise = document.getElementById('total_merchandise').value;
		
		$('#tongphivanchuyen').html(format_number(tongphivanchuyen));
		$('#tongvoucher').html(format_number(tongvoucher));
		
		$('#tongtienchinhxac').html(format_number(Number(total_merchandise) + Number(tongphivanchuyen) - Number(tongvoucher)));
		
	}
	
	function number_transport()
	{
		var arr_transport = [];
		$('.transporter_store_active').each(function(){
			if(arr_transport.indexOf($(this).val()) == -1)
			{
				arr_transport.push($(this).val());
			}
		})
		
		$('.number_transport').html(arr_transport.length);
	}
	
	
	
	function order_product_check_out(){
		var list_transporters = [];
		var order_name=$('input[name=order_name1]').val();
		var order_email=$('input[name=order_email1]').val();
		var order_phone=$('input[name=order_phone1]').val();
		var lat=$('input[name=lat]').val();
		var lng=$('input[name=lng]').val();
		var address=$('input[name=address]').val();
		var province_name = $('input[name=province_id]').val();
		var district_name = $('input[name=district_id]').val();
		var ward_name = $('input[name=ward_id]').val();
		var payment_method = document.getElementsByName('payment_method');
		var total_merchandise = document.getElementById('total_merchandise').value;
		var total_full = Number(total_merchandise) + Number(tongphivanchuyen);
		for (var i = 0, length = payment_method.length; i < length; i++) {
			if (payment_method[i].checked) {
				payment_method = payment_method[i].value;
				break;
			}
		};
		
		if(order_name==''){
			alert('Vui lòng nhập họ và tên')
			}else if(order_email==''){
			alert('Vui lòng nhập email')
			}else if(!IsEmail(order_email)){
			alert('Email không hợp lệ')
			}else if(!Phonenumber(order_phone)){
			alert('Số điện thoại không hợp lệ')
			}else if(order_phone==''){
			alert('Vui lòng nhập số điện thoại')
			}else if(province_name == ''){
			alert('Vui lòng chọn thành phố')
			}else if(district_name == ''){
			alert('Vui lòng chọn quận')
			}else if(ward_name == ''){
			alert('Vui lòng chọn phường')
			}else if(address == ''){
			alert('Vui lòng nhập địa chỉ ngắn gọn')
			}else{
			var error = 0;
			<!-- BEGIN: storejsorder -->
			<!-- BEGIN: warehousejs -->
			var transporters_id=document.getElementById('transporter_first_{key_store}_{key_warehouse}').value;
			var note_product=document.getElementById('note_product_{key_store}_{key_warehouse}').value;
			//var voucher_code=documentdocument.getElementById('voucher_code_{info_warehouse.sell_userid}').value;
			if(transporters_id == ''){
				transporters_id = 0;
			}
			
			var fee = (document.getElementById("shipping_price_{key_store}_{key_warehouse}").textContent).split(" ")[0];
			fee = Number(fee.replaceAll(",", ""));
			
			
			if(Number.isNaN(fee)){
				fee = 0;
			}
			
			list_transporters.push({'store_id':{key_store}, 'store_userid':{store_userid},'warehouse_id':{key_warehouse},'transporters_id':Number(transporters_id),'fee':fee,'note_product':note_product,'total_product':{total_warehouse},'total_weight':{total_weight},'total_width':{total_width},'total_length':{total_length},'total_height':{total_height}});
			
			<!-- END: warehousejs -->
			<!-- END: storejsorder -->
			
			if(error==1){
				alert('Vui lòng đợi tính phí vận chuyển')
				}else if(error==2){
				alert('Có 1 đơn hàng của 1 shop đã vượt mức cho phép về khối lượng và kích thước. Vui lòng tách đơn rồi đặt lại')
				}else if(error==4){
				alert('Vui lòng nhập lại mật khẩu để thanh toán')
				}else if(error==5){
				}else{
				$("#button-payment-method").attr("disabled", true);
				$("#button-payment-method").html("Đang xử lý");
				$("#button-payment-method").addClass("no_action");
				
				//console.log(nv_base_siteurl + 'index.php' + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&mod=add_order&order_name=' + order_name+'&order_email='+order_email+'&order_phone='+order_phone+'&address='+address+'&province_id='+province_name+'&district_id='+district_name+'&ward_id='+ward_name+'&list_transporters='+JSON.stringify(list_transporters)+'&lat='+lat+'&lng='+lng);
				
				$.ajax({
					type : 'POST',
					url : nv_base_siteurl + 'index.php' + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&mod=add_order',
					dataType: "json",
					data:{
						order_name: order_name,
						order_email : order_email,
						order_phone : order_phone,
						address : address,
						province_id : province_name,
						ward_id : ward_name,
						district_id : district_name,
						list_transporters : list_transporters, 
						lat : lat, 
						lng : lng
					},
					beforeSend: function() { 
						
					},	
					complete: function() {
						
					},
					success : function(res){
						console.log(res);
						if (res.status != 'OK') {
							if(res.status=='error'){
								$("#button-payment-method").attr("disabled", false);
								$("#button-payment-method").html("Đặt hàng");
								$("#button-payment-method").removeClass("no_action");
								alert(res.mess);
								}else if(res.status=='OK_VNPAY'){
								location.href = res.link
								}else if(res.status=='error_password_money'){
								$("#button-payment-method").attr("disabled", false);
								$("#button-payment-method").html("Đặt hàng");
								$("#button-payment-method").removeClass("no_action");
								alert(res.mess)
								}else{
								$('.error_thongbao').html("");
								res.error.forEach(element=>{
									$('.error_thongbao').append(element);
								})
							}
							} else {
							alert(res.mess);
							location.href=res.link;
						}
					}
					
				})
			}
		}
	}
	function check_email_error(a){
		var email=$(a).val();
		if(!IsEmail(email)){
			alert('Email không hợp lệ')
		}
	}
	function check_phone_error(a){
		var phone=$(a).val();
		if(!Phonenumber(phone)){
			alert('Số điện thoại không hợp lệ')
		}
	};
	
	function hien(){
		if(tongvoucher > 0){
			$(".row_voucher").show();
			}else{
			$(".row_voucher").hide();
		};
	};
	
	if(tongvoucher > 0){
		$(".row_voucher").show();
		}else{
		$(".row_voucher").hide();
	};
	
</script>



<!-- END: main -->
