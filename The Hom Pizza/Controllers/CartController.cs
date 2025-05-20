using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Controllers
{
    public class CartController : BaseController
    {
        //Thêm sản phẩm vào giỏ hàng
        [HttpPost]
        public ActionResult AddToCart(int idsp, int quantity, int idpizza, string note)
        {
            // Kiểm tra người dùng đã đăng nhập
            if (Session["UserID"] != null)
            {
                string userId = Session["UserID"].ToString();
                if (quantity <= 0) { quantity = 1; }
                if (idpizza == 0)
                {
                    // Thêm vào giỏ hàng trong DB
                    db.get("EXEC sp_ThemGioHang '" + userId + "', '" + idsp + "', '" + quantity + "', N'" + note + "';");
                }
                else
                {
                    // Thêm vào giỏ hàng trong DB
                    db.get("EXEC sp_ThemGioHang2 '" + userId + "', '" + idsp + "', '" + idpizza + "','" + quantity + "', N'" + note + "';");
                }
            }
            else
            {
                // Lưu sản phẩm vào session nếu chưa đăng nhập
                List<CartItem> cartItems = new List<CartItem>();

                if (Session["CartItems"] != null)
                {
                    cartItems = (List<CartItem>)Session["CartItems"];
                }
                if (idpizza == 0)
                {
                    var existingItem = cartItems.FirstOrDefault(x => x.ProductID == idsp && x.Note == note);
                    if (existingItem != null)
                    {
                        existingItem.Quantity += quantity;
                    }
                    else
                    {
                        var product = db.get("SELECT TenSP, HinhSP, Price FROM SanPham WHERE IDSP = " + idsp);
                        if (product != null && product.Count > 0)
                        {
                            var row = product[0] as ArrayList;
                            cartItems.Add(new CartItem
                            {
                                ProductID = idsp,
                                ProductName = row[0].ToString(),
                                Image = row[1].ToString(),
                                Price = Convert.ToInt32(row[2]),
                                PizzaID = idpizza,
                                Quantity = quantity,
                                Note = note,
                            });
                        }
                    }
                }
                else
                {
                    var existingItem = cartItems.FirstOrDefault(x => x.ProductID == idsp && x.PizzaID == idpizza && x.Note == note);
                    if (existingItem != null)
                    {
                        existingItem.Quantity += quantity;
                    }
                    else
                    {
                        var product = db.get("EXEC sp_GetCartItems2 '" + idsp + "', '" + idpizza + "';");
                        if (product != null && product.Count > 0)
                        {
                            var row = product[0] as ArrayList;
                            cartItems.Add(new CartItem
                            {
                                ProductID = idsp,
                                ProductName = row[0].ToString(),
                                Image = row[1].ToString(),
                                Price = Convert.ToInt32(row[2]),
                                PizzaID = idpizza,
                                Quantity = quantity,
                                Note = note,
                                TenSize = row[4].ToString(),
                                PhuThuSize = Convert.ToInt32(row[5]),
                                TenDeBanh = row[6].ToString(),
                                PhuThuDeBanh = Convert.ToInt32(row[7]),
                            });
                        }
                    }
                }

                Session["CartItems"] = cartItems; // Cập nhật lại session
            }
            return Json(new { success = true, message = "Sản phẩm đã được thêm vào giỏ hàng!" });
        }

        //Xóa sản phẩm trong giỏ hàng
        [HttpPost]
        public JsonResult RemoveFromCart(int idsp, int? idpizza, string note)
        {

            try
            {
                if (Session["UserID"] != null)
                {
                    string userid = Session["UserID"].ToString();
                    if (!idpizza.HasValue)
                    {
                        db.get($"DELETE FROM GioHang WHERE IDKH = {userid} AND IDSP = {idsp} AND Note = N'{note}';");
                    }
                    else
                    {
                        db.get($"DELETE FROM GioHang WHERE IDKH = {userid} AND IDSP = {idsp} AND IDPizza = {idpizza} AND Note = N'{note}';");
                    }  
                }
                else
                {
                    List<CartItem> cartItems = (List<CartItem>)Session["CartItems"] ?? new List<CartItem>();
                    var itemToRemove = cartItems.FirstOrDefault(x => x.ProductID == idsp && x.PizzaID == idpizza && x.Note == note);
                    if (itemToRemove != null)
                    {
                        cartItems.Remove(itemToRemove);
                    }

                    Session["CartItems"] = cartItems;
                }

                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Có lỗi xảy ra: " + ex.Message });
            }
        }

        [HttpPost]
        public JsonResult UpdateCart(int idsp, int quanlity, int? idpizza, string note)
        {
            try
            {
                if (Session["UserID"] != null)
                {
                    string userId = Session["UserID"].ToString();
                    if (quanlity > 0)
                    {
                        if (!idpizza.HasValue)
                            db.get($"UPDATE GioHang SET SoLuong = {quanlity} WHERE IDKH = {userId} AND IDSP = {idsp} AND Note = N'{note}';");
                        else
                            db.get($"UPDATE GioHang SET SoLuong = {quanlity} WHERE IDKH = {userId} AND IDSP = {idsp} AND IDPizza = {idpizza} AND Note = N'{note}';");
                    }
                }
                else
                {
                    List<CartItem> cartItems = (List<CartItem>)Session["CartItems"] ?? new List<CartItem>();
                    var itemToUpdate = cartItems.FirstOrDefault(x => x.ProductID == idsp && x.PizzaID == idpizza && x.Note == note);
                    if (itemToUpdate != null)
                        itemToUpdate.Quantity = quanlity;

                    Session["CartItems"] = cartItems;
                }

                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }


        public ActionResult Cart()
        {
            return View();
        }
    }
}