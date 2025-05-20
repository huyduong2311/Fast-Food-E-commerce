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
    public class AdminProductController : Controller
    {
        [AuthorizeRole(AllowedRoles = "1")] // Chỉ Admin có thể truy cập
        // GET: AdminProduct
        public ActionResult Index()
        {
            DataModel db = new DataModel();
            ViewBag.list = db.get("SELECT sp.IDSP, lsp.TenLoaiSP, sp.TenSP, sp.HinhSP, sp.MoTaSP, sp.Price, sp.TrangThai FROM SanPham sp JOIN LoaiSP lsp ON sp.IDLoaiSP = lsp.IDLoaiSP Where sp.IsActive = 1;");
            ViewBag.listLoaiSP = db.get("SELECT * FROM LOAISP Where IsActive = 1");
            return View();
        }
        //Thêm sp
        [HttpPost]
        public ActionResult AddProduct(string idcategory, string name, HttpPostedFileBase image, string des, string price, string status)
        {
            DataModel db = new DataModel();
            try
            {
                if (image != null && image.ContentLength > 0)
                {
                    string filename = Path.GetFileName(image.FileName);
                    string path = Path.Combine(Server.MapPath("~/images"), filename);
                    image.SaveAs(path);
                    db.get("EXEC THEMSP " + idcategory + ", N'" + name + "','" + image.FileName + "', N'" + des + "'," + price + ", N'" + status + "';");

                }
            }
            catch(Exception) { }
            return Redirect(Request.UrlReferrer.ToString());
        }

        //Xóa sp
        [HttpPost]
        public ActionResult RemoveProduct(string id)
        {
            DataModel db = new DataModel();
            try
            {
                // Thực hiện xóa trong CSDL
                //db.get($"DELETE FROM SANPHAM WHERE IDSP = {id}");
                db.get($"UPDATE SanPham SET IsActive = 0 WHERE IDSP = {id};");
                // Trả về thông báo thành công
                return Json(new { success = true, message = "Xóa món thành công!" });
            }
            catch (Exception)
            {
                // Trả về thông báo lỗi
                return Json(new { success = false, message = "Vui lòng kiểm tra lại các dữ liệu liên quan đến món này trước khi xóa!" });
            }
        }

        //Cập nhật sp
        public ActionResult SelectToUpdateProduct(string id)
        {
            DataModel db = new DataModel();
            ViewBag.list = db.get($"SELECT * FROM SANPHAM WHERE IDSP = {id}");
            ViewBag.listLoaiSP = db.get("SELECT * FROM LOAISP Where IsActive = 1");
            if (ViewBag.list == null || ViewBag.list.Count == 0) // Kiểm tra ViewBag.list
            {
                return HttpNotFound();
            }
            return PartialView("_SelectToUpdateProduct");
        }
        [HttpPost]
        public ActionResult UpdateProduct(string id, string idcategory, string name, string des, string price, HttpPostedFileBase image, string status)
        {
            DataModel db = new DataModel();

            // Lấy thông tin sản phẩm hiện tại từ CSDL
            ViewBag.list = db.get($"SELECT * FROM SANPHAM WHERE IDSP = {id}");
            ViewBag.listLoaiSP = db.get("SELECT * FROM LOAISP Where IsActive = 1");
            if (ViewBag.list == null || ViewBag.list.Count == 0)
            {
                return HttpNotFound(); // Không tìm thấy sản phẩm
            }

            // Nếu input để trống, giữ giá trị cũ
            string newCategory = string.IsNullOrEmpty(idcategory) ? ViewBag.list[0][1].ToString() : idcategory;
            string newName = string.IsNullOrEmpty(name) ? ViewBag.list[0][2].ToString() : name;
            string newDes = string.IsNullOrEmpty(des) ? ViewBag.list[0][4].ToString() : des;
            string newPrice = string.IsNullOrEmpty(price) ? ViewBag.list[0][5].ToString() : price;
            string newStatus = string.IsNullOrEmpty(status) ? ViewBag.list[0][7].ToString() : status;
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
                string query = $"EXEC UpdateProduct {newCategory}, N'{newName}', '{newImage}', N'{newDes}', {newPrice}, {id}, N'{newStatus}';";
                db.get(query);
            }
            catch (Exception) { }

            return Redirect(Request.UrlReferrer.ToString());
        }

    }
}