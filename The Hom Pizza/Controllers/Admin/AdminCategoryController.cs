using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Web;
using System.Web.Mvc;
using System.Xml.Linq;
using The_Hom_Pizza.Filters;
using The_Hom_Pizza.Models;
using static System.Net.WebRequestMethods;

namespace The_Hom_Pizza.Controllers.Admin
{
    [AuthorizeRole(AllowedRoles = "1")] // Chỉ Admin có thể truy cập
    public class AdminCategoryController : Controller
    {
        // GET: AdminCategory
        public ActionResult Index()
        {
            DataModel db = new DataModel();
            ViewBag.list = db.get("SELECT * FROM LOAISP Where IsActive = 1");
            ViewBag.list2 = db.get("SELECT * FROM SIZESP Where IsActive = 1");
            ViewBag.list3 = db.get("SELECT lp.IDPizza, sz.TenSize, lp.TenDeBanh, sz.PhuThuSize, lp.PhuThuDeBanh, sz.IDSize FROM LoaiPizza AS lp INNER JOIN SizeSP AS sz ON lp.IDSize = sz.IDSize WHERE lp.IsActive = 1;");
            return View();
        }
        //Thêm loại sp
        [HttpPost]
        public ActionResult AddCategory(string name, HttpPostedFileBase image)
        {
            DataModel db = new DataModel();
            try
            {
                if (image != null && image.ContentLength > 0)
                {
                    string filename = Path.GetFileName(image.FileName);
                    string path = Path.Combine(Server.MapPath("~/images"), filename);
                    image.SaveAs(path);
                    db.get("EXEC THEMLOAISP N'" + name + "','" + image.FileName + "';");
                }
            }
            catch (Exception) { }
            
            return Redirect(Request.UrlReferrer.ToString());
        }

        //Xóa loại sp
        [HttpPost]
        public ActionResult RemoveCategory(string id)
        {
            DataModel db = new DataModel();           
            try
            {
                // Thực hiện xóa trong CSDL
                db.get($"UPDATE LoaiSP SET IsActive = 0 WHERE IDLoaiSP = {id}");

                // Trả về thông báo thành công
                return Json(new { success = true, message = "Xóa loại sản phẩm thành công!" });
            }
            catch (Exception)
            {
                // Trả về thông báo lỗi
                return Json(new { success = false, message = "Vui lòng kiểm tra lại các dữ liệu liên quan đến loại sản phẩm này trước khi xóa!" });
            }
        }

        //Cập nhật loại sp
        public ActionResult SelectToUpdate(string id)
        {
            DataModel db = new DataModel();
            ViewBag.list = db.get($"SELECT * FROM LoaiSP WHERE IDLoaiSP = {id}");
            if (ViewBag.list == null || ViewBag.list.Count == 0) // Kiểm tra ViewBag.list
            {
                return HttpNotFound();
            }
            return PartialView("_SelectToUpdate");
        }
        [HttpPost]
        public ActionResult UpdateCategory(string id, string name, HttpPostedFileBase image)
        {
            DataModel db = new DataModel();
            // Lấy thông tin size hiện tại từ CSDL
            ViewBag.list = db.get($"SELECT * FROM LoaiSP WHERE IDLoaiSP = {id}");
            if (ViewBag.list == null || ViewBag.list.Count == 0)
            {
                return HttpNotFound(); // Không tìm thấy size
            }
            // Nếu input để trống, giữ giá trị cũ
            string newName = string.IsNullOrEmpty(name) ? ViewBag.list[0][1].ToString() : name;
            string newImage = ViewBag.list[0][3].ToString(); // Lấy ảnh cũ mặc định
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
                string query = $"UPDATE LoaiSP SET TenLoaiSP = N'{newName}', Images = '{newImage}' WHERE IDLoaiSP = {id}";
                db.get(query);
            }
            catch (Exception) { }
            return Redirect(Request.UrlReferrer.ToString());
        }

        //Size
        //Thêm size sp
        [HttpPost]
        public ActionResult AddSize(string name, string price)
        {
            DataModel db = new DataModel();
            db.get($"INSERT INTO SizeSP (TenSize, PhuThuSize) VALUES (N'{name}', {price})");
            return Redirect(Request.UrlReferrer.ToString());
        }

        //Xóa size sp
        [HttpPost]
        public ActionResult RemoveSize(string id)
        {
            DataModel db = new DataModel();
            try
            {
                // Thực hiện xóa trong CSDL
                db.get($"UPDATE SizeSP SET IsActive = 0 WHERE IDSize = {id}");

                // Trả về thông báo thành công
                return Json(new { success = true, message = "Xóa size thành công!" });
            }
            catch (Exception)
            {
                // Trả về thông báo lỗi
                return Json(new { success = false, message = "Vui lòng kiểm tra lại các dữ liệu liên quan đến size này trước khi xóa!" });
            }
        }

