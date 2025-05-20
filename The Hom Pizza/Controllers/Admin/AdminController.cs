using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using The_Hom_Pizza.Filters;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Controllers
{
    public class AdminController : Controller
    {
        [AuthorizeRole(AllowedRoles = "1")] // Chỉ Admin có thể truy cập
        public ActionResult Dashboard()
        {
            DataModel db = new DataModel();
            ViewBag.DoanhThu = db.get("SELECT SUM(TongTien) FROM DonHang");
            ViewBag.UserAmount = db.get("SELECT COUNT(IDKH) FROM KhachHang Where IsActive = 1");
            ViewBag.OrderAmount = db.get("SELECT COUNT(OrderID) FROM DonHang");
            ViewBag.FeedbackAmount = db.get("SELECT COUNT(WishlistID) FROM Wishlist");
            ViewBag.list = db.get("SELECT DH.OrderID, KH.TenKhachHang, DH.AddressDelivery, DH.NgayDat, DH.TongTien, DH.PayType, DH.TrangThai, DH.IsPayment FROM DonHang DH JOIN KhachHang KH ON DH.IDKH = KH.IDKH;");
            return View();
        }

    }
}