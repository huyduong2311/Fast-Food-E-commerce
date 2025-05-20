using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace The_Hom_Pizza.Filters
{
    public class AuthorizeRoleAttribute : AuthorizeAttribute
    {
        public string AllowedRoles { get; set; }

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            // Nếu người dùng chưa đăng nhập, coi họ là khách vãng lai
            if (httpContext.Session["RoleID"] == null)
            {
                httpContext.Session["RoleID"] = 2; // Gán vai trò khách vãng lai
            }

            // Lấy RoleID từ Session
            int userRoleId = Convert.ToInt32(httpContext.Session["RoleID"]);

            // Phân tách danh sách AllowedRoles
            string[] roles = AllowedRoles.Split(',');

            // Kiểm tra RoleID của người dùng có nằm trong danh sách AllowedRoles không
            foreach (string role in roles)
            {
                if (int.TryParse(role, out int roleId) && roleId == userRoleId)
                    return true;
            }

            return false; // Không có quyền
        }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            filterContext.Result = new RedirectResult("~/Home/Unauthorized");
        }
    }
}