        //Cập nhật size sp
        public ActionResult SelectToUpdateSize(string id)
        {
            DataModel db = new DataModel();
            ViewBag.list = db.get($"SELECT * FROM SizeSP WHERE IDSize = {id}");
            if (ViewBag.list == null || ViewBag.list.Count == 0) // Kiểm tra ViewBag.list
            {
                return HttpNotFound();
            }
            return PartialView("_SelectToUpdateSize");
        }
        [HttpPost]
        public ActionResult UpdateSize(string id, string name, string price)
        {
            DataModel db = new DataModel();
            // Lấy thông tin size hiện tại từ CSDL
            ViewBag.list = db.get($"SELECT TenSize, PhuThuSize FROM SizeSP WHERE IDSize = {id}");
            if (ViewBag.list == null || ViewBag.list.Count == 0)
            {
                return HttpNotFound(); // Không tìm thấy size
            }

            // Nếu input để trống, giữ giá trị cũ
            string newName = string.IsNullOrEmpty(name) ? ViewBag.list[0][0].ToString() : name;
            string newPrice = string.IsNullOrEmpty(price) ? ViewBag.list[0][1].ToString() : price;

            // Thực hiện cập nhật
            db.get($"UPDATE SizeSP SET TenSize = N'{newName}', PhuThuSize = {newPrice} WHERE IDSize = {id}");
            return Redirect(Request.UrlReferrer.ToString());
        }

        //Crust
        //Thêm crust pizza
        [HttpPost]
        public ActionResult AddLoaiPizza(string idsize, string name, string price)
        {
            DataModel db = new DataModel();
            db.get($"INSERT INTO LoaiPizza (IDSize, TenDeBanh, PhuThuDeBanh) VALUES ({idsize}, N'{name}', {price})");
            return Redirect(Request.UrlReferrer.ToString());
        }

        //Xóa crust pizza
        [HttpPost]
        public ActionResult RemoveLoaiPizza(string id)
        {
            DataModel db = new DataModel();
            try
            {
                // Thực hiện xóa trong CSDL
                db.get($"UPDATE LoaiPizza SET IsActive = 0 WHERE IDPizza = {id}");

                // Trả về thông báo thành công
                return Json(new { success = true, message = "Xóa đế bánh thành công!" });
            }
            catch (Exception)
            {
                // Trả về thông báo lỗi
                return Json(new { success = false, message = "Vui lòng kiểm tra lại các dữ liệu liên quan đến đế bánh này trước khi xóa!" });
            }
        }

        //Cập nhật crust pizza
        public ActionResult SelectToUpdateLoaiPizza(string id)
        {
            DataModel db = new DataModel();
            ViewBag.list = db.get($"SELECT * FROM LoaiPizza WHERE IDPizza = {id}");
            ViewBag.list2 = db.get("SELECT * FROM SIZESP Where IsActive = 1");
            if (ViewBag.list == null || ViewBag.list.Count == 0) // Kiểm tra ViewBag.list
            {
                return HttpNotFound();
            }
            return PartialView("_SelectToUpdateLoaiPizza");
        }
        [HttpPost]
        public ActionResult UpdateLoaiPizza(string id, string idsize, string name, string price)
        {
            DataModel db = new DataModel();
            //Lấy thông tin size hiện tại từ CSDL
            ViewBag.list = db.get($"SELECT * FROM LoaiPizza WHERE IDPizza = {id}");
            ViewBag.list2 = db.get("SELECT * FROM SIZESP Where IsActive = 1");
            if (ViewBag.list == null || ViewBag.list.Count == 0)
            {
                return HttpNotFound(); // Không tìm thấy size
            }

            //Nếu input để trống, giữ giá trị cũ
            string newIdzsize = string.IsNullOrEmpty(idsize) ? ViewBag.list[0][1].ToString() : idsize;
            string newName = string.IsNullOrEmpty(name) ? ViewBag.list[0][2].ToString() : name;
            string newPrice = string.IsNullOrEmpty(price) ? ViewBag.list[0][3].ToString() : price;

            //Thực hiện cập nhật
            db.get($"UPDATE LoaiPizza SET IDSize = {newIdzsize}, TenDeBanh = N'{newName}', PhuThuDeBanh = '{newPrice}' WHERE IDPizza = {id}");
            return Redirect(Request.UrlReferrer.ToString());
        }
    }
}