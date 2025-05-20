using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Controllers
{
    public class PaymentController : BaseController
    {
        //Trang thanh toán
        public ActionResult Checkout()
        {
            ViewBag.list2 = db.get("SELECT * FROM LoaiSP Where IsActive = 1");
            // Nếu người dùng đăng nhập, lấy thông tin tài khoản từ DB
            if (Session["UserID"] != null)
            {
                string userid = Session["UserID"].ToString();
                ViewBag.list = db.get("SELECT * FROM KhachHang WHERE IDKH = " + userid);
            }
            return View();
        }
        //Trang thanh toán khi nhận hàng
        public ActionResult ShipCOD(int orderId)
        {
            ViewBag.list2 = db.get("SELECT * FROM LoaiSP Where IsActive = 1");
            ViewBag.OrderID = orderId;
            return View();
        }
        [HttpPost]
        public ActionResult ThemDonHang(string name, string email, string phone, string diachi, string tp, string quan, string phuong, string note, string PayType)
        {
            DataModel db = new DataModel();
            string fullAddress = string.Join(" ", new[] { diachi, phuong, quan, tp }.Where(s => !string.IsNullOrEmpty(s)));

            int orderId;
            int totalAmount = 0;

            if (Session["UserID"] != null)
            {
                string userid = Session["UserID"].ToString();
                ViewBag.CartItems = db.get("EXEC sp_GetCartItems " + userid);
                foreach (var a in ViewBag.CartItems)
                {   
                    totalAmount += Convert.ToInt32(a[12]);
                }

                var voucherID = Session["VoucherID"] != null ? Session["VoucherID"].ToString() : "null";
                var totalAfterDiscount = Session["TotalAmountAfterDiscount"] ?? totalAmount;

                var result = db.get($"EXEC InsertOrderWithDetails {userid}, {voucherID}, N'{fullAddress}', {totalAfterDiscount}, N'{note}', N'{PayType}'; ");
                orderId = Convert.ToInt32(((ArrayList)result[0])[0]);
            }
            else
            {
                ViewBag.CheckUser = db.get($"SELECT IDKH FROM KHACHHANG WHERE Phone = '{phone}'");
                if(ViewBag.CheckUser.Count > 0)
                {                   
                    db.get($"UPDATE KHACHHANG SET TenKhachHang = N'{name}', Email = '{email}', DiaChi = N'{fullAddress}' WHERE Phone = '{phone}';");
                    ViewBag.listIDKH = db.get($"SELECT IDKH FROM KHACHHANG WHERE Phone = '{phone}'");
                }   
                else
                {
                    try
                    {
                        db.get($"EXEC sp_ThemKH null, N'{name}', '{email}', '{phone}', 2, N'user_default.png', N'{fullAddress}';");
                        ViewBag.listIDKH = db.get($"SELECT IDKH FROM KHACHHANG WHERE Phone = '{phone}'");
                    }
                    catch (Exception ex)
                    {
                        TempData["ErrorMessage"] = ex.Message;
                        return Redirect(Request.UrlReferrer.ToString());
                    }
                }               
                // Nếu khách vãng lai, lấy giỏ hàng từ Session
                if (Session["CartItems"] != null)
                {
                    List<CartItem> cartItems = (List<CartItem>)Session["CartItems"];
                    totalAmount = cartItems.Sum(x => x.GrandTotal);
                }
                var voucherID = Session["VoucherID"] != null ? Session["VoucherID"].ToString() : "null";
                var totalAfterDiscount = Session["TotalAmountAfterDiscount"] ?? totalAmount;

                var result = db.get($"EXEC InsertOrderWithDetails {ViewBag.listIDKH[0][0]}, {voucherID}, N'{fullAddress}', {totalAfterDiscount}, N'{note}', N'{PayType}'; ");
                orderId = Convert.ToInt32(((ArrayList)result[0])[0]);
                // ✅ Chuyển dữ liệu từ Session["CartItems"] sang bảng CHITIETDONHANG
                if (Session["CartItems"] != null)
                {
                    List<CartItem> cartItems = (List<CartItem>)Session["CartItems"];

                    foreach (var item in cartItems)
                    {
                        if(item.PizzaID == 0)
                        {
                            db.get($"EXEC sp_ThemChiTietDonHang {orderId}, {item.ProductID}, null, {item.Quantity}, {item.GrandTotal};");
                            
                        }
                        else
                        {
                            db.get($"EXEC sp_ThemChiTietDonHang {orderId}, {item.ProductID}, {item.PizzaID}, {item.Quantity}, {item.GrandTotal};");
                        }
                    }

                }
                // ✅ Xóa giỏ hàng trong session sau khi đặt hàng thành công
                Session.Remove("CartItems");
                Session.Remove("TotalAmountAfterDiscount");
                Session.Remove("VoucherID");
            }

            // ✅ Xử lý luồng thanh toán
            if (PayType == "Ship COD")
            {
                return RedirectToAction("ShipCOD", "Payment", new { orderId = orderId });
            }
            else if (PayType == "Chuyển khoản VNPAY")
            {
                return RedirectToAction("CreatePaymentUrl", "Vnpay", new { amount = totalAmount, orderId = orderId });
            }

            TempData["ErrorMessage"] = "Phương thức thanh toán không hợp lệ!";
            return Redirect(Request.UrlReferrer?.ToString() ?? "/Checkout");
        }

        
        //[HttpPost]
        //public JsonResult ApplyVoucher(string voucherCode)
        //{
        //    DataModel db = new DataModel();
        //    decimal discountAmount = 0;
        //    int VoucherID = 0;

        //    if (!string.IsNullOrEmpty(voucherCode))
        //    {
        //        var voucherResult = db.get($"SELECT CouponDiscount, VoucherID FROM Voucher WHERE Code = '{voucherCode}' AND IsActive = 1 AND NgayHetHan >= GETDATE()");

        //        if (voucherResult != null && voucherResult.Count > 0)
        //        {
        //            discountAmount = Convert.ToDecimal(((ArrayList)voucherResult[0])[0]);
        //            VoucherID = Convert.ToInt32(((ArrayList)voucherResult[0])[1]);

        //            // Kiểm tra khách hàng đăng nhập hay không
        //            decimal totalAmount = 0;
        //            if (Session["UserID"] != null)
        //            {
        //                string userID = Session["UserID"].ToString();
        //                // Lấy thông tin giỏ hàng từ database
        //                ViewBag.CartItems = db.get("EXEC sp_GetCartItems " + userID);
        //                ViewBag.CartItemCount = db.get($"SELECT SUM(SoLuong) AS TotalQuantity FROM GioHang WHERE IDKH = {userID}");

        //                // Lấy tổng tiền giỏ hàng
        //                foreach (var a in ViewBag.CartItems)
        //                {
        //                    totalAmount += Convert.ToInt32(a[12]);
        //                }
        //                ViewBag.TotalAmount = totalAmount;
        //            }
        //            else
        //            {
        //                // Nếu khách vãng lai, lấy giỏ hàng từ Session
        //                if (Session["CartItems"] != null)
        //                {
        //                    List<CartItem> cartItems = (List<CartItem>)Session["CartItems"];
        //                    totalAmount = cartItems.Sum(x => x.GrandTotal);
        //                }
        //            }

        //            // Nếu tổng tiền vẫn = 0, có thể có lỗi, cần kiểm tra
        //            if (totalAmount == 0)
        //            {
        //                return Json(new { success = false, message = "Lỗi: Không lấy được tổng tiền đơn hàng." });
        //            }

        //            // Tính tiền giảm giá
        //            decimal totalDiscount = totalAmount * discountAmount;
        //            decimal discountedAmount = totalAmount - totalDiscount;

        //            // Cập nhật session
        //            Session["TotalAmountAfterDiscount"] = discountedAmount;
        //            Session["VoucherID"] = VoucherID;

        //            return Json(new
        //            {
        //                success = true,
        //                discountPercent = discountAmount * 100,
        //                totalDiscount = totalDiscount.ToString("#,##0"),
        //                totalAmountAfterDiscount = discountedAmount.ToString("#,##0")
        //            });
        //        }
        //        else
        //        {
        //            return Json(new { success = false, message = "Mã giảm giá không hợp lệ hoặc đã hết hạn." });
        //        }
        //    }
        //    return Json(new { success = false, message = "Vui lòng nhập mã giảm giá." });
        //}

    }

}
