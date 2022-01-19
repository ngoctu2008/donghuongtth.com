<!-- BEGIN: main -->
<!-- BEGIN: view -->
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title" style="float:left"><i class="fa fa-list"></i> {LANG.product}</h3> 
		<div class="pull-right">
			<button title="Ẩn /Hiện tìm kiếm"id="tms_sea_id" data-toggle="tooltip" data-placement="top"class="btn btn-success btn-sm"><i class="fa fa-search" aria-hidden="true"></i></button> 
			<a href="{product_add}" data-toggle="tooltip" data-placement="top" title="{LANG.product_add}" class="btn btn-success btn-sm"><i class="fa fa-plus-circle" aria-hidden="true"></i></a>
		</div>
		<div style="clear:both"></div>
	</div>
	<div class="well" id="tms_sea">
		<form action="{NV_BASE_ADMINURL}index.php" id="formsearch" method="get">
			<input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
			<input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
			<input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}" />
			<div class="row">
				<div class="col-xs-24 col-sm-12  col-md-12  col-lg-8">
					<div class="form-group">
						<div class="input-group" style="width:100%">
							<span class="input-group-addon w100">
								Tìm kiếm nhanh
							</span>
							<select class="form-control link_flast" id="sea_flast" name="sea_flast">
								<option value="0">
									-- Chọn thời gian --
								</option>
								<option value="1" {SELECT1}>Ngày hôm nay</option>
								<option value="2" {SELECT2}>Ngày hôm qua</option>
								<option value="3" {SELECT3}>Tuần này</option>
								<option value="4" {SELECT4}>Tuần trước</option>
								<option value="5" {SELECT5}>Tháng này</option>
								<option value="6" {SELECT6}>Tháng trước</option>
								<option value="7" {SELECT7}>Năm này</option>
								<option value="8" {SELECT8}>Năm trước</option>
								<option value="9" {SELECT9}>Toàn thời gian
								</option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="col-xs-24 col-sm-12  col-md-12  col-lg-8">
					<div class="form-group">
						<div class="input-group" style="width:100%">
							<span class="input-group-addon w100">
								hoặc {LANG.ngay_tu}
							</span>
							<input id="ngaytu" type="text" maxlength="255" class="form-control disabled" value="{ngay_tu}"
                            name="ngay_tu" placeholder="{LANG.ngay_tu}">
						</div>
					</div>
					
				</div>
				
				<div class="col-xs-24 col-sm-12  col-md-12  col-lg-8">
					<div class="form-group">
						<div class="input-group" style="width:100%">
							<span class="input-group-addon w100">
								{LANG.ngay_den}
							</span>
							<input id="ngayden" type="text" maxlength="255" class="form-control disabled" value="{ngay_den}"
                            name="ngay_den" placeholder="{LANG.ngay_den}">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-24 col-sm-12  col-md-12  col-lg-6">
					<div class="form-group">
						<div class="input-group" style="width:100%">
							<span class="input-group-addon w100">
								Cửa hàng
							</span>
							<select name="store_id" class="form-control input-sm store_id">
								<option value="0">Chọn tất cả</option>
								<!-- BEGIN: store_id -->
								<option value="{store_id.key}" {store_id.selected}>{store_id.title}
								</option>
								<!-- END: store_id -->
							</select>
						</div>
					</div>
				</div>
				 
				<div class="col-xs-24 col-sm-12  col-md-12  col-lg-6">
					<div class="form-group">
						<div class="input-group" style="width:100%">
							<span class="input-group-addon w100">
								Block sản phẩm
							</span>
							<select name="block_id" class="form-control input-sm">
								<option value="0">Chọn tất cả</option>
								<!-- BEGIN: block_id -->
								<option value="{block_id.key}" {block_id.selected}>{block_id.title}
								</option>
								<!-- END: block_id -->
							</select>
						</div>
					</div>
				</div>
				
				<div class="col-xs-24 col-sm-12  col-md-12  col-lg-8">
					<div class="form-group">
						<input class="form-control" type="text" value="{Q}" name="q" maxlength="255"
                        placeholder="Tên sản phẩm" />
					</div>
				</div>
				<div class="col-sm-24  col-md-24  col-lg-4">
					<div class="form-group">
						<input class="btn btn-primary" type="submit" value="{LANG.search_submit}" />
						<button class="btn btn-primary export_file" type="button"  >
							Xuất file excel
						</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<form action="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}={OP}" method="post">
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th class="text-center">Stt</th>
					<th class="text-center">{LANG.image}</th>
					<th class="text-center">{LANG.name_product}</th>
					<th class="text-center">Giá bán</th>
					<th class="text-center">{LANG.barcode}</th>
					<th class="text-center">Cửa hàng</th>
                    <th class="text-center">{LANG.categories_id}</th>
					<th class="w100 text-center">SL tồn kho</th>
					<th class="w100 text-center">SP nổi bật</th>
                    <th class="w100 text-center">{LANG.active}</th>
                    <th class="w150">&nbsp;</th>
					
				</tr>
			</thead>
            <!-- BEGIN: generate_page -->
            <tfoot>
                <tr>
                    <td class="text-center" colspan="12">{NV_GENERATE_PAGE}</td>
				</tr>
			</tfoot>
            <!-- END: generate_page -->
            <tbody>
                <!-- BEGIN: loop -->
				
                <tr class="text-center">
                    <td>
                        <select class="form-control" id="id_weight_{VIEW.id}" onchange="nv_change_weight('{VIEW.id}');">
							<!-- BEGIN: weight_loop -->
							<option value="{WEIGHT.key}"{WEIGHT.selected}>{WEIGHT.title}</option>
							<!-- END: weight_loop -->
						</select>
					</td>
					<td>
						<img src="{VIEW.image}" style="height:50px;max-width:300px" /> 
					</td>
					<td><a href="{VIEW.alias}"> {VIEW.name_product} </a></td>
					<td> {VIEW.price} </td>
					<td> {VIEW.barcode} </td>
					<td> {VIEW.store_id} </td>                   
                    <td> {VIEW.category} </td>
					<td>
						{warehouse}
					</td>
					<td class="text-center"><input disabled="true" type="checkbox" {CHECK_NB}/></td>
					
                    <td class="text-center"><input type="checkbox" name="status" id="change_status_{VIEW.id}" value="{VIEW.id}" {CHECK} onclick="nv_change_status({VIEW.id});" /></td>
                    <td class="text-center">
						<a href="{VIEW.link_edit}#edit" data-toggle="tooltip" data-placement="top" title="{LANG.edit}" class="btn btn-default btn-xs">
							<i class="fa fa-edit fa-lg">&nbsp;</i> 
						</a>
						<a href="{VIEW.link_delete}" data-toggle="tooltip" data-placement="top" title="{LANG.delete}" class="btn btn-danger btn-xs" onclick="return confirm(nv_is_del_confirm[0]);">
							<i class="fa fa-trash-o fa-lg">&nbsp;</i>
						</a>
					</td>
				</tr>
                <!-- END: loop -->
			</tbody>
		</table>
	</div>
