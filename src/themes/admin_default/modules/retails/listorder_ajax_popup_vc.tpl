<!-- BEGIN: main -->

<div class="p-4 text-center">
    <div class="fs_18 mb-3">Gửi hàng {VANCHUYEN} cho đơn hàng <span class="secondary_text">{VIEW.order_code}</span>
    </div>
    <div class="row mt-4 border-top border-warning">
        <div class="col-6 pt-3 border-right border-warning">
            <p class="fs_18">Thông tin người gửi</p>
            <p>{VIEW.warehouse_name}</p>
            <p>{VIEW.phone_warehouse}</p>
            <p>{VIEW.address_warehouse}</p>
        </div>
        <div class="col-6 pt-3">
            <p class="fs_18">Thông tin người nhận</p>
            <p>{VIEW.order_name}</p>
            <p>{VIEW.phone}</p>
            <p>{VIEW.address_receive}</p>
        </div>
    </div>
    <!-- BEGIN: khaigia_vnpost -->
    <div class="row">
        <div class="col-6">
            <label class="ecng_label_radio">
                <input type="radio" id="hinhthucthugom" checked="checked" name="hinhthucthugom" value="1">
                <span class="checkmark"></span>
            </label>
            Thu gom tận nơi
        </div>
        <div class="col-6">
            <label class="ecng_label_radio">
                <input type="radio" id="hinhthucthugom" name="hinhthucthugom" value="2">
                <span class="checkmark"></span>
            </label> Gửi hàng tại bưu cục
        </div>

    </div>
    <div class="row mt-3">
        <div class="col-6">
            <label class="ecng_label_checkbox">
                <input type="checkbox" name="khaigia" value="1">
                <span class="ecng_checkmark"></span>
                <span class="pl-4" style="font-size:14px">Khai giá</span>
            </label>
        </div>
        <div class="col-6">
            Phí khai giá : <span id="check_khaigia"></span>
        </div>
    </div>
    <div class="mt-4 text-center">
        <button class="btn_gray mr-3" class="close" data-dismiss="modal">Hủy</button>
        <button onclick="{send_vanchuyen}({VIEW.id},{VIEW.store_id})" class="btn_ecng">Gửi</button>
    </div>
    <!-- END: khaigia_vnpost -->

    <!-- BEGIN: khaigia_ghn -->
    <div class="row">
        <div class="col-6">
            <label class="ecng_label_radio">
                <input type="radio" id="hinhthucthugom" checked="checked" name="hinhthucthugom" value="1">
                <span class="checkmark"></span>
            </label>
            Thu gom tận nơi
        </div>
        <div class="col-6">
            <label class="ecng_label_radio">
                <input type="radio" id="hinhthucthugom" name="hinhthucthugom" value="2">
                <span class="checkmark"></span>
            </label> Gửi hàng tại bưu cục
        </div>

    </div>
    <div class="row mt-3">
        <div class="col-6">
            <label class="ecng_label_checkbox">
                <input type="checkbox" name="khaigia" value="1">
                <span class="ecng_checkmark"></span>
                <span class="pl-4" style="font-size:14px">Khai giá</span>
            </label>
        </div>
        <div class="col-6">
            <span id="check_khaigia"></span>
            <span id="check_ship"></span>
        </div>
    </div>
    <div class="mt-4 text-left">
        <p class="mb-0">
            Giá trị hàng hóa là căn cứ xác định giá trị bồi thường nếu xảy ra sự cố (giá trị bồi thường tối đa
            5,000,000đ). Toàn bộ đơn hàng của GHN bắt buộc đóng phí khai giá hàng hóa, mức phí như sau:
        </p>
        <p class="mb-0">
            +Giá trị hàng hóa <= 3,000,000đ: Miễn phí. </p>
                <p>
                    +Giá trị hàng hóa > 3,000,000đ (tối đa là 5,000,000đ): Phí khai giá hàng hóa là 0,5% giá trị hàng
                    hóa.
                </p>
    </div>
    <div class="mt-4 text-center">
        <button class="btn_gray mr-3" class="close" data-dismiss="modal">Hủy</button>
        <button onclick="{send_ghn}({VIEW.id},{VIEW.store_id})" class="btn_ecng">Gửi</button>
    </div>
    <!-- END: khaigia_ghn -->

    <!-- BEGIN: GHTK -->
    <div class="row">
        <div class="col-6 pl-5  d-flex" style="border-right:2px solid #e8b841">
            <label class="ecng_label_radio pl-4">
                <input type="radio" checked="checked" name="pick_option" value="cod">
                <span class="checkmark"></span>
                <span class="pl-1" style="font-size:14px">Thu gom tận nơi</span>
            </label>

        </div>
        <div class="col-6">
            <label class="ecng_label_radio pl-4">
                <input type="radio" name="pick_option" value="post">
                <span class="checkmark"></span>
                <span class="pl-1" style="font-size:14px">Gửi hàng tại bưu cục (Chỉ gửi hàng tại bưu cục cùng
                    tỉnh)</span>
            </label>
        </div>
    </div>
    <div class="row">
        <div class="col-6 pl-5 pt-3" style="border-right:2px solid #e8b841">
            <label class="ecng_label_checkbox d-flex pl-4">
                <input type="checkbox" name="insurance_fee" value="1">
                <span class="ecng_checkmark"></span>
                <span class="pl-1" style="font-size:14px">Đóng bảo hiểm</span>
            </label>
        </div>
        <div class="col-6 pl-5 d-flex pt-3">
            <span> Phí bảo hiểm: <span id="insurance_fee_text"></span></span>
        </div>
    </div>
    <div class="mt-4 text-left">
        <p class="mb-0">
            Hàng hóa có giá trị đóng bảo hiểm < 1.000.000VNĐ: Miễn phí bảo hiểm hàng hóa. GHTK sẽ bồi hoàn 100% giá trị
                hàng hóa khai báo trên hệ thống khi xảy ra thiệt hại rủi ro (tối đa 1.000.000đ) nếu người gửi có giấy tờ
                chứng minh nguồn gốc và giá trị hàng hóa (hoá đơn nhập hàng, hóa đơn bán hàng hợp lệ và khớp với thông
                tin sản phẩm kê khai trên hệ thống GHTK,..). </p>
                <p class="mb-0 pt-2">Hàng hóa có giá trị đóng bảo hiểm >= 1.000.000 VNĐ (tối đa là 20.000.000 VNĐ): Phí
                    bảo hiểm là 0.5% *giá trị hàng hoá (Đã bao gồm VAT). GHTK sẽ bồi hoàn 100% giá trị hàng hóa khai báo
                    trên hệ thống (tối đa 20.000.000đ) khi Bên A cung cấp đầy đủ giấy tờ chứng minh nguồn gốc và giá trị
                    hàng hóa (hoá đơn nhập hàng, hóa đơn bán hàng hợp lệ và khớp với thông tin sản phẩm kê khai trên hệ
                    thống GHTK,..).
                </p>

    </div>
    <div class="mt-4 text-center">
        <button class="btn_gray mr-3" class="close" data-dismiss="modal">Hủy</button>
        <button onclick="send_ghtk({VIEW.id},{VIEW.store_id})" class="btn_ecng">Gửi</button>
    </div>
    <!-- END: GHTK -->


</div>

<!-- END: main -->