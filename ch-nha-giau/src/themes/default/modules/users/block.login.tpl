<!-- BEGIN: main -->
<script>
	$("#login_form").validate({
		onfocusout: true,
		onkeyup: true,
		onclick: true,
		rules: {
			email: {
				required: true,
				
			},
			password: {
				required: true,
				
			}
		},
		messages: {
			email: {
				required: "Vui lòng nhập tên đăng nhập",
				
			},
			password: {
				required: "Vui lòng nhập mật khẩu",
				
			}
		},
		submitHandler: function() {
			login_validForm_user()
		}
	});
	$("#register_form").validate({
		onfocusout: true,
		onkeyup: true,
		onclick: true,
		rules: {
			name: {
				required: true,
				minlength: 4,
			},
			email: {
				required: true,
				email: true,
			},
			phone: {
				required: true,
				sdt: true,
			},
			password: {
				required: true,
				minlength: 6,
				
			},
			re_password: {
				equalTo: "#register_password"
			}
			
		},
		messages: {
			name: {
				required: "Vui lòng nhập tên",
				minlength: "Vui lòng nhập ít nhất 4 ký tự ",
			},
			email: {
				required: "Vui lòng nhập email",
				email: "Email chưa đúng định dạng",
			},
			phone: {
				required: "Chưa nhập số điện thoại",
				// sdt: true,
			},
			password: {
				required: "Vui lòng nhập mật khẩu",
				minlength: "Mật khẩu phải trên 6 ký tự",
			},
			re_password: {
				equalTo: "Nhập lại mật khẩu không chính xác"
			}
		},
		submitHandler: function() {
			submit_form_register(this)
		}
		
		
	});
	$.validator.addMethod("sdt", function(value, element) {
		return this.optional(element) || /(0+([1-9]+[0-9]{8})\b)/i.test(value);
	}, "Số điện thoại không đúng định dạng");
	
	
	function thongbao_xuly(message) {
		
		$('.contact-result').html(message).removeClass("alert-danger").addClass("alert-info").show();
		setTimeout(function() {
			$('.contact-result').hide();
		}, 300000);
	}
	
	function thongbao(message) {
		
		$('.contact-result').html(message).removeClass("alert-danger").addClass("alert-info").show();
		setTimeout(function() {
			$('.contact-result').hide();
		}, 5000);
	}
	
	
	function login_validForm_user() {
		console.log($('#login_form').serialize());
		$.ajax({
			type: 'POST',
			url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=users&' + nv_fc_variable + '=login',
			data: $('#login_form').serialize(),
			dataType: "json",
			success: function(res) {
				console.log(res);
				if (res.status == "error") {
					$('#login_form').find("[name=\"" + res.input + "\"]").focus();
					
					notifi_error(res.mess);
					
					
				}
				if (res.status == "ok") {
					thongbao('Đăng nhập thành công!');
					if(res.back_link != '')
					{
						window.location.href = res.back_link;
					}
					else
					{
						location.reload();
					}
				}
				
			}
			
		});
		
	}
	
	function submit_form_register() {
		$.ajax({
			type: 'POST',
			url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=users&' + nv_fc_variable + '=register',
			data: $('#register_form').serialize(),
			dataType: "json",
			beforeSend: function() {
				thongbao_xuly('Hệ thống đang xử lý... Vui lòng đợi trong giây lát!');
				$('#register_form .btn_ecng').prop('disabled', true);
			},
			complete: function() {
				
				$('#register_form .btn_ecng').prop('disabled', false);
				
			},
			success: function(res) {
				console.log(res);
				if (res.status == "error") {
					$('#register_form').find("[name=\"" + res.input + "\"]").focus();
					
					thongbao(res.mess);
					
					
				}
				if (res.status == "ok") {
					$('#register_success').show();
					location.reload();
				}
				
			}
			
		});
	}
</script>



<li class="nav-item header_user">
	<a href="#login" class="nav-link secondary_text modal_login login_botton123">Đăng nhập</a>
	