</form>
<!-- END: view -->


<script type="text/javascript">
	//<![CDATA[
	$('.store_id').select2({})
    function nv_change_weight(id) {
        var nv_timer = nv_settimeout_disable('id_weight_' + id, 5000);
        var new_vid = $('#id_weight_' + id).val();
        $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=product&nocache=' + new Date().getTime(), 'ajax_action=1&id=' + id + '&new_vid=' + new_vid, function(res) {
            var r_split = res.split('_');
            if (r_split[0] != 'OK') {
                alert(nv_is_change_act_confirm[2]);
			}
            window.location.href = script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=product';
            return;
		});
        return;
	}
	
	
    function nv_change_status(id) {
        var new_status = $('#change_status_' + id).is(':checked') ? true : false;
        if (confirm(nv_is_change_act_confirm[0])) {
            var nv_timer = nv_settimeout_disable('change_status_' + id, 5000);
            $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=product&nocache=' + new Date().getTime(), 'change_status=1&id='+id, function(res) {
                var r_split = res.split('_');
                if (r_split[0] != 'OK') {
                    alert(nv_is_change_act_confirm[2]);
				}
			});
		}
        else{
            $('#change_status_' + id).prop('checked', new_status ? false : true);
		}
        return;
	}
	
	
	$('select[name=sea_flast]').change(function() {
		var time_from = "";
		var time_to = "";
		var time = $('select[name=sea_flast]').val();
		if (time == 1) {
			time_from = "{HOMNAY}"
			time_to = "{HOMNAY}"
			} else if (time == 2) {
			time_from = "{HOMQUA}"
			time_to = "{HOMQUA}"
			} else if (time == 3) {
			time_from = "{TUANNAY.from}"
			time_to = "{TUANNAY.to}"
			} else if (time == 4) {
			time_from = "{TUANTRUOC.from}"
			time_to = "{TUANTRUOC.to}"
			} else if (time == 5) {
			time_from = "{THANGNAY.from}"
			time_to = "{THANGNAY.to}"
			} else if (time == 6) {
			time_from = "{THANGTRUOC.from}"
			time_to = "{THANGTRUOC.to}"
			} else if (time == 7) {
			time_from = "{NAMNAY.from}"
			time_to = "{NAMNAY.to}"
			} else if (time == 8) {
			time_from = "{NAMTRUOC.from}"
			time_to = "{NAMTRUOC.to}"
			} else if (time == 9) {
			time_from = "Không chọn"
			time_to = "Không chọn"
			} else if (time == 0) {
			time_from = ""
			time_to = ""
		}
		$('#ngaytu').val(time_from);
		$('#ngayden').val(time_to); 
		<!-- console.log($('#ngaytu').val()); -->
		<!-- console.log($('#ngayden').val(time_to)); -->
		<!-- console.log(time = $('select[name=sea_flast]').val()); -->
		<!-- console.log({HOMNAY}); -->
	})
	$("#tms_sea_id").click(function() {
		$("#tms_sea").toggle();
	});
	$("#ngaytu,#ngayden").datepicker({
		dateFormat: "dd-mm-yy",
		changeMonth: true,
		changeYear: true,
		firstDay: 1,
		showOtherMonths: true,
	});
	
	function update_number(product_id,store_id){
		var amount = $('#amount_'+product_id+'_'+store_id).val();
		var amount_delivery = $('#amount_delivery_'+product_id+'_'+store_id).val();
		var check = confirm("Bạn có chắc là sẽ cập nhật số lượng cho sản phẩm này không?");
		if(check == true){
			if(amount == ''){
				alert('Vui lòng điền số lượng tồn kho');
				}else if(amount_delivery==''){
				alert('Vui lòng điền số lượng đang giao');
				}else{
				$.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&mod=update_number_product&amount='+amount+'&amount_delivery='+amount_delivery+'&product_id='+product_id+'&store_id='+store_id, function(res) {
					var res2=JSON.parse(res);
					if(res2.status == 'OK'){
						alert(res2.mess);
						location.reload();
					}
				});
			}
		}
	}
	/*$('.export_file').on('click', function(e) {
		var all = $(this).attr('data-all');	
		var form_data = $('#formsearch').serializeArray(); 
		form_data.push({ name: 'all', value: all });
		
		$.ajax({
		url: script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '={OP}&mod=is_download&nocache=' + new Date().getTime(),
		type: 'GET',
		dataType: 'JSON',
		data: form_data,
		beforeSend: function() {
		$('.export_file i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
		$('.export_file').prop('disabled', true);
		loading();
		},	
		complete: function() {
		$('.export_file i').replaceWith('<i class="fa fa-download"></i>');
		$('.export_file').prop('disabled', false);
		},
		success: function(json) {
		removeloading();
		if( json['error'] ) alert( json['error'] );  		
		if( json['link'] ) window.location.href= json['link'];  		
		},
		error: function(xhr, ajaxOptions, thrownError) {
		alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
		});
		e.preventDefault(); 	
	});*/
	$(".export_file").on('click', function(e) {
		e.preventDefault();  
		
		$.ajax({               
			type: "GET",
			url: script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '={OP}&mod=is_download',
			data: $('#formsearch').serialize(),
			beforeSend: function() {
				
			},	               
			complete: function() {
				
			},                 
			success: function(res) {
				
				window.location.href = res;     
				
			},                 
			error: function(xhr, ajaxOptions, thrownError) {
				
				console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}                  
		});                    
	}); 
	//]]>
</script>

<!-- END: main -->