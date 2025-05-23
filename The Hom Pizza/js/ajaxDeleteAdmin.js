

//delete category
$(document).on('click', '.delete-category', function (e) {
    e.preventDefault();

    // Lấy thông tin form và ID size
    var form = $(this).closest('form');
    var formData = form.serialize(); // Lấy toàn bộ dữ liệu form
    var url = form.attr('action'); // Lấy URL từ action của form

    // Hiển thị cảnh báo xác nhận trước khi thực hiện xóa
    Swal.fire({
        title: "Bạn có chắc chắn muốn xóa?",
        text: "Dữ liệu sẽ không thể khôi phục lại!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "Xóa",
        cancelButtonText: "Hủy"
    }).then((result) => {
        if (result.isConfirmed) {
            // Gửi yêu cầu AJAX nếu người dùng xác nhận
            $.ajax({
                url: url,
                type: form.attr('method'),
                data: formData,
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        Swal.fire({
                            title: "Thành công!",
                            text: response.message,
                            icon: "success",
                            timer: 1000,
                            showConfirmButton: false
                        }).then(() => {
                            location.reload(); // Tải lại trang
                        });
                    } else {
                        Swal.fire({
                            title: "Lỗi!",
                            text: response.message,
                            icon: "error"
                        });
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Lỗi AJAX:", status, error, xhr.responseText);
                    Swal.fire({
                        title: "Lỗi!",
                        text: "Đã có lỗi xảy ra. Vui lòng thử lại.",
                        icon: "error"
                    });
                }
            });
        }
    });
});
//delete size
$(document).on('click', '.delete-size', function (e) {
    e.preventDefault();

    // Lấy thông tin form và ID size
    var form = $(this).closest('form');
    var formData = form.serialize(); // Lấy toàn bộ dữ liệu form
    var url = form.attr('action'); // Lấy URL từ action của form

    // Hiển thị cảnh báo xác nhận trước khi thực hiện xóa
    Swal.fire({
        title: "Bạn có chắc chắn muốn xóa?",
        text: "Dữ liệu sẽ không thể khôi phục lại!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "Xóa",
        cancelButtonText: "Hủy"
    }).then((result) => {
        if (result.isConfirmed) {
            // Gửi yêu cầu AJAX nếu người dùng xác nhận
            $.ajax({
                url: url,
                type: form.attr('method'),
                data: formData,
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        Swal.fire({
                            title: "Thành công!",
                            text: response.message,
                            icon: "success",
                            timer: 1000,
                            showConfirmButton: false
                        }).then(() => {
                            location.reload(); // Tải lại trang
                        });
                    } else {
                        Swal.fire({
                            title: "Lỗi!",
                            text: response.message,
                            icon: "error"
                        });
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Lỗi AJAX:", status, error, xhr.responseText);
                    Swal.fire({
                        title: "Lỗi!",
                        text: "Đã có lỗi xảy ra. Vui lòng thử lại.",
                        icon: "error"
                    });
                }
            });
        }
    });
});

//delete crust
$(document).on('click', '.delete-crust', function (e) {
    e.preventDefault();

    // Lấy thông tin form và ID size
    var form = $(this).closest('form');
    var formData = form.serialize(); // Lấy toàn bộ dữ liệu form
    var url = form.attr('action'); // Lấy URL từ action của form

    // Hiển thị cảnh báo xác nhận trước khi thực hiện xóa
    Swal.fire({
        title: "Bạn có chắc chắn muốn xóa?",
        text: "Dữ liệu sẽ không thể khôi phục lại!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "Xóa",
        cancelButtonText: "Hủy"
    }).then((result) => {
        if (result.isConfirmed) {
            // Gửi yêu cầu AJAX nếu người dùng xác nhận
            $.ajax({
                url: url,
                type: form.attr('method'),
                data: formData,
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        Swal.fire({
                            title: "Thành công!",
                            text: response.message,
                            icon: "success",
                            timer: 1000,
                            showConfirmButton: false
                        }).then(() => {
                            location.reload(); // Tải lại trang
                        });
                    } else {
                        Swal.fire({
                            title: "Lỗi!",
                            text: response.message,
                            icon: "error"
                        });
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Lỗi AJAX:", status, error, xhr.responseText);
                    Swal.fire({
                        title: "Lỗi!",
                        text: "Đã có lỗi xảy ra. Vui lòng thử lại.",
                        icon: "error"
                    });
                }
            });
        }
    });
});

