using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Security.Policy;
using System.Text;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Xml.Linq;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Controllers
{
    public class HomeController : BaseController
    {
        //Trang khi không đúng role sẽ hiển thị 
        public ActionResult Unauthorized()
        {
            return View();
        }
        //Trang chủ
        public ActionResult Index()
        {
            ViewBag.list1 = db.get("SELECT TOP 8 * FROM SanPham Where IsActive = 1 ORDER BY IDSP");
            ViewBag.list2 = db.get("SELECT * FROM LoaiSP Where IsActive = 1");
            // Xử lý hiện món theo loại sp
            var productList = new Dictionary<string, List<dynamic>>();
            foreach (var category in ViewBag.list2)
            {
                string categoryId = category[0].ToString();
                var products = db.get($"SELECT TOP 4 * FROM SANPHAM WHERE IDLoaiSP = {categoryId} AND IsActive = 1");
                productList[categoryId] = products.Cast<dynamic>().ToList();
            }
            ViewBag.ProductList = productList;
            return View();
        }

        //Trang hồ sơ người dùng
        public ActionResult ProfileUser()
        {
            ViewBag.list = db.get($"SELECT * FROM KhachHang WHERE IDKH = {ViewBag.UserID}");
            return View();
        }   

        //Trang phân loại sản phẩm
        public ActionResult Shop(string id,  string tensp)
        {
            // Truy vấn SQL bắt buộc phải có IDLoaiSP ngay từ đầu
            string query = $"SELECT * FROM SANPHAM WHERE IsActive = 1";

            // Danh sách điều kiện lọc
            List<string> conditions = new List<string>();

            // Lọc theo ID loại sản phẩm nếu có
            if (!string.IsNullOrEmpty(id))
            {
                conditions.Add($"IDLoaiSP = {id}");
                ViewBag.list3 = db.get($"SELECT TenLoaiSP, IDLoaiSP FROM LoaiSP WHERE IDLoaiSP = {id} AND IsActive = 1");
            }
            // Lọc nếu không có idloaisp
            else
            {
                ViewBag.list3 = "Kết quả tìm kiếm";
            }

            // Lọc theo tên sản phẩm nếu có
            if (!string.IsNullOrEmpty(tensp))
            {
                conditions.Add($"TenSP LIKE N'%{tensp}%'");
            }

            // Nếu có điều kiện lọc khác, thêm vào câu SQL
            if (conditions.Count > 0)
            {
                query += " AND " + string.Join(" AND ", conditions);
            }

            ViewBag.list = db.get(query);
            return View();
        }


        //View modal đặt hàng cũng như xem chi tiết sản phẩm
        public ActionResult GetProductDetails(string id, string size, string total)
        {
            ViewBag.list = db.get($"SELECT * FROM SANPHAM WHERE IDSP = {id} AND IsActive = 1");

            if (ViewBag.list == null || ViewBag.list.Count == 0) // Kiểm tra ViewBag.list
            {
                return HttpNotFound();
            }

            // Lấy IDLoaiSP
            int idLoaiSP = Convert.ToInt32(ViewBag.list[0][1]); //IDLoaiSP ở cột thứ 2 (index 1)

            ViewBag.IsPizza = IsPizza(idLoaiSP); // Kiểm tra xem có phải pizza hay không

            if (ViewBag.IsPizza) // Chỉ lấy size và loại bánh nếu là pizza
            {
                ViewBag.list2 = db.get("SELECT DISTINCT * FROM SizeSP Where IsActive = 1 ORDER BY PhuThuSize ASC;");
                //Lấy id size
                int selectedSize = 1;
                if (!string.IsNullOrEmpty(size) && int.TryParse(size, out int parsedSize))
                {
                    selectedSize = parsedSize;
                }
                ViewBag.list3 = db.get($"SELECT IDPizza, TenDeBanh, PhuThuDeBanh, IDSize FROM LoaiPizza Where IDSize = {selectedSize} AND IsActive = 1 ORDER BY PhuThuDeBanh ASC;");
                ViewBag.Total = Convert.ToInt32(total);
            }
            return PartialView("_ProductDetails");
        }

        // Hàm kiểm tra xem IDLoaiSP có phải là pizza hay không
        private bool IsPizza(int idLoaiSP)
        {
            int idloai = 0;
            ArrayList result = db.get($"SELECT * FROM LoaiSP WHERE IDLoaiSP = {idLoaiSP} AND TenLoaiSP LIKE '%Pizza%' AND IsActive = 1");
            if (result.Count > 0)
            {
                var Row = result[0] as ArrayList;
                if (Row != null && Row.Count > 0)
                {
                    idloai = Convert.ToInt32(Row[0]);
                }
            }
            return idLoaiSP == idloai;
        }
             
    }
}