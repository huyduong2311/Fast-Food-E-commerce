
$(document).ready(function () {
    $(".deleteCart").click(function (e) {
        e.preventDefault();

        let button = $(this);
        let idsp = button.data("id");
        let idpizza = button.data("idpizza");
        let note = button.data("note");

        $.ajax({
            url: "/Cart/RemoveFromCart",
            type: "POST",
            data: { idsp: idsp, idpizza: idpizza, note: note },
            success: function (response) {
                if (response.success) {
                    // Xóa dòng sản phẩm khỏi bảng
                    let row = button.closest("tr");
                    row.fadeOut(200, function () {
                        $(this).remove();
                    });
                    location.reload();
                } else {
                    location.reload();
                    Swal.fire({
                        title: "Lỗi!",
                        text: response.message,
                        icon: "error",
                        toast: true,
                        position: "top-end",
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            },
            error: function () {
                Swal.fire({
                    title: "Lỗi!",
                    text: "Có lỗi xảy ra, vui lòng thử lại!",
                    icon: "error",
                    toast: true,
                    position: "top-end",
                    showConfirmButton: false,
                    timer: 2000
                });
            }
        });
    });

    // Khi người dùng nhấn quay lại trang trước, reload để cập nhật giỏ hàng
    $(window).on("pageshow", function (event) {
        if (event.originalEvent.persisted) {
            location.reload();
        }
    });
});

function changeQuantity(button, delta) {
    const input = button.parentElement.querySelector('input[name="quanlity"]');
    let quantity = parseInt(input.value) || 1;
    quantity = Math.max(1, quantity + delta);
    input.value = quantity;
    updateQuantityAjax(input);
}

function updateQuantityAjax(inputElement) {
    const form = inputElement.closest("form");
    const formData = new FormData(form);

    $.ajax({
        url: "/Cart/UpdateCart",
        type: "POST",
        data: {
            idsp: formData.get("idsp"),
            idpizza: formData.get("idpizza"),
            quanlity: formData.get("quanlity"),
            note: formData.get("note")
        },
        success: function (res) {
            // Cập nhật lại trang hiện tại (tùy bạn có muốn load phần giỏ hay toàn trang)
            location.reload();
        },
        error: function () {
            Swal.fire({
                title: "Lỗi!",
                text: "Không thể cập nhật số lượng.",
                icon: "error",
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 2000
            });
        }
    });
}