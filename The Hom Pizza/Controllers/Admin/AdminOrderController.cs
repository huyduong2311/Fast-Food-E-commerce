using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using The_Hom_Pizza.Filters;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Controllers.Admin
{
    public class AdminOrderController : Controller
    {
        [AuthorizeRole(AllowedRoles = "1")] // Chỉ Admin có thể truy cập
        // GET: AdminOrder
        public ActionResult Index()
        {
            DataModel db = new DataModel();
            ViewBag.list = db.get("SELECT DH.OrderID, KH.TenKhachHang, DH.AddressDelivery, DH.NgayDat, DH.TongTien, DH.PayType, DH.TrangThai, DH.IsPayment, DH.Note, DH.IDKH FROM DonHang DH JOIN KhachHang KH ON DH.IDKH = KH.IDKH;");
            return View();
        }
        //Xóa sp
        [HttpPost]
        public ActionResult RemoveOrder(string id)
        {
            DataModel db = new DataModel();
            try
            {
                db.get($"DELETE FROM CHITIETDONHANG WHERE OrderID = {id};");
                db.get($"DELETE FROM DONHANG WHERE OrderID = {id};");
                // Trả về thông báo thành công
                return Json(new { success = true, message = "Xóa đơn hàng thành công!" });
            }
            catch (Exception)
            {
                // Trả về thông báo lỗi
                return Json(new { success = false, message = "Vui lòng kiểm tra lại các dữ liệu liên quan đến đơn này trước khi xóa!" });
            }
        }
        //Cập nhật sp
        public ActionResult SelectToUpdateOrder(string id)
        {
            DataModel db = new DataModel();
            ViewBag.list = db.get($"SELECT * FROM DonHang WHERE OrderID = {id}");
            if (ViewBag.list == null || ViewBag.list.Count == 0) // Kiểm tra ViewBag.list
            {
                return HttpNotFound();
            }
            return PartialView("_SelectToUpdateOrder");
        }
        [HttpPost]
        public ActionResult UpdateOrder(string id, string diachi, string note, string httt, string ispayment, string status)
        {
            DataModel db = new DataModel();

            ViewBag.list = db.get($"SELECT * FROM DONHANG WHERE OrderID = {id}");
            if (ViewBag.list == null || ViewBag.list.Count == 0)
            {
                return HttpNotFound(); // Không tìm thấy sản phẩm
            }

            // Nếu input để trống, giữ giá trị cũ
            string newAddress = string.IsNullOrEmpty(diachi) ? ViewBag.list[0][4].ToString() : diachi;
            string newNote = string.IsNullOrEmpty(note) ? ViewBag.list[0][6].ToString() : note;
            string newPayType = string.IsNullOrEmpty(httt) ? ViewBag.list[0][7].ToString() : httt;
            string newIsPay = string.IsNullOrEmpty(ispayment) ? ViewBag.list[0][8].ToString() : ispayment;
            string newStatus = string.IsNullOrEmpty(status) ? ViewBag.list[0][9].ToString() : status;
            db.get($"UPDATE DONHANG SET AddressDelivery = N'{newAddress}', Note = N'{newNote}', PayType = N'{newPayType}', IsPayment = '{newIsPay}', TrangThai = N'{newStatus}' WHERE OrderID = {id};");
            return Redirect(Request.UrlReferrer.ToString());
        }
    }
}