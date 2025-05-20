using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.Security;
using The_Hom_Pizza.Filters;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Controllers.Admin
{
    public class AdminUserController : Controller
    {
        // GET: AdminUser
        public ActionResult Index(string id)
        {
            var db = new DataModel();

            // Lấy thông tin User theo ID hoặc tất cả nếu ID là null
            var userQuery = $@"SELECT kh.IDKH, kh.TenKhachHang, kh.Email, kh.Phone, kh.DiaChi, kh.ImageUser, r.RoleName, kh.IsActive, kh.Password, r.RoleID 
                               FROM KhachHang kh LEFT JOIN Roles r ON kh.RoleID = r.RoleID {(string.IsNullOrEmpty(id) ? "" : $"WHERE IDKH = {id}")};";

            ViewBag.User = db.get(userQuery);

            // Lấy danh sách Roles (chỉ cần lấy một lần)
            ViewBag.listRole = db.get("SELECT * FROM Roles");

            return View();
        }

        //Thêm user
        [HttpPost]
        public ActionResult AddUser(string Password, string idrole, string name, HttpPostedFileBase image, string phone, string email, string diachi, string tp, string quan, string phuong)
        {
            DataModel db = new DataModel();
            string fullAddress = string.Join(" ", new[] { diachi, phuong, quan, tp }.Where(s => !string.IsNullOrEmpty(s)));
            try
            {
                if (image != null && image.ContentLength > 0)
                {
                    string filename = Path.GetFileName(image.FileName);
                    string path = Path.Combine(Server.MapPath("~/images"), filename);
                    image.SaveAs(path);
                    db.get("EXEC sp_ThemKH '" + Password + "', N'" + name + "','" + email + "','" + phone + "', '" + idrole + "', '" + image.FileName + "', N'" + fullAddress + "';");
                }
            }
            catch (Exception ex) 
            {
                Session["Message"] = ex.Message;
            }
            return RedirectToAction("Index", "AdminUser");
        }
        //Khóa user
        [HttpPost]
        public ActionResult RemoveUser(string id)
        {
            DataModel db = new DataModel();
            try
            {
                // Thực hiện xóa trong CSDL
                //db.get($"DELETE FROM SANPHAM WHERE IDSP = {id}");
                db.get($"UPDATE KhachHang SET IsActive = 0 WHERE IDKH = {id};");
                // Trả về thông báo thành công
                return Json(new { success = true, message = "Khóa người dùng thành công!" });
            }
            catch (Exception)
            {
                // Trả về thông báo lỗi
                return Json(new { success = false, message = "Vui lòng kiểm tra lại các dữ liệu liên quan đến người dùng này trước khi xóa!" });
            }
        }
        //Mở khóa user
        [HttpPost]
        public ActionResult OpenUser(string id)
        {
            DataModel db = new DataModel();
            try
            {
                // Thực hiện xóa trong CSDL
                //db.get($"DELETE FROM SANPHAM WHERE IDSP = {id}");
                db.get($"UPDATE KhachHang SET IsActive = 1 WHERE IDKH = {id};");
                // Trả về thông báo thành công
                return Json(new { success = true, message = "Mở khóa người dùng thành công!" });
            }
            catch (Exception)
            {
                // Trả về thông báo lỗi
                return Json(new { success = false, message = "Không mở khóa tài khoản, vui lòng thử lại sau!" });
            }
        }

        //Cập nhật user
        public ActionResult SelectToUpdateUser(string id)
        {
            DataModel db = new DataModel();
            ViewBag.list = db.get($"SELECT * FROM KHACHHANG WHERE IDKH = {id}");
            ViewBag.listRole = db.get("SELECT * FROM Roles");
            if (ViewBag.list == null || ViewBag.list.Count == 0) // Kiểm tra ViewBag.list
            {
                return HttpNotFound();
            }
            return PartialView("_SelectToUpdateUser");
        }
        [HttpPost]
        public ActionResult UpdateUser(string id, string Password, string idrole, string name, HttpPostedFileBase image, string email, string diachi)
        {
            DataModel db = new DataModel();

            // Lấy thông tin sản phẩm hiện tại từ CSDL
            ViewBag.list = db.get($"SELECT * FROM KHACHHANG WHERE IDKH = {id}");
            ViewBag.listRole = db.get("SELECT * FROM Roles");
            if (ViewBag.list == null || ViewBag.list.Count == 0)
            {
                return HttpNotFound(); // Không tìm thấy sản phẩm
            }

            // Nếu input để trống, giữ giá trị cũ
            string newPassword = string.IsNullOrEmpty(Password) ? ViewBag.list[0][1].ToString() : Password;
            string newIdrole = string.IsNullOrEmpty(idrole) ? ViewBag.list[0][7].ToString() : idrole;
            string newName = string.IsNullOrEmpty(name) ? ViewBag.list[0][2].ToString() : name;
            string newEmail = string.IsNullOrEmpty(email) ? ViewBag.list[0][3].ToString() : email;
            string newDiachi = string.IsNullOrEmpty(diachi) ? ViewBag.list[0][5].ToString() : diachi;
            string newImage = ViewBag.list[0][6].ToString(); // Lấy ảnh cũ mặc định

            try
            {
                // Nếu có ảnh mới, lưu ảnh và cập nhật tên file ảnh
                if (image != null && image.ContentLength > 0)
                {
                    string filename = Path.GetFileName(image.FileName);
                    string path = Path.Combine(Server.MapPath("~/images"), filename);
                    image.SaveAs(path);
                    newImage = filename; // Cập nhật ảnh mới
                }

                // Thực hiện cập nhật sản phẩm
                string query = $"EXEC UpdateUser {id}, {newIdrole}, '{newPassword}', N'{newName}', '{newEmail}', N'{newDiachi}', '{newImage}';";
                // Cập nhật lại Session
                Session["TenKH"] = newName;
                Session["AvatarKH"] = newImage;
                db.get(query);
            }
            catch(Exception ex) 
            {
                Session["Message"] = ex.Message;
            }

            return Redirect(Request.UrlReferrer.ToString());
        }
    }
}