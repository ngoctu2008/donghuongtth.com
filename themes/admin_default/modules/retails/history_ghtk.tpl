<!-- BEGIN: main -->
<!-- BEGIN: view -->
<div class="well">
    <form action="{NV_BASE_ADMINURL}index.php" method="get">
        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
        <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
        <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}" />
        <div class="row">
            <div class="col-xs-24 col-md-6">
                <div class="form-group">
                    <input class="form-control" type="text" value="{Q}" name="q" maxlength="255"
                        placeholder="{LANG.search_title}" />
                </div>
            </div>
            <div class="col-xs-24 col-sm-12  col-md-12  col-lg-6">
					<div class="form-group">
						<div class="input-group" style="width:100%">
							<span class="input-group-addon w100">
								Cửa hàng 
							</span>
							<select name="store_id" class="form-control input-sm store_id">
								<option value="0">Chọn tất cả</option>
								<!-- BEGIN: store_id -->
								<option value="{store_id_list.key}" {store_id_list.selected}>{store_id_list.title}
								</option>
								<!-- END: store_id -->
							</select>
						</div>
					</div>
				</div>
            <div class="col-xs-12 col-md-3">
                <div class="form-group">
                    <input class="btn btn-primary" type="submit" value="{LANG.search_submit}" />
                </div>
            </div>
        </div>
    </form>
</div>
<form
    action="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}={OP}"
    method="post">
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Mã vận đơn</th>
                    <th>Mã đơn hàng</th>
                    <th>Tên Shop</th>
                    <th>Tên người nhận</th>
                    <th>Phí vận chuyển</th>
                    <th>Trạng thái</th>
                    <th>Thời gian tạo</th>
                    <th>Thời gian cập nhật</th>
                    <th class="w100 text-center">Đối soát</th>
                    <th class="w150">&nbsp;</th>
                </tr>
            </thead>
            <!-- BEGIN: generate_page -->
            <tfoot>
                <tr>
                    <td class="text-center" colspan="10">{NV_GENERATE_PAGE}</td>
                </tr>
            </tfoot>
            <!-- END: generate_page -->
            <tbody>
                <!-- BEGIN: loop -->
                <tr class="{no_equal}">
                    <td> {VIEW.label} </td>
                    <td> <a href="{VIEW.link_view_order}">{VIEW.order_code} </a></td>
                    <td> {VIEW.shop_name} </td>
                    <td> {VIEW.order_name} </td>
                    <td> {VIEW.fee} (thực tính - {VIEW.fee_update})</td>
                    <td> {VIEW.status_ghtk} </td>
                    <td> {VIEW.time_add} </td>
                    <td> {VIEW.time_edit} </td>
                    <td class="text-center"><input type="checkbox" name="for_control" id="change_status_{VIEW.id}"
                            value="{VIEW.id}" {CHECK} onclick="nv_change_status({VIEW.id});" /></td>
                    <td class="text-center"> <a
                            href="{VIEW.link_view}">Chi tiết</a>
                        
                    </td>
                </tr>
                <!-- END: loop -->
            </tbody>
        </table>
    </div>
</form>

<script>
$('.store_id').select2()
</script>
<!-- END: view -->

<!-- END: main -->