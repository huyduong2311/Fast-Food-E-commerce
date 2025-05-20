using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Reflection;
using System.Web;
using The_Hom_Pizza.Models;

namespace The_Hom_Pizza.Models
{
    public class CartItem
    {
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public string Image { get; set; }
        public int Price { get; set; }
        public int? PizzaID { get; set; }
        public int Quantity { get; set; }
        public string Note { get; set; }
        public int TotalPrice
        {
            get
            {
                return Price * Quantity;
            }
        }
        public string TenSize { get; set; }
        public int PhuThuSize { get; set; }
        public string TenDeBanh { get; set; }
        public int PhuThuDeBanh { get; set; }
        public int TotalPhuThu
        {
            get
            {
                return PhuThuSize + PhuThuDeBanh;
            }
        }
        public int GrandTotal
        {
            get
            {
                return (TotalPhuThu + Price) * Quantity;
            }
        }
    }
}