</li>
<li class="nav-item">
	<a href="#register" class="nav-link secondary_text modal_register">Đăng ký</a>
	
	<div class="modal fade" id="modal_login">
		<div class="modal-dialog modal-xl ">                
			<div class="modal-content">
				<button type="button" class="close close_login" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
				<div class="row">
					<div class="col-6 text-center">
						<img src="{NV_SITE_BASEURL}/themes/{TEMPLATE}/chonhagiau/images/dangnhap.png" class="login_img img-fluid" alt="Đăng nhập">
					</div>
					<div class="col-6 login p-3">
						<ul class="nav nav-pills mb-3 justify-content-around " role="tablist">
							<li class="nav-item login_title fs_24">
								<a class="active" data-toggle="pill" role="tab" href="#login">Đăng nhập</a>
							</li>
							<li class="nav-item register_title fs_24">
								<a class="" data-toggle="pill" role="tab" href="#register">Đăng ký</a>
							</li>
						</ul>
						<div class="contact-result mb-3"></div>
						
						<div class="tab-content mt-5">
							<!-- login  -->
							<div class="tab-pane fade in show active mt-5" id="login" role="tabpanel">
								<form id="login_form">
									<div class="input-group  border rounded-lg p-1 mb-30 input_ecng">
										<div class="input-group-prepend border-0 width_32">
											<button  type="button" class="btn btn-link secondary_text " disabled><i class="fa fa-user-circle-o" aria-hidden="true"></i></button>
										</div>
										<div class="input_error">
											<input type="text" class="form-control bg-none border-0  " name="email" placeholder="Email hoặc số điện thoại" required>
										</div>
									</div>
									<div class="input-group mb-30 border rounded-lg p-1 mb-30 input_ecng">
										<div class="input-group-prepend border-0">
											<button type="button" class="btn btn-link secondary_text " disabled><i class="fa fa-lock" aria-hidden="true"></i></button>
										</div>
										<div class="input_error">
											<input type="password" placeholder="Nhập mật khẩu" name="password"  class="form-control bg-none border-0  ">
										</div>
									</div>
									<div class="notifi_error"></div>
									<a href="{LOSTPASS}" class="secondary_text ml-2 mb-30 inline-block forgotpass" >Quên mật khẩu ?</a>
									
									<div class="text-center">
										<button type="submit" class="btn btn_ecng">Đăng nhập</button>
									</div>
								</form>
							</div>
							<!-- register  -->
							<div class="tab-pane fade" id="register" role="tabpanel">
								<form action="" id="register_form">
									
									<input type="hidden" name="checkss" value="{CHECKSS}">
									<div class="input-group mb-4 border rounded-lg p-1 input_ecng">
										<div class="input-group-prepend border-0 width_32">
											<button  type="button" class="btn btn-link secondary_text " disabled><i class="fa fa-user-circle-o" aria-hidden="true"></i></button>
										</div>
										<div class="input_error">
											<input type="text" placeholder="Họ Và Tên" name="name"  class="form-control bg-none border-0 ">
										</div>
									</div>
									<div class="input-group mb-4 border rounded-lg p-1 input_ecng">
										<div class="input-group-prepend border-0 width_32">
											<button  type="button" class="btn btn-link secondary_text " disabled><i class="fa fa-envelope-o" aria-hidden="true"></i></button>
										</div>
										<div class="input_error">
											<input type="email" placeholder="Email" name="email"  class="form-control bg-none border-0 ">
										</div>
									</div>
									<div class="input-group mb-4 border rounded-lg p-1 input_ecng">
										<div class="input-group-prepend border-0">
											<button  type="button" class="btn btn-link secondary_text " disabled><i class="fa fa-phone" aria-hidden="true"></i></button>
										</div>
										<div class="input_error">
											<input type="text" placeholder="Số Điện Thoại" maxlength="10" name="phone" id="sdt"  class="form-control bg-none border-0 ">
										</div>
									</div>
									<div class="input-group mb-4 border rounded-lg p-1 input_ecng">
										<div class="input-group-prepend border-0">
											<button  type="button" class="btn btn-link secondary_text " disabled><i class="fa fa-lock" aria-hidden="true"></i></button>
										</div>
										<div class="input_error">
											<input type="password" placeholder="Nhập mật khẩu" id="register_password" name="password"  class="form-control bg-none border-0 ">
										</div>
									</div>
									<div class="input-group mb-3 border rounded-lg p-1 input_ecng">
										<div class="input-group-prepend border-0">
											<button  type="button" class="btn btn-link secondary_text " disabled><i class="fa fa-lock" aria-hidden="true"></i></button>
										</div>
										<div class="input_error">
											<input type="password" placeholder="Nhập lại mật khẩu" name="re_password"  class="form-control bg-none border-0 ">
										</div>
									</div>
									<div class="text-center mb-2">
										<button class="btn btn_ecng">Đăng ký</button>
										<div class="modal" id="register_success" style="background-color: rgba(0,0,0,.4)">
											<div class="modal-content py-4" >
												<img src="/themes/default/chonhagiau/images/tick.png" alt="" class="img-fluid">
												<p class="fs_20 pt-3 m-0">Đăng ký thành công</p>
											</div>										
										</div>
									</div>
									<p>"Khi đã đồng ý với các <a href="https://chonhagiau.com/ecng/chinh-sach-bao-mat.html" class="secondary_text" target="_blank">điều khoản và chính sách bảo mật</a> của ECNG thì bạn hãy tạo tài khoản"?</p>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- dangnhap  -->
</li>
<!-- END: main -->
<!-- BEGIN: signed -->
<li class="nav-item header_user">
	<div class="nv-info" style="display:none"></div>
	<div class="d-flex align-items-center" >
		<img src="{AVATA}" class="rounded-circle img_avatar" style="width:24px" alt="{USER.last_name}">
		<a href="#" class="secondary_text modal_login nav-link pl-1"><span>{USER.last_name}</span></a>
	</div>
	<div class="bg_white header_user_option ">
		<a href="{URL_MODULE}" class="py-2 pl-2">Tài khoản của tôi</a>
		<a href="{HISTORY}" class=" py-2 pl-2">Lịch sử mua hàng</a>
		<button onclick="{URL_LOGOUT}(this);" class="btn_none py-2 pl-2">Đăng xuất</button>
	</div>
</li>
<script type="text/javascript" src="{NV_BASE_SITEURL}themes/{BLOCK_JS}/js/users.js"></script>

<!-- END: signed -->