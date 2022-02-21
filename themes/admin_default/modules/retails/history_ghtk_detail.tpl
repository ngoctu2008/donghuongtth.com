<!-- BEGIN: main -->
<h1 class="text-center secondary_text">{FOR_CONTROL}</h1>
<div class="row">
    <div class="col-md-10">
        <h2>Thông tin người nhận</h2>
        <table class="table">
            <tbody>
                <tr>
                    <td>Tên </td>
                    <td>{VIEW.order_name}</td>
                </tr>
                <tr>
                    <td>Số điện thoại</td>
                    <td>{VIEW.phone}</td>
                </tr>
                <tr>
                    <td>Địa chỉ</td>
                    <td>{VIEW.address_user}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="col-md-4">
    </div>
    <div class="col-md-10">
        <h2>Thông tin người gửi</h2>
        <table class="table">
            <tbody>
                <tr>
                    <td>Tên Shop</td>
                    <td>{VIEW.shop_name}</td>

                </tr>
                <tr>
                    <td>Số điện thoại</td>
                    <td>{VIEW.phone_send}</td>
                </tr>
                <tr>
                    <td>Địa chỉ</td>
                    <td>{VIEW.shop_address}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="row">
        <h2 class="text-center">Thông tin vận chuyển</h2>
        <div class="col-md-11">
            <table class="table">
                <tbody>
                    <tr>
                        <td>Mã đơn hàng</td>
                        <td> <a href="{VIEW.link_view_order}">{VIEW.order_code} </a></td>
                    </tr>
                    <tr>
                        <td>Mã vận chuyển</td>
                        <td>{VIEW.shipping_code}</td>
                    </tr>
                    <tr class="alert-success">
                        <td>Trạng thái vận chuyển</td>
                        <td> <strong>{VIEW.status_ghtk}</strong></td>
                    </tr>
                    <tr>
                        <td>Phí bảo hiểm</td>
                        <td>{VIEW.insurance_fee}</td>
                    </tr>
                    <tr>
                        <td>Tiền COD</td>
                        <td>{VIEW.pick_money}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="col-md-2">
        </div>
        <div class="col-md-11">
            <table class="table">
                <tbody>
                    <tr>
                        <th>Phí vận chuyển khách trả</th>
                        <th>Phí vận chuyển Seller trả</th>
                        <th>Phí vận chuyển GHTK cập nhật</th>
                    </tr>
                    <tr class="{no_equal}">
                        <td>{VIEW.fee_transport}</td>
                        <td>{VIEW.fee}</td>
                        <td>{VIEW.fee_update}</td>
                    </tr>
                    <tr>
                        <th>Khối lượng ban đầu</th>
                        <th>Khối lượng GHTK cập nhật</th>
                    </tr>
                    <tr class="{no_equal_weight}">
                        <td>{VIEW.total_weight}</td>
                        <td>{VIEW.weight}</td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>
</div>



<!-- END: main -->