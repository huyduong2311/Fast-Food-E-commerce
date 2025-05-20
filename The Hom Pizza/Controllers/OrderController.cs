using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Controllers
{
    public class OrderController : BaseController
    {
        //Trang xem lại lịch sử mua hàng
        public ActionResult XemLaiDonHang()
        {
            ViewBag.list = db.get($"SELECT * FROM DonHang WHERE IDKH = {ViewBag.UserID} ORDER BY NgayDat DESC");
            return View();
        }

        public ActionResult TraCuuDonHang(string phoneNumber)
        {
            try
            {
                DataModel db = new DataModel();
                ViewBag.listIDKH = db.get($"SELECT IDKH FROM KHACHHANG WHERE Phone = '{phoneNumber}'");
                ViewBag.Orders = db.get($"SELECT * FROM DonHang WHERE IDKH = {ViewBag.listIDKH[0][0]} ORDER BY NgayDat DESC");

                if (ViewBag.Orders.Count == 0)
                {
                    ViewBag.Error = "Số điện thoại này chưa đặt đơn hàng nào!";
                }
            }
            catch { }

            return View();
        }

        //Trang xem lại các món trong đơn hàng
        public ActionResult ChiTietDonHang(string id)
        {
            ViewBag.list = db.get($"EXEC SP_GetOrderDetailsByOrderID {id}");
            return View();
        }

        [HttpPost]
        public JsonResult HuyDonHang(int id)
        {
            try
            {
                // Chỉ hủy đơn khi trạng thái là "Chưa xác nhận"
                ViewBag.checkStatus = db.get($"SELECT TrangThai FROM DonHang WHERE OrderID = {id}");
                if (ViewBag.checkStatus.Count > 0 && ViewBag.checkStatus[0][0].ToString() == "Chưa xác nhận")
                {
                    db.get($"UPDATE DonHang SET TrangThai = N'Hủy đơn' WHERE OrderID = {id}");
                    return Json(new { success = true });
                }
                return Json(new { success = false, message = "Không thể hủy đơn hàng này!" });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }
    }
}