<!-- BEGIN: main -->
<div id="users">
	<form action="{FORM_ACTION}" method="post">
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-hover">
				<colgroup>
					<col style="width: 300px" />
					<col/>
				</colgroup>
			
				<tbody>
					<tr>
						<td colspan="2">{LANG.slider_config}</td>
					</tr>
					<tr>
						<td>{LANG.slider_title_extra}</td>
						<td><input type="checkbox" value="1" name="slider_title_extra"{slider_title_extra}/></td>
					</tr>
					<tr>
						<td>{LANG.slider_image_mobile}</td>
						<td><input type="checkbox" value="1" name="slider_image_mobile"{slider_image_mobile}/></td>
					</tr>
					
				</tbody>
			</table>	

			
				<table class="table table-striped table-bordered table-hover">
				<colgroup>
					<col style="width: 300px" />
					<col/>
				</colgroup>
			
				<tbody>
					<tr>
						<td colspan="2">{LANG.config}</td>
					</tr>
					<tr>
						<td>{LANG.company_hometext}</td>
						<td><input class="form-control" name="company_hometext" value="{DATA.company_hometext}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_name}</td>
						<td><input class="form-control" name="company_name" value="{DATA.company_name}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_sortname}</td>
						<td><input class="form-control" name="company_sortname" value="{DATA.company_sortname}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_regcode}</td>
						<td><input class="form-control" name="company_regcode" value="{DATA.company_regcode}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_regplace}</td>
						<td><input class="form-control" name="company_regplace" value="{DATA.company_regplace}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_responsibility}</td>
						<td><input class="form-control" name="company_responsibility" value="{DATA.company_responsibility}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_address}</td>
						<td><input class="form-control" name="company_address" value="{DATA.company_address}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_warehouse}</td>
						<td><input class="form-control" name="company_warehouse" value="{DATA.company_warehouse}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_map}</td>
						<td><input class="form-control" name="company_map" value="{DATA.company_map}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_phone}</td>
						<td><input class="form-control" name="company_phone" value="{DATA.company_phone}" />
						<button class="btn btn-default btn-xs" onclick="modalShow('Quy ?????nh khai b??o s??? ??i???n tho???i','<ul><li>S??? ??i???n tho???i ???????c chia ra hai ph???n, ph???n ?????u l?? b???t bu???c v?? d??nh cho vi???c hi???n th??? tr??n site, ph???n hai kh??ng b???t bu???c v?? d??nh cho vi???c quay s??? khi click chu???t v??o n??.</li><li>Ph???n ?????u ???????c vi???t t??? do nh??ng kh??ng c?? d???u ngo???c vu??ng. Ph???n hai ????? trong d???u ngo???c vu??ng ngay sau ph???n ?????u v?? ch??? ???????c ch???a c??c k?? t??? sau: ch??? s???, d???u sao, d???u th??ng, d???u ph???y, d???u ch???m, d???u ch???m ph???y v?? d???u c???ng ([0-9\*\#\.\,\;\+]).</li><li>V?? d???, n???u b???n khai b??o <strong>0438211725 (ext 601)</strong>, th?? s??? <strong>0438211725 (ext 601)</strong> s??? ???????c hi???n th??? ????n thu???n tr??n site. C??n n???u b???n khai b??o <strong>0438211725 (ext 601)[+84438211725,601]</strong>, h??? th???ng s??? cho hi???n th??? <strong>0438211725 (ext 601)</strong> tr??n site v?? url khi click chu???t v??o s??? ??i???n tho???i tr??n s??? l?? <strong>tel:+84438211725,601</strong></li><li>B???n c?? th??? khai b??o nhi???u s??? ??i???n tho???i theo quy t???c tr??n. Ch??ng ???????c ph??n c??ch b???i d???u |.</li></ul>');return!1;">Quy ?????nh khai b??o s??? ??i???n tho???i</button>
						</td>
					</tr>
					<tr>
						<td>{LANG.company_hotline}</td>
						<td><input class="form-control" name="company_hotline" value="{DATA.company_hotline}" />
						<button class="btn btn-default btn-xs" onclick="modalShow('Quy ?????nh khai b??o s??? ??i???n tho???i','<ul><li>S??? ??i???n tho???i ???????c chia ra hai ph???n, ph???n ?????u l?? b???t bu???c v?? d??nh cho vi???c hi???n th??? tr??n site, ph???n hai kh??ng b???t bu???c v?? d??nh cho vi???c quay s??? khi click chu???t v??o n??.</li><li>Ph???n ?????u ???????c vi???t t??? do nh??ng kh??ng c?? d???u ngo???c vu??ng. Ph???n hai ????? trong d???u ngo???c vu??ng ngay sau ph???n ?????u v?? ch??? ???????c ch???a c??c k?? t??? sau: ch??? s???, d???u sao, d???u th??ng, d???u ph???y, d???u ch???m, d???u ch???m ph???y v?? d???u c???ng ([0-9\*\#\.\,\;\+]).</li><li>V?? d???, n???u b???n khai b??o <strong>0438211725 (ext 601)</strong>, th?? s??? <strong>0438211725 (ext 601)</strong> s??? ???????c hi???n th??? ????n thu???n tr??n site. C??n n???u b???n khai b??o <strong>0438211725 (ext 601)[+84438211725,601]</strong>, h??? th???ng s??? cho hi???n th??? <strong>0438211725 (ext 601)</strong> tr??n site v?? url khi click chu???t v??o s??? ??i???n tho???i tr??n s??? l?? <strong>tel:+84438211725,601</strong></li><li>B???n c?? th??? khai b??o nhi???u s??? ??i???n tho???i theo quy t???c tr??n. Ch??ng ???????c ph??n c??ch b???i d???u |.</li></ul>');return!1;">Quy ?????nh khai b??o s??? ??i???n tho???i</button>
						</td>
					</tr>
					<tr>
						<td>{LANG.company_fax}</td>
						<td><input class="form-control" name="company_fax" value="{DATA.company_fax}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_email}</td>
						<td><input class="form-control" name="company_email" value="{DATA.company_email}" /></td>
					</tr>
					<tr>
						<td>{LANG.company_website}</td>
						<td><input class="form-control" name="company_website" value="{DATA.company_website}" /></td>
					</tr>
					
					<tr>
						<td>{LANG.coppyright}</td>
						<td><input class="form-control" name="coppyright" value="{DATA.coppyright}" /></td>
					</tr>
					<tr>
						<td>{LANG.bocongthuong}</td>
						<td><input class="form-control" name="bocongthuong" value="{DATA.bocongthuong}" /></td>
					</tr>	
					<tr>
						<td>{LANG.logobocongthuong}</td>
						<td><input class="form-control w350 pull-left" name="logobocongthuong" id="logobocongthuong" value="{DATA.logobocongthuong}" />
							<button class="btn btn-default selectfilelogobocongthuong" type="button" >
							<em class="fa fa-folder-open-o fa-fix">&nbsp;</em>
							</button>
				         </td>
					</tr>
					<tr>
						<td>{LANG.logofooter}</td>
						<td><input class="form-control w350 pull-left" name="logofooter" id="logofooter" value="{DATA.logofooter}" />
							<button class="btn btn-default selectfile" type="button" >
							<em class="fa fa-folder-open-o fa-fix">&nbsp;</em>
							</button>
				         </td>
					</tr>
					
					<tr style="background: #717170;color: #fff;text-align: center;font-weight: 600;">
						<td colspan="2">{LANG.social}</td>
					</tr>
			
					<tr>
						<td>{LANG.facebook}</td>
						<td><input class="form-control" name="facebook" value="{DATA.facebook}" /></td>
					</tr>	
					<tr>
						<td>{LANG.twitter}</td>
						<td><input class="form-control" name="twitter" value="{DATA.twitter}" /></td>
					</tr>	
					<tr>
						<td>{LANG.instagram}</td>
						<td><input class="form-control" name="instagram" value="{DATA.instagram}" /></td>
					</tr>	
					<tr>
						<td>{LANG.youtube}</td>
						<td><input class="form-control" name="youtube" value="{DATA.youtube}" /></td>
					</tr>	
			
			
			
					
					
					
				</tbody>
			</table>
			
				<tfoot>
					<tr>
						<td colspan="2"><input type="submit" name="submit" value="{LANG.save}" class="btn btn-primary" /></td>
					</tr>
				</tfoot>
		</div>
	</form>
