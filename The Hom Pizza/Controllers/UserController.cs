using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using The_Hom_Pizza.Filters;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Controllers
{
    public class UserController : BaseController
    {
        //Đăng nhập
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string phone, string password)
        {
            if (string.IsNullOrWhiteSpace(phone) || string.IsNullOrWhiteSpace(password))
            {
                return Json(new { success = false, message = "Tên đăng nhập và mật khẩu không được để trống!" });
            }
            DataModel db = new DataModel();
            try
            {
                ViewBag.list = db.get($"SELECT * FROM KhachHang WHERE Phone = '{phone}' AND Password = '{password}' AND IsActive = 1");

                if (ViewBag.list.Count > 0)
                {
                    Session["UserID"] = ViewBag.list[0][0]; // IDKH
                    Session["TenKH"] = ViewBag.list[0][2]; // TenKhachHang
                    Session["AvatarKH"] = ViewBag.list[0][6]; // AvatarKhachHang
                    int roleId = Convert.ToInt32(ViewBag.list[0][7]);
                    Session["RoleID"] = roleId;

                    // Xác định trang đích dựa trên RoleID
                    string redirectUrl = Url.Action("Index", "Home"); // Mặc định là trang chủ

                    if (roleId == 1) // Admin
                    {
                        redirectUrl = Url.Action("Dashboard", "Admin"); // Trang quản trị trong Areas
                    }
                    else if (roleId == 3) // Khách hàng thân thiết
                    {
                        redirectUrl = Url.Action("Index", "Home"); // Trang chủ đã đăng nhập                    
                    }
                    return Json(new { success = true, redirectUrl });
                }
                else
                {
                    return Json(new { success = false, message = "Sai tên đăng nhập hoặc mật khẩu." });
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi, trả về JSON
                return Json(new { success = false, message = ex.Message });
            }
        }

        //Đăng ký
        public ActionResult Registration()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Registration(string Password, string name, string email, string phone)
        {
            // Kiểm tra trường nào bị bỏ trống
            if (string.IsNullOrWhiteSpace(Password) || string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(phone))
            {
                return Json(new { success = false, message = "Vui lòng điền đầy đủ thông tin!" });
            }
            DataModel db = new DataModel();
            try
            {
                ViewBag.CheckUser = db.get($"SELECT IDKH FROM KHACHHANG WHERE Phone = '{phone}'");
                if (ViewBag.CheckUser.Count > 0)
                {
                    try
                    {
                        db.get($"UPDATE KHACHHANG SET TenKhachHang = N'{name}', Email = '{email}', DiaChi = '', RoleID = 3, Password = '{Password}', IsActive = 1 WHERE Phone = '{phone}';");
                        // Đăng ký thành công, trả về JSON
                        return Json(new { success = true, message = "Đăng ký thành công!" });
                    }
                    catch
                    {
                        return Json(new { success = false, message = "Đã có lỗi xảy ra. Vui lòng thử lại sau." });
                    }
                }
                else
                {
                    var result = db.get("EXEC sp_ThemKH '" + Password + "', N'" + name + "','" + email + "','" + phone + "', 3, N'user_default.png', '';");
                    if (result.Count > 0)
                    {
                        // Đăng ký thành công, trả về JSON
                        return Json(new { success = true, message = "Đăng ký thành công!" });
                    }
                    else
                    {
                        return Json(new { success = false, message = "Đã có lỗi xảy ra. Vui lòng thử lại sau." });
                    }
                }

            }
            catch (Exception ex)
            {
                // Xử lý lỗi, trả về JSON
                return Json(new { success = false, message = ex.Message });
            }
        }

        //Đăng xuất
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Index", "Home");
        }
              
    }
}