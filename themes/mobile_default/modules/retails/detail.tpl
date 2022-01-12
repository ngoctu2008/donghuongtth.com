<!-- BEGIN: main -->
<section class="banner_top" id="productDetai_slider">
	<div class="owl-carousel owl-theme" id="productDetail_img">
		<!-- BEGIN: image_classify -->
		<div class="item bdr_8 image_classify_id_{image_classify.id}">
			<div class="productDetail_img beauty_img">
				<img src="{image_classify.upload}" class="productDetail_img"  alt="{ROW.name_product}">
			</div>
		</div>
		<!-- END: image_classify -->
		<div class="item bdr_8">
			<div class="productDetail_img beauty_img">
				<img src="{image_main_upload}" class="max_w_h"  alt="{ROW.name_product}">
				<!-- BEGIN: free_ship -->
				<img class="position-absolute" style="bottom:-1px; left:-2px" src="/themes/default/chonhagiau/images/icon_freeship1.png"  />
				<!-- END: free_ship -->
			</div>
		</div>
		<!-- BEGIN: other_image -->
		<div class="item bdr_8">
			<div class="productDetail_img beauty_img">
				<img src="{value_image.upload}" class="productDetail_img"  alt="{ROW.name_product}">
			</div>
		</div>
		<!-- END: other_image -->
		
		
	</div>	
