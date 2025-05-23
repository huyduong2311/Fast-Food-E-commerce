
//Xử lý để mở trang _ProductDetails
$(document).on('click', '.addToCartBtn', function () {
    var productId = $(this).data('id');
    //var modalBody = $('#productDetailsContent');

    // Hiển thị Modal ngay lập tức
    //$('#productDetailsModal').modal('show');

    // Gửi yêu cầu AJAX để lấy dữ liệu sản phẩm
    $.ajax({
        url: '/Home/GetProductDetails', // Endpoint để lấy dữ liệu sản phẩm
        type: 'GET',
        data: { id: productId },
        success: function (response) {
            $('#productDetailsContent').html(response);
        },
        error: function () {
            $('#productDetailsContent').html('<p>Không thể tải chi tiết sản phẩm. Vui lòng thử lại.</p>');
        }
    });
}); 

//Xử lý nút đóng modal
$(document).on('click', '.btn-close', function () {
    // Đóng modal
    $('#productDetailsModal').modal('hide');
});

//Xử lý để mở modal-body edit category
$(document).on('click', '#idEditContent', function () {
    var productId = $(this).data('id');

    // Gửi yêu cầu AJAX để lấy dữ liệu sản phẩm
    $.ajax({
        url: '/AdminCategory/SelectToUpdate', // Endpoint để lấy dữ liệu sản phẩm
        type: 'GET',
        data: { id: productId },
        success: function (response) {
            $('#editContent').html(response);
        },
        error: function () {
            $('#editContent').html('<p>Không thể tải. Vui lòng thử lại.</p>');
        }
    });
}); 

//Xử lý để mở modal-body edit size
$(document).on('click', '#idEditContentSize', function () {
    var productId = $(this).data('id');

    // Gửi yêu cầu AJAX để lấy dữ liệu sản phẩm
    $.ajax({
        url: '/AdminCategory/SelectToUpdateSize', // Endpoint để lấy dữ liệu sản phẩm
        type: 'GET',
        data: { id: productId },
        success: function (response) {
            $('#editContentSize').html(response);
        },
        error: function () {
            $('#editContentSize').html('<p>Không thể tải. Vui lòng thử lại.</p>');
        }
    });
});
//Xử lý để mở modal-body edit crust pizza
$(document).on('click', '#idEditContentCrust', function () {
    var productId = $(this).data('id');

    // Gửi yêu cầu AJAX để lấy dữ liệu sản phẩm
    $.ajax({
        url: '/AdminCategory/SelectToUpdateLoaiPizza', // Endpoint để lấy dữ liệu sản phẩm
        type: 'GET',
        data: { id: productId },
        success: function (response) {
            $('#editContentCrust').html(response);
        },
        error: function () {
            $('#editContentCrust').html('<p>Không thể tải. Vui lòng thử lại.</p>');
        }
    });
});

//Xử lý edit product
$(document).on('click', '#idEditContentProduct', function () {
    var productId = $(this).data('id');

    // Gửi yêu cầu AJAX để lấy dữ liệu sản phẩm
    $.ajax({
        url: '/AdminProduct/SelectToUpdateProduct', // Endpoint để lấy dữ liệu sản phẩm
        type: 'GET',
        data: { id: productId },
        success: function (response) {
            $('#editContentProduct').html(response);
        },
        error: function () {
            $('#editContentProduct').html('<p>Không thể tải. Vui lòng thử lại.</p>');
        }
    });
});

//Xử lý edit user
$(document).on('click', '#idEditContentUser', function () {
    var productId = $(this).data('id');

    // Gửi yêu cầu AJAX để lấy dữ liệu sản phẩm
    $.ajax({
        url: '/AdminUser/SelectToUpdateUser', // Endpoint để lấy dữ liệu sản phẩm
        type: 'GET',
        data: { id: productId },
        success: function (response) {
            $('#editContentUser').html(response);
        },
        error: function () {
            $('#editContentUser').html('<p>Không thể tải. Vui lòng thử lại.</p>');
        }
    });
});



// Xử lý phần menu trong trang shop
function toggleCollapse(elementId) {
    var collapseElement = document.getElementById(elementId);
    var iconElement = document.getElementById('icon-' + elementId.split('-').pop());

    if (collapseElement.classList.contains('show')) {
        collapseElement.classList.remove('show');
        iconElement.classList.remove('fa-chevron-up');
        iconElement.classList.add('fa-chevron-down');
    } else {
        collapseElement.classList.add('show');
        iconElement.classList.remove('fa-chevron-down');
        iconElement.classList.add('fa-chevron-up');
    }
}