</div>
<script>
    $(".selectfilelogobocongthuong").click(function() {
        var area = "logobocongthuong";
        var path = "{NV_UPLOADS_DIR}/{MODULE_UPLOAD}";
        var currentpath = "{NV_UPLOADS_DIR}/{MODULE_UPLOAD}";
        var type = "image";
        nv_open_browse(script_name + "?" + nv_name_variable + "=upload&popup=1&area=" + area + "&path=" + path + "&type=" + type + "&currentpath=" + currentpath, "NVImg", 850, 420, "resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
        return false;
    });
    $(".selectfile").click(function() {
        var area = "logofooter";
        var path = "{NV_UPLOADS_DIR}/{MODULE_UPLOAD}";
        var currentpath = "{NV_UPLOADS_DIR}/{MODULE_UPLOAD}";
        var type = "image";
        nv_open_browse(script_name + "?" + nv_name_variable + "=upload&popup=1&area=" + area + "&path=" + path + "&type=" + type + "&currentpath=" + currentpath, "NVImg", 850, 420, "resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
        return false;
    });
   
    $(".selectvideo").click(function() {
        var area = "video";
        var path = "{NV_UPLOADS_DIR}/{MODULE_UPLOAD}";
        var currentpath = "{NV_UPLOADS_DIR}/{MODULE_UPLOAD}";
        var type = "";
        nv_open_browse(script_name + "?" + nv_name_variable + "=upload&popup=1&area=" + area + "&path=" + path + "&type=" + type + "&currentpath=" + currentpath, "NVImg", 850, 420, "resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
        return false;
    });
</script>

<!-- END: main -->