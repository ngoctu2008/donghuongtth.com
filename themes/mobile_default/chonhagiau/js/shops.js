$(document).ready(function(){
	$('#category').owlCarousel({
    loop: true,
    autoplay: true,
    nav: false,
    dots: false,
    responsive: {
        0: {
            items: 10
        }
    }
});
//danh muc
$('#banner-home').owlCarousel({
    loop: true,
    autoplay: true,
    nav: true,
    dots: true,
    responsive: {
        0: {
            items: 1
        }
    },
    navText: ['<i class="fa fa-chevron-left home_banner_left" aria-hidden="true"></i>', '<i class="fa fa-chevron-right home_banner_right" aria-hidden="true"></i>']
});
// slider productHot 
var swiper = new Swiper('.swiper-container', {
    slidesPerView: 2,
    slidesPerColumn: 2,
    spaceBetween: 0,
    autoplay: {
        delay: 5000,
    },

});
// procuctCategory

$('#category_slider').owlCarousel({
    loop: true,
    dots: true,
    autoplay: true,
    responsive: {
        0: {
            items: 1
        },
    }
});
$('#categoryChill').owlCarousel({
    margin: 20,
    loop: false,
    nav: true,
    dots: false,
    autoWidth: true,
    items: 7
})
$('#brand').owlCarousel({
    loop: false,
    margin: 10,
    nav: true,
    dots: false,
    autoplayHoverPause: true,
	slideBy:2,
    responsive: {
        0: {
            items: 7
        },

    }
});

// procuctCategory

// categogyChill 
$('#categoryChill .item').click(function() {
    $('#categoryChill').find('.secondary_text').removeClass('secondary_text');
    $(this).addClass('secondary_text');
});
// brand
$('#brand .item a').click(function() {
    $('#brand').find('.brand_active').removeClass('brand_active')
    $(this).addClass('brand_active');
});
// filter 
$('.categoryFilter .btn_ecng_outline').click(function() {
    $('.categoryFilter').find('.btn_ecng').removeClass('btn_ecng btn_ecng_outline').addClass('btn_ecng_outline');
    $(this).addClass('btn_ecng ');
});
// panigation
$('.paginationNumber ').click(function() {
    $('.pagination').find('.pagination_active').removeClass('pagination_active')
    $(this).addClass('pagination_active');
});

// productDetai_select 
$('.productDetail_classify_select1 label').click(function() {
    $('.productDetail_classify_select1').find('.classify_active').removeClass('classify_active');
    $(this).addClass('classify_active');
});
$('.productDetail_classify_select2 label').click(function() {
    $('.productDetail_classify_select2').find('.classify_active').removeClass('classify_active');
    $(this).addClass('classify_active');
});

// productDetai 
$('#productDetail').owlCarousel({
    loop: false,
    margin: 5,
    nav: true,
    dots: false,
    items: 5,
    navText: ['<i class="fa fa-chevron-left productDetail_left" aria-hidden="true"></i>', '<i class="fa fa-chevron-right productDetail_right" aria-hidden="true"></i>']
});
$('#productDetail_canLike,#productDetail_other').owlCarousel({
    loop: false,
    margin: 10,
    nav: false,
    dots: false,
    responsive: {
        0: {
            items: 6
        },
    }
});


// payment 
$('#change_address').click(function() {
    $('.payment_address').addClass('d-none');
    $('.payment_addressChange').removeClass('d-none')
});
$('#save_address').click(function() {
    $('.payment_address').removeClass('d-none');
    $('.payment_addressChange').addClass('d-none')
})


// error form 
$("#add_address").validate({
    rules: {
        name: {
            required: true,
            minlength: 4,
        },

        phone: {
            required: true,
            sdt: true,
        },
        address_short: {
            required: true,
            minlength: 4,
        },
    },
    messages: {
        name: {
            required: "Vui l??ng nh???p t??n",
            minlength: "Vui l??ng nh???p ??t nh???t 4 k?? t??? ",
        },

        phone: {
            required: "Ch??a nh???p s??? ??i???n tho???i",
            // sdt: true,
        },
        address_short: {
            required: "Vui l??ng nh???p ?????a ch???",
            minlength: "Vui l??ng nh???p ??t nh???t 4 k?? t??? ",
        },

    }
});
$.validator.addMethod("sdt", function(value, element) {
    return this.optional(element) || /(0+([1-9]+[0-9]{8})\b)/i.test(value);
}, "S??? ??i???n tho???i kh??ng ????ng ?????nh d???ng");

$("#change_password").validate({
    rules: {
        password_old: {
            required: true,
            minlength: 6,
        },

        password_new: {
            required: true,
            minlength: 6,

        },
        re_password_new: {
            equalTo: "#password_new"
        }

    },
    messages: {
        password_old: {
            required: "Ch??a nh???p m???t kh???u c??",
            minlength: "M???t kh???u ph???i ??t nh???t 6 k?? t??? ",
        },
        password_new: {
            required: "Vui l??ng nh???p m???t kh???u",
            minlength: "M???t kh???u ph???i tr??n 6 k?? t???",
        },
        re_password_new: {
            equalTo: "Nh???p l???i m???t kh???u kh??ng ch??nh x??c"
        }
    }
});

// dashboard_user history header  
$('.history_header a').click(function() {
    $('.history_header').find('.btn_ecng').removeClass('btn_ecng').addClass('btn_gray');
    $(this).addClass('btn_ecng').removeClass('btn_gray');
});


// rating 
$(document).ready(function() {


    $('#stars li').on('mouseover', function() {
        var onStar = parseInt($(this).data('value'), 10);


        $(this).parent().children('li.star').each(function(e) {
            if (e < onStar) {
                $(this).addClass('hover');
            } else {
                $(this).removeClass('hover');
            }
        });

    }).on('mouseout', function() {
        $(this).parent().children('li.star').each(function(e) {
            $(this).removeClass('hover');
        });
    });
    /*click */
    $('#stars li').on('click', function() {
        var onStar = parseInt($(this).data('value'), 10);
        var stars = $(this).parent().children('li.star');
        for (i = 0; i < stars.length; i++) {
            $(stars[i]).removeClass('selected');
        }
        for (i = 0; i < onStar; i++) {
            $(stars[i]).addClass('selected');
        }
    });
});

// dashboard user 
$("#user_info").validate({
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
        }

    },
    messages: {
        name: {
            required: "Vui l??ng nh???p t??n",
            minlength: "Vui l??ng nh???p ??t nh???t 4 k?? t??? ",
        },
        email: {
            required: "Vui l??ng nh???p email",
            email: "Email ch??a ????ng ?????nh d???ng",
        },
        phone: {
            required: "Ch??a nh???p s??? ??i???n tho???i",
            // sdt: true,
        }

    }
});
$.validator.addMethod("sdt", function(value, element) {
    return this.optional(element) || /(0+([1-9]+[0-9]{8})\b)/i.test(value);
}, "S??? ??i???n tho???i kh??ng ????ng ?????nh d???ng");
	
});
	