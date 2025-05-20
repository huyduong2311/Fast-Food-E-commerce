using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace The_Hom_Pizza
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            // Đăng ký route cho Admin
            //routes.MapRoute(
            //    name: "Admin",
            //    url: "Admin/{controller}/{action}/{id}",
            //    defaults: new { action = "Index", id = UrlParameter.Optional },
            //    namespaces: new[] { "The_Hom_Pizza.Areas.Admin.Controllers" } // Chỉ định namespace cho Admin
            //).DataTokens["area"] = "Admin";

            // Đăng ký route mặc định
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
                //namespaces: new[] { "The_Hom_Pizza.Controllers" } // Chỉ định namespace cho trang chính
            );
            routes.MapRoute(
                name: "ProductDetailsWithSize", // Đặt tên cho route
                url: "{controller}/{action}/{id}/{size}", // Thêm {size} vào URL
                defaults: new { controller = "Home", action = "GetProductDetails", id = UrlParameter.Optional, size = UrlParameter.Optional } // Thêm size vào defaults
            );
        }
    }
}
