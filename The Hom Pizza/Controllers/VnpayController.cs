using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Controllers
{
    public class VnpayController : BaseController
    {
        // GET: Vnpay
        public ActionResult CreatePaymentUrl(int amount, string orderId)
        {
            // Các thông tin cơ bản về giao dịch
            string vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
            string vnp_ReturnUrl = "https://localhost:44325/Vnpay/PaymentReturn";
            string vnp_TmnCode = "2VC28X5X"; // Thay bằng mã Terminal do VNPay cung cấp
            string vnp_HashSecret = "14ITU6357EFHGF4ULZFRWQXMYB0RHTMU"; // Thay bằng mã bí mật do VNPay cung cấp

            // Khởi tạo VnPayLibrary
            VnPayLibrary vnPay = new VnPayLibrary();
            vnPay.AddRequestData("vnp_Version", "2.1.0");
            vnPay.AddRequestData("vnp_Command", "pay");
            vnPay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
            vnPay.AddRequestData("vnp_Amount", ((long)(amount * 100)).ToString()); // Chuyển đổi sang đơn vị VND
            vnPay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss"));
            vnPay.AddRequestData("vnp_CurrCode", "VND");
            vnPay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress());
            vnPay.AddRequestData("vnp_OrderType", "other");
            vnPay.AddRequestData("vnp_Locale", "vn");
            vnPay.AddRequestData("vnp_OrderInfo", $"Thanh toán đơn hàng {orderId}");
            vnPay.AddRequestData("vnp_ReturnUrl", vnp_ReturnUrl);
            vnPay.AddRequestData("vnp_TxnRef", orderId);

            // Tạo URL thanh toán
            string paymentUrl = vnPay.CreateRequestUrl(vnp_Url, vnp_HashSecret);
            return Redirect(paymentUrl);
        }
        public ActionResult PaymentReturn()
        {
            DataModel db = new DataModel();
           
            VnPayLibrary vnPay = new VnPayLibrary();
            foreach (string key in Request.QueryString)
            {
                vnPay.AddResponseData(key, Request.QueryString[key]);
            }

            string vnp_HashSecret = "14ITU6357EFHGF4ULZFRWQXMYB0RHTMU"; // Mã bí mật
            string vnp_SecureHash = Request.QueryString["vnp_SecureHash"];
            string vnp_TxnRef = vnPay.GetResponseData("vnp_TxnRef");
            if (vnPay.GetResponseData("vnp_ResponseCode") == "00" && vnPay.ValidateSignature(vnp_SecureHash, vnp_HashSecret))
            {
                ViewBag.Message = "Đặt hàng thành công!";
                // Cập nhật trạng thái đơn hàng là đang giao
                db.get($"UPDATE DonHang SET TrangThai = N'Đang giao', IsPayment = 1  WHERE OrderID = '{vnp_TxnRef}'");
            }
            else
            {
                ViewBag.Message = "Giao dịch thất bại!";
                // Cập nhật trạng thái đơn hàng là hủy đơn
                db.get($"UPDATE DonHang SET TrangThai = N'Hủy đơn' WHERE OrderID = '{vnp_TxnRef}'");
            }
            return View();
        }
    }
}