// Xử lý thông báo xóa sản phẩm
$(document).on('click', '.delete-product', function (e) {
    e.preventDefault();

    // Lấy thông tin form và ID size
    var form = $(this).closest('form');
    var formData = form.serialize(); // Lấy toàn bộ dữ liệu form
    var url = form.attr('action'); // Lấy URL từ action của form

    // Hiển thị cảnh báo xác nhận trước khi thực hiện xóa
    Swal.fire({
        title: "Bạn có chắc chắn muốn xóa?",
        text: "Dữ liệu sẽ không thể khôi phục lại!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "Xóa",
        cancelButtonText: "Hủy"
    }).then((result) => {
        if (result.isConfirmed) {
            // Gửi yêu cầu AJAX nếu người dùng xác nhận
            $.ajax({
                url: url,
                type: form.attr('method'),
                data: formData,
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        Swal.fire({
                            title: "Thành công!",
                            text: response.message,
                            icon: "success",
                            timer: 1000,
                            showConfirmButton: false
                        }).then(() => {
                            location.reload(); // Tải lại trang
                        });
                    } else {
                        Swal.fire({
                            title: "Lỗi!",
                            text: response.message,
                            icon: "error"
                        });
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Lỗi AJAX:", status, error, xhr.responseText);
                    Swal.fire({
                        title: "Lỗi!",
                        text: "Đã có lỗi xảy ra. Vui lòng thử lại.",
                        icon: "error"
                    });
                }
            });
        }
    });
});

//delete user
$(document).on('click', '.delete-user', function (e) {
    e.preventDefault();

    // Lấy thông tin form và ID size
    var form = $(this).closest('form');
    var formData = form.serialize(); // Lấy toàn bộ dữ liệu form
    var url = form.attr('action'); // Lấy URL từ action của form

    // Hiển thị cảnh báo xác nhận trước khi thực hiện xóa
    Swal.fire({
        title: "Bạn có chắc chắn muốn khóa tài khoản?",
        //text: "Dữ liệu sẽ không thể khôi phục lại!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "Khóa",
        cancelButtonText: "Hủy"
    }).then((result) => {
        if (result.isConfirmed) {
            // Gửi yêu cầu AJAX nếu người dùng xác nhận
            $.ajax({
                url: url,
                type: form.attr('method'),
                data: formData,
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        Swal.fire({
                            title: "Khóa thành công!",
                            text: response.message,
                            icon: "success",
                            timer: 1000,
                            showConfirmButton: false
                        }).then(() => {
                            location.reload(); // Tải lại trang
                        });
                    } else {
                        Swal.fire({
                            title: "Lỗi!",
                            text: response.message,
                            icon: "error"
                        });
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Lỗi AJAX:", status, error, xhr.responseText);
                    Swal.fire({
                        title: "Lỗi!",
                        text: "Đã có lỗi xảy ra. Vui lòng thử lại.",
                        icon: "error"
                    });
                }
            });
        }
    });
});

//open-user
$(document).on('click', '.open-user', function (e) {
    e.preventDefault();

    // Lấy thông tin form và ID size
    var form = $(this).closest('form');
    var formData = form.serialize(); // Lấy toàn bộ dữ liệu form
    var url = form.attr('action'); // Lấy URL từ action của form

    $.ajax({
        url: url,
        type: form.attr('method'),
        data: formData,
        dataType: 'json',
        success: function (response) {
            if (response.success) {
                Swal.fire({
                    title: "Mở khóa thành công!",
                    text: response.message,
                    icon: "success",
                    timer: 1000,
                    showConfirmButton: false
                }).then(() => {
                    location.reload(); // Tải lại trang
                });
            } else {
                Swal.fire({
                    title: "Lỗi!",
                    text: response.message,
                    icon: "error"
                });
            }
        },
        error: function (xhr, status, error) {
            console.error("Lỗi AJAX:", status, error, xhr.responseText);
            Swal.fire({
                title: "Lỗi!",
                text: "Đã có lỗi xảy ra. Vui lòng thử lại.",
                icon: "error"
            });
        }
    });
});

//Xử lý khi thêm giá size là âm
document.getElementById("submitAddSize").addEventListener("click", function (event) {
    const priceInput = document.getElementById("sizePrice");
    const priceValue = parseFloat(priceInput.value);

    if (priceValue < 0) {
        alert("Giá không được là số âm. Vui lòng nhập lại!");
        event.preventDefault(); // Ngăn gửi form
    }
});
//Xử lý khi thêm giá crust là âm
document.getElementById("submitAddCrust").addEventListener("click", function (event) {
    const priceInput = document.getElementById("crustPrice");
    const priceValue = parseFloat(priceInput.value);

    if (priceValue < 0) {
        alert("Giá không được là số âm. Vui lòng nhập lại!");
        event.preventDefault(); // Ngăn gửi form
    }
});
//Xử lý khi thêm giá sản phẩm là âm
document.getElementById("submitAddProduct").addEventListener("click", function (event) {
    const priceInput = document.getElementById("productPrice");
    const priceValue = parseFloat(priceInput.value);

    if (priceValue < 0) {
        alert("Giá không được là số âm. Vui lòng nhập lại!");
        event.preventDefault(); // Ngăn gửi form
    }
});