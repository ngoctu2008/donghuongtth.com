<!-- BEGIN: main -->
<!-- BEGIN: voucher_shop -->
<section class="voucher mb-3 p-3">
	<div class="">
		Mã giảm giá của shop
	</div>
	
	<div class="row mb-3">
	<!-- BEGIN: voucher_loop -->
		<div class="col-4 pb-3">
			<div class="bg_white coupons_voucher_landingpage rounded d-flex" style="width:95%">
				<div class="coupons_left position-relative w-75 p-3 rounded">
					<div class="d-flex align-items-center">
						<img src="{VOUCHER.avt_store}" class="max_w_h rounded-circle" alt="{VOUCHER.voucher_name}"  style="width:40px">
						<span class="pl-2">{VOUCHER.voucher_name}</span>
					</div>
					<h4 class="secondary_text mt-2" style="font-size:14px;">Giảm {VOUCHER.discount_price} tất cả đơn hàng</h4>
					<span class="text_gray_color">
						<!-- BEGIN: maximum_discount -->
							<div class="">Giảm tối đa {maximum_discount}</div>
						<!-- END: maximum_discount -->
					</span>
					<span class="text_gray_color fs_12">{VOUCHER_APPLY}</span>
					<div class="d-flex pt-2 position-absolute" style="bottom:10px">
						<span>HSD: {VOUCHER.time_to}</span>
					</div>
				</div>
				<div class="coupons_right">
					<div class="d-flex flex-column justify-content-around text-center h-100">
						<div>
							Giảm 
						</div>
						<div class="fs_16 font-weight-bold">
							{VOUCHER.discount_price}
						</div>
						<div>
							<!-- BEGIN: not_saved -->
							<div id="voucher_{VOUCHER.id}">
								<button onclick="save_voucher_shop({VOUCHER.id}, {VOUCHER.store_id}, '{VOUCHER.token}')" class="{FOLLOW.color_follow} btn_ecng">Lưu</button>
							</div>
							<!-- END: not_saved -->
							
							<!-- BEGIN: saved -->
							<img class="img-fluid" src="/themes/default/chonhagiau/images/save_voucher.png">
							<!-- END: saved -->
							
							<!-- BEGIN: not_voucher -->
							<img class="img-fluid" src="/themes/default/chonhagiau/images/voucher_over.png">
							<!-- END: not_voucher -->
						</div>
					</div>
					<div class="coupons_right-border">
					</div>
				</div>
			</div>
		</div>
	<!-- END: voucher_loop -->
	</div>
</section>
<!-- END: voucher_shop -->

<!-- BEGIN: voucher_shop_hot -->
<section class="voucher mb-3 p-3">
	<div class="">
		Mã giảm giá của shop
	</div>
	
	<div class="row mb-3">
	<!-- BEGIN: voucher_loop -->
		<div class="col-4 pb-3">
			<div class="bg_white coupons_voucher_landingpage rounded d-flex" style="width:95%">
				<div class="coupons_left position-relative w-75 p-3 rounded">
					<div class="d-flex align-items-center">
						<img src="{VOUCHER.avt_store}" class="max_w_h rounded-circle" alt="{VOUCHER.voucher_name}"  style="width:40px">
						<span class="pl-2">{VOUCHER.voucher_name}</span>
					</div>
					<h4 class="secondary_text mt-2" style="font-size:14px;">Giảm {VOUCHER.discount_price} tất cả đơn hàng</h4>
					<span class="text_gray_color">
						<!-- BEGIN: maximum_discount -->
							<div class="">Giảm tối đa {maximum_discount}</div>
						<!-- END: maximum_discount -->
					</span>
					<span class="text_gray_color fs_12">{VOUCHER_APPLY}</span>
					<div class="d-flex pt-2 position-absolute" style="bottom:10px">
						<span>HSD: {VOUCHER.time_to}</span>
					</div>
				</div>
				<div class="coupons_right">
					<div class="d-flex flex-column justify-content-around text-center h-100">
						<div>
							Giảm 
						</div>
						<div class="fs_16 font-weight-bold">
							{VOUCHER.discount_price}
						</div>
						<div>
							<!-- BEGIN: not_saved -->
							<div id="voucher_{VOUCHER.id}">
								<button onclick="save_voucher_shop({VOUCHER.id}, {VOUCHER.store_id}, '{VOUCHER.token}')" class="{FOLLOW.color_follow} btn_ecng">Lưu</button>
							</div>
							<!-- END: not_saved -->
							
							<!-- BEGIN: saved -->
							<img class="img-fluid" src="/themes/default/chonhagiau/images/save_voucher.png">
							<!-- END: saved -->
							
							<!-- BEGIN: not_voucher -->
							<img class="img-fluid" src="/themes/default/chonhagiau/images/voucher_over.png">
							<!-- END: not_voucher -->
						</div>
					</div>
					<div class="coupons_right-border">
					</div>
				</div>
			</div>
		</div>
	<!-- END: voucher_loop -->
	</div>
</section>
<!-- END: voucher_shop_hot -->

<script>
	
	function save_voucher_shop(voucher_id, shop_id, token){
		$.ajax({
			url: nv_base_siteurl + 'index.php' + '?' + nv_name_variable + '=' + 'retails' + '&' + nv_fc_variable + '=ajax&mod=save_voucher_shop_landingPage',

			type: 'GET',
			data : {
				voucher_id: voucher_id,
				shop_id: shop_id,
				token: token,
				link: window.location.href,
			},
			dataType: 'json',
			beforeSend: function() {
				
			},               
			complete: function() {
				
			}, 
			success: function(res){
				if(res.status == 'OK'){
					$('#voucher_'+voucher_id).html('<img class="img-fluid" src="/themes/default/chonhagiau/images/save_voucher.png">');
				}
				else{
					window.location.href = res.link;
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				//If fail return textStatus
			}
		});
		
	}
	
</script>

<!-- END: main -->