using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Controllers
{
    public class BaseController : Controller
    {
        // GET: Base
        protected DataModel db = new DataModel(); // Khởi tạo DataModel

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            base.OnActionExecuting(filterContext);
            LoadCartInfo();
        }

        private void LoadCartInfo()
        {
            ViewBag.list2 = db.get("SELECT * FROM LoaiSP Where IsActive = 1");
            if (Session["UserID"] != null)  // Người dùng đã đăng nhập
            {
                string userid = Session["UserID"].ToString();
                ViewBag.UserID = userid;
                ViewBag.TenKH = Session["TenKH"]?.ToString();
                ViewBag.AvatarKH = Session["AvatarKH"]?.ToString();               

                // Lấy sản phẩm trong giỏ hàng của người dùng
                ViewBag.CartItems = db.get("EXEC sp_GetCartItems " + userid);
                ViewBag.CartItemCount = db.get($"SELECT SUM(SoLuong) FROM GioHang WHERE IDKH = {userid}");

                // Tính tổng tiền giỏ hàng
                int totalAmount = 0;
                foreach (var item in ViewBag.CartItems)
                {
                    totalAmount += Convert.ToInt32(item[12]);
                }
                ViewBag.TotalAmount = totalAmount;
            }
            else
            {
                // Xử lý giỏ hàng cho khách vãng lai
                if (Session["CartItems"] != null)
                {
                    var cartItems = (List<CartItem>)Session["CartItems"];
                    ViewBag.CartItems = cartItems;
                    ViewBag.CartItemCount = cartItems.Sum(x => x.Quantity);
                    ViewBag.TotalAmount = cartItems.Sum(x => x.GrandTotal);
                }
                else
                {
                    ViewBag.CartItems = new List<CartItem>(); // Giỏ hàng trống
                }
            }
        }
    }
}