</section>
	
	
    <section class="info_product bg_white p-3">
        <h2 class="fs_18 productName">{ROW.name_product}</h2>
        <div class="fs_18 secondary_text mb-3">
			<span class="tms_order_price_price">
				
				<!-- BEGIN: price_special --> 
				<span class="price_special_detail"> - <span>{price_special_format}đ</span></span>							 
				<!-- END: price_special -->			
				<span class="price_format_detail">{ROW.price_format}</span>đ
			</span>
		</div>
        <div class=" d-flex align-items-centers">
			<a class="productDetail_reviews_item d-flex align-items-center"><img src="{NV_BASE_SITEURL}themes/{TEMPLATE}/chonhagiau/images/icon/{ROW.star}star.svg" class="height_14 my-1" alt=""></a>
			
            <span class="text_gray_color px-3 border-right d-flex align-items-center">{ROW.total_star} đánh giá</span>
            <span class="ml-3 text_gray_color d-flex align-items-center">{ROW.number_order} đã bán</span>
		</div>
		
        <!-- BEGIN: classify -->
		<div class="productDetail_classify my-3">
			<p class="productDetail_classify_title d-block">{LOOP_CLASSIFY.name_classify}</p>
			<div class="productDetail_classify_select">
				<!-- BEGIN: classify_value -->
				<input {LOOP_CLASSIFY_VALUE.checked} type="radio" id="classify_value_{key}_{LOOP_CLASSIFY_VALUE.id}" name="classify_value_{key}" onclick="change_price();" value="{LOOP_CLASSIFY_VALUE.id}" {product_variation}>
				<label class="mr-1 {LOOP_CLASSIFY_VALUE.active}" id="label_classify_value_{key}_{LOOP_CLASSIFY_VALUE.id}" for="classify_value_{key}_{LOOP_CLASSIFY_VALUE.id}">{LOOP_CLASSIFY_VALUE.name}</label>
				<!-- END: classify_value -->
			</div>
		</div>					
		
		<!-- END: classify -->
		
		<script>
			
			var flag = false;
			change_price();
			
			function change_price()
			{
				
				var classify_id_value1 = $('input[name=classify_value_1]:checked').val();
				var classify_id_value2 = $('input[name=classify_value_2]:checked').val();
				
				// xử lý lấy thông tin sản phẩm theo thuộc tính
				
				$.ajax({               
					type: "GET",      
					dataType: 'json',  
					url: nv_base_siteurl + 'index.php' + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax',
					data:{
						mod : 'getinfoclassproduct',
						classify_id_value1 : classify_id_value1,
						classify_id_value2 : classify_id_value2,
						product_id : '{ROW.id}',						
						warehouse_id : '{warehouse_id}',
						
					},
					success: function(res) {
						
						if(res.status == 'OK')
						{	
							$('.price_format_detail').html(res.price_format);
							
							if(res.price_special > 0)
							{
								$('.price_special_detail').html(' <span>' + res.price_special_format + 'đ</span> ');
							}
							else
							{
								$('.price_special_detail').html('');
							}
							
							$('#tonkho_product').html(res.sl_tonkho_format);
							document.getElementById('quantity').setAttribute("max",res.sl_tonkho);
							$('.quantity').attr("max",res.sl_tonkho);
							
							if(res.sl_tonkho == 0)
							{
								$('.item_order_number_detail').hide();
								$('.notifici_order').html('Sản phẩm đã hết. Vui lòng chọn sản phẩm khác').show();
								
							}
							else
							{
								$('.notifici_order').html('Sản phẩm đã hết. Vui lòng chọn sản phẩm khác').hide();
								$('.item_order_number_detail').show();
								
							}
						}
						else
						{
							$('.notifici_order').html('Giá bán chưa xác định').show();
							$('.item_order_number_detail').hide();
						}
						
					},                 
					error: function(xhr, ajaxOptions, thrownError) {
						
						console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}                  
				});
				
				
				// thay đổi hình thuộc tính sản phẩm
				if(classify_id_value1 > 0 && flag)
				{
					var length_classify1 = $('.image_classify_id_' + classify_id_value1).length;
					
					if(length_classify1 > 0)
					{
						
						var element  = $(".image_classify_id_" + classify_id_value1).parent().index();
						$("#productDetail_img").trigger("to.owl.carousel", [element, 1]);
						
					}
				}
				
				flag = true;
				
			}
			
			function add_cart_order(){
				
				var classify_id_value1 = $('input[name=classify_value_1]:checked').val();
				var classify_id_value2 = $('input[name=classify_value_2]:checked').val();
				
				var quantity = $('input[name=quantity]').val();
				$.post(nv_base_siteurl + 'index.php' + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&mod=add_cart&classify_id_value1='+classify_id_value1+'&classify_id_value2='+classify_id_value2+'&warehouse_id={warehouse_id}&product_id={ROW.id}'+'&quantity='+quantity, function(res2){
					res=JSON.parse(res2);
					if(res.status=='OK'){
						window.location.href = '{LINK_CART}'
						}else if(res.status=='ERROR_SELLER'){
						alert(res.mess);
						}else{
						window.location.href = res.link
					}
				})
			}
			
			function add_cart(){
				
				var classify_id_value1 = $('input[name=classify_value_1]:checked').val();
				var classify_id_value2 = $('input[name=classify_value_2]:checked').val();
				
				var quantity = $('input[name=quantity]').val();
				$.post(nv_base_siteurl + 'index.php' + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&mod=add_cart&classify_id_value1='+classify_id_value1+'&classify_id_value2='+classify_id_value2+'&warehouse_id={warehouse_id}&product_id={ROW.id}'+'&quantity='+quantity, function(res2){
					res=JSON.parse(res2);
					if(res.status=='OK'){
						notifi_screen(res.mess);
						setTimeout(function(){ 
						location.reload(); }, 2000);
						}else if(res.status=='ERROR_SELLER'){
						alert(res.mess);
						}else{
						window.location.href = res.link
					}
				})
			}
		</script>
		
		<script>
    		function wishlist(product_id) {
    			var check = $("input[name=check_wishlist_" + product_id + "]").val();
    			var check1 = $("input[name=check_number_like_" + product_id + "]").val();
    			if(check == 0){
    				$.ajax({
    					type : 'POST',
    					url: nv_base_siteurl + 'index.php?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=main&mod=wishlist&id=' + product_id,
    					success : function(res){
    						res2=JSON.parse(res);
    						console.log(res)
    						if(res2.status=="OK"){
    							$('#like_icon_'+product_id).addClass('red_wishlist');
    							$('#like_icon_'+product_id).removeClass('white_wishlist');
    							$('#quantity_like_'+product_id).html(Number(check1)+1);
    							$("input[name=check_wishlist_" + product_id + "]").val(1);
    							$("input[name=check_number_like_" + product_id + "]").val(Number(check1)+1);
								}else{
    							window.location.href = res2.link
							}
						},
    					error: function(xhr, ajaxOptions, thrownError) {
    						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
					}); 
					}else if(check == 1){
    				$.ajax({
    					type : 'POST',
    					url: nv_base_siteurl + 'index.php?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=main&mod=un_wishlist&id=' + product_id,
    					success : function(res){
    						res2=JSON.parse(res);
    						if(res2.status=="OK"){
    							$('#like_icon_'+product_id).removeClass('red_wishlist');
    							$('#like_icon_'+product_id).addClass('white_wishlist');
    							$('#quantity_like_'+product_id).html(Number(check1)-1);
    							$("input[name=check_wishlist_" + product_id + "]").val(0);
    							$("input[name=check_number_like_" + product_id + "]").val(Number(check1)-1);
								}else{
    							alert("có lỗi xảy ra!, vui lòng kiểm tra lại!");
							}
						},
    					error: function(xhr, ajaxOptions, thrownError) {
    						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						}
					}); 
				}
			}
			
			
			
			
		</script>
		
		<div class="notifici_order py-3 text_gray_color hidden"></div>
		<div class="item_order_number_detail {check_cart_tonkho}">
			<div class="productDetail_quantity d-flex align-items-center mb-3">
				<p class="d-inline-block mb-0 mr-4 ">Số lượng</p>
				<div class="productDeatail_quantity_group">
					<div class="number-input">
						<button onclick="this.parentNode.querySelector('input[type=number]').stepDown()"></button>
						<input onkeyup="change_quantity(this);" id="quantity" class="quantity" min="1" max="{ROW.sp_tonkho}" oninput='maxLengthCheck(this)' maxLength="{ROW.sp_tonkho}" name="quantity" value="1" type="number" disabled>
						<button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button> 
					</div>
				</div>
				<p class="d-inline-block mb-0 ml-4 text_gray_color "><span id="tonkho_product">{ROW.sp_tonkho}</span> sản phẩm có sẵn</p>
			</div>
			<div class="row mb-3">
				<div class="col-6 pr-2 ">
					<button onclick="add_cart()" class="btn_ecng_outline d-block w-100 py-2">Thêm vào giỏ hàng</button>
				</div>
				<div class="col-6 pl-2"><button onclick="add_cart_order()" class="btn_ecng d-block w-100 py-2">Mua ngay</button></div>
			</div>
		</div>
		<!-- BEGIN: hethang -->  
		<p style="color: red">HẾT HÀNG<p>	
			<!-- END: hethang -->
			<div class="productDetail_share d-flex align-items-center">
				<div class="productDetail_share_media d-inline ">
					<p class="mr-3 pt-1 d-inline text_gray_color">Chia sẻ</p>
					<a href="https://www.facebook.com/sharer/sharer.php?u={URL_SHARE}" class="px-1 share">
						<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 26 26" fill="none">
							<circle cx="13" cy="13" r="13" fill="url(#paint0_linear)"/>
							<path d="M17.8413 16.9757L18.4188 13.3065H14.8063V10.9265C14.8063 9.92242 15.31 8.94312 16.928 8.94312H18.5714V5.81933C18.5714 5.81933 17.0806 5.57141 15.656 5.57141C12.6795 5.57141 10.7358 7.32914 10.7358 10.51V13.3065H7.42859V16.9757H10.7358V25.8463C11.3998 25.9479 12.0791 26 12.7711 26C13.463 26 14.1423 25.9479 14.8063 25.8463V16.9757H17.8413Z" fill="white"/>
							<defs>
								<linearGradient id="paint0_linear" x1="13" y1="0" x2="13" y2="25.9229" gradientUnits="userSpaceOnUse">
									<stop stop-color="#18ACFE"/>
									<stop offset="1" stop-color="#0163E0"/>
								</linearGradient>
							</defs>
						</svg>
					</a>
					<a href="https://www.pinterest.com/pin/create/button/?url={URL_SHARE}&media={ROW.image}&method=button" class="px-1 share">
						<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 26 26" fill="none">
							<path d="M26 13C26 20.1786 20.1785 26 13 26C5.82145 26 0 20.1786 0 13C0 5.82145 5.82145 0 13 0C20.1785 0 26 5.82145 26 13Z" fill="#E3273F"/>
							<path d="M12.5097 4.53274C9.28672 4.6779 5.91232 7.12693 5.5095 10.9489C5.25852 13.2811 6.03276 15.0989 8.14574 15.7452C8.47052 14.657 8.55853 14.0616 8.55853 14.0616C8.55853 14.0616 7.68422 13.0082 7.6319 12.3745C7.20237 7.27562 13.8473 4.28843 16.9542 8.04941C19.0961 10.6585 17.0329 18.0641 13.3488 17.0154C9.81748 16.0131 15.5822 10.4148 12.8063 9.03461C10.5518 7.91104 9.03899 11.7034 10.0017 13.7045C9.11849 16.9684 7.50471 19.989 7.7716 24.1773C9.70072 22.9347 10.5034 20.3446 11.2041 17.6339C12.0817 18.277 12.5302 18.9178 13.6948 19.0929C17.9924 19.7464 20.7496 15.1015 20.4784 10.6085C20.2293 6.62676 16.5809 4.34902 12.5097 4.53274Z" fill="white"/>
						</svg>
					</a>
					
					<a href="https://twitter.com/share?url={URL_SHARE}" class="px-1 share">
						<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 26 26" fill="none">
							<circle cx="13" cy="13" r="13" fill="#2AA3EF"/>
							<path fill-rule="evenodd" clip-rule="evenodd" d="M18.3333 9.69258C17.9411 9.86655 17.5188 9.98418 17.0764 10.0374C17.5282 9.76626 17.8752 9.33784 18.0384 8.82709C17.6154 9.07783 17.1473 9.25984 16.6484 9.35765C16.2493 8.93234 15.6807 8.66675 15.0513 8.66675C13.8427 8.66675 12.8625 9.64615 12.8625 10.8546C12.8625 11.0267 12.8826 11.1933 12.9196 11.3536C11.1011 11.2626 9.48896 10.3909 8.40962 9.0673C8.22073 9.39047 8.11342 9.76626 8.11342 10.1674C8.11342 10.9264 8.49998 11.5963 9.08671 11.9882C8.72777 11.977 8.39016 11.8786 8.09585 11.7145C8.09585 11.7238 8.09585 11.7331 8.09585 11.7424C8.09585 12.8023 8.84951 13.6863 9.85104 13.8875C9.66718 13.9377 9.47453 13.9643 9.27434 13.9643C9.13378 13.9643 8.99635 13.9507 8.86269 13.9247C9.14131 14.7939 9.94956 15.4266 10.9072 15.4446C10.1579 16.0308 9.2141 16.3806 8.18873 16.3806C8.01239 16.3806 7.83794 16.3707 7.66663 16.3503C8.6349 16.9712 9.78515 17.3334 11.0214 17.3334C15.0463 17.3334 17.2477 13.9996 17.2477 11.1084C17.2477 11.0131 17.2452 10.9196 17.2414 10.8255C17.6687 10.5172 18.0402 10.1315 18.3333 9.6932V9.69258V9.69258Z" fill="white"/>
						</svg>
					</a>
					<a href="https://www.facebook.com/v9.0/dialog/send?app_id=2644289682490542&display=popup&link={URL_SHARE}&redirect_uri={ROW.image}" class="px-1 share">
						<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 26 26" fill="none">
							<path fill-rule="evenodd" clip-rule="evenodd" d="M13 25.1791C20.1797 25.1791 26 19.5426 26 12.5896C26 5.63654 20.1797 0 13 0C5.8203 0 0 5.63654 0 12.5896C0 16.3712 1.72168 19.7634 4.44737 22.0711V24.6188C4.44737 25.6145 5.4616 26.2824 6.36588 25.8821L9.19299 24.6307C10.397 24.9873 11.6754 25.1791 13 25.1791Z" fill="url(#paint0_linear)"/>
							<path d="M9.88701 9.91332L6.11723 15.0689C5.71304 15.6217 6.43994 16.2858 6.99334 15.8693L10.2123 13.4469C10.5399 13.2003 10.9992 13.197 11.3307 13.4388L14.1935 15.5272C14.7425 15.9277 15.5272 15.8125 15.9269 15.2727L19.8805 9.93407C20.2905 9.3804 19.558 8.71094 19.0038 9.13284L15.6006 11.7236C15.2729 11.9731 14.8112 11.9777 14.4782 11.7347L11.6247 9.6531C11.0733 9.25092 10.285 9.36897 9.88701 9.91332Z" fill="white"/>
							<defs>
								<linearGradient id="paint0_linear" x1="13" y1="0" x2="8.82863" y2="25.8583" gradientUnits="userSpaceOnUse">
									<stop stop-color="#00B1FF"/>
									<stop offset="1" stop-color="#006BFF"/>
								</linearGradient>
							</defs>
						</svg>
					</a>
				</div>
				<script type="text/javascript">
					jQuery(document).ready(function($) {
						$('.share').click(function() {
							var NWin = window.open($(this).prop('href'), '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600');
							if (window.focus) {
								NWin.focus();
							}
							return false;
						});
					});
				</script>
				
				<input hidden="" type="" name="check_wishlist_{PRODUCT_ID}" value="{WISHLIST.check_wishlist}">
				<input hidden="" type="" name="check_number_like_{PRODUCT_ID}" value="{WISHLIST.like_number}">
				
				<button onclick="wishlist({PRODUCT_ID})" class="btn_none"><i id="like_icon_{PRODUCT_ID}" class="fa-2x fa fa-heart mx-3  {WISHLIST.color_wishlist}" aria-hidden="true"></i></button><span>Thích (<span id="quantity_like_{ROW.id}">{ROW.number_like}</span>)</span>
				
			</div>
		</section>
		<section class="productDetai_shop bg_white pb-2 my-3">
			<div class="row px-3 py-3 ">
				<div class="col-2">
					<div class="beauty_img width_60">
						<img class=" rounded max_w_h" src="{info_store.avatar_image}" alt="{info_store.company_name}">
					</div>
				</div>
				<div class="col-10 px-3">
					<p class="fs_18">{info_store.company_name}</p>
					<a title="{info_store.company_name}" class="btn_ecng" href="{info_store.alias}">Xem shop</a>
				</div>
				
			</div>
			<div class="row">
				<div class="col-4 text-center">
					<div class="secondary_text">
						{info_store.number_product}
					</div>
					<div class="text_gray_color">Sản phẩm</div>
				</div>
				<div class="col-4 text-center border-right border-left">
					<div class="secondary_text">
						{info_store.number_fllow}
					</div>
					<div class="text_gray_color">Người theo dõi</div>
				</div>
				<div class="col-4 text-center">
					<div class="secondary_text">
						{info_store.time_add}
					</div>
					<div class="text_gray_color">Ngày tham gia</div>
				</div>
			</div>
			
		</section>
		<section class="productDetail_desc mb-3 bg_white">
			<div class="mb-3 ">
				
				<ul class="nav nav-pills d-flex justify-content-between bg_white" role="tablist">
					<li class="nav-item fs_14 text-center font-weight-bold" style="width: 32%">
						<a href="#" class="py-3 d-block w-100 h-100 active" data-target="#description" data-toggle="pill">Mô tả sản phẩm</a>
					</li>
					<li class="nav-item fs_14 text-center font-weight-bold" style="width: 32%">
						<a href="#" class="py-3 d-block w-100 h-100" data-target="#specifications" data-toggle="pill" >Chi tiết sản phẩm</a>
					</li>
					<li class="nav-item fs_14 text-center font-weight-bold" style="width: 32%">
						<a href="#" class="py-3 d-block w-100 h-100" data-target="#rating" data-toggle="pill">Nhận xét</a>
					</li>
				</ul>
			</div>
			
			<script>
				$(window).on('load', () => {
					let iOS = !!navigator.platform && /iPad|iPhone|iPod/.test(navigator.platform);
					if (iOS)
					$('[role="tablist"] .nav-link').each((i,e) => {
						if (!$(e).attr('href'))
						$(e).attr('href', $(e).data('target'));
					})
				})
			</script>
			<div class="tab-content position-relative px-3 py-5 rounded-sm" id="productDetail_desc">
				<div id="description" class="tab-pane active">
					{ROW.bodytext}
					<div class="opacity_readmore"></div>
					<div class="w-100 pt-1 text-center position-absolute bg_white readmore_des">
						<button id="btn_readmore_des">Xem thêm</button>
					</div>
				</div>
				<!-- desc  -->
				<div id="specifications" class="tab-pane fade">
					{ROW.description}
					<div class="opacity_readmore"></div>
					<div class="w-100 text-center position-absolute bg_white readmore_spec">
						<button id="btn_readmore_spec">Xem thêm</button>
					</div>
				</div>
				<!-- spec  -->
				<div id="rating" class=" tab-pane fade">
					<div class="rating_map  py-3">
						<div class="row bg_gray">
							<div class="col-4 my-4 pt-4 text-center rating_left">
								
								<div class="fs_20">{ROW.star}/5</div>
								<img src="{NV_BASE_SITEURL}themes/{TEMPLATE}/chonhagiau/images/icon/{ROW.star}star.svg" class="img-fluid p-2" alt="">
								<p class="text_gray_color mb-0">{total_rate} nhận xét</p>
							</div>
							<div class="col-8 pl-4 py-2 rating_right my-4">
								<div class="row mb-1 align-items-center">
									<div class="col-3"><img src="{NV_BASE_SITEURL}themes/{TEMPLATE}/chonhagiau/images/icon/5star.svg" class="height_12 img-fluid" alt=""></div>
									<div class="col-7 px-2">
										<div class="progress">
											<div class="progress-bar" style="width:{star_5_pt}%"></div>
										</div>
									</div>
									<div class="col-2 fs_14">{star_5}</div>
								</div>
								<div class="row mb-1 align-items-center">
									<div class="col-3"><img src="{NV_BASE_SITEURL}themes/{TEMPLATE}/chonhagiau/images/icon/4star.svg" class="height_12 img-fluid" alt=""></div>
									<div class="col-7 px-2">
										<div class="progress">
											<div class="progress-bar" style="width:{star_4_pt}%"></div>
										</div>
									</div>
									<div class="col-2 fs_14">{star_4}</div>
								</div>
								<div class="row mb-1 align-items-center">
									<div class="col-3"><img src="{NV_BASE_SITEURL}themes/{TEMPLATE}/chonhagiau/images/icon/3star.svg" class="height_12 img-fluid" alt=""></div>
									<div class="col-7 px-2">
										<div class="progress">
											<div class="progress-bar" style="width:{star_3_pt}%"></div>
										</div>
									</div>
									<div class="col-2 fs_14">{star_3}</div>
								</div>
								<div class="row mb-1 align-items-center">
									<div class="col-3"><img src="{NV_BASE_SITEURL}themes/{TEMPLATE}/chonhagiau/images/icon/2star.svg" class="height_12 img-fluid" alt=""></div>
									<div class="col-7 px-2">
										<div class="progress">
											<div class="progress-bar" style="width:{star_2_pt}%"></div>
										</div>
									</div>
									<div class="col-2 fs_14">{star_2}</div>
								</div>
								<div class="row mb-1 align-items-center">
									<div class="col-3"><img src="{NV_BASE_SITEURL}themes/{TEMPLATE}/chonhagiau/images/icon/1star.svg" class="height_12 img-fluid" alt=""></div>
									<div class="col-7 px-2">
										<div class="progress">
											<div class="progress-bar" style="width:{star_1_pt}%"></div>
										</div>
									</div>
									<div class="col-2 fs_14">{star_1}</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="rating_cmt" id="conten_comment_rate">
						{list_comment}
					</div>
				</div>
			</div>
			
		</section>
		
		<!-- BEGIN: product_store -->   
		<section class="product_Detail_canYouLike my-2">
			<div class="bg_white secondary_text font-weight-bold px-2 py-3 fs_16">
				Có thể bạn thích
			</div>
			<div class="row mt-1">
				{product_store}
			</div>
		</section>
		<!-- BEGIN: product_store -->   
		
		<!-- END: main -->   						