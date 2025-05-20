using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using The_Hom_Pizza.Filters;

namespace The_Hom_Pizza.Controllers.Admin
{
    public class AdminFeedbackController : Controller
    {
        [AuthorizeRole(AllowedRoles = "1")] // Chỉ Admin có thể truy cập
        // GET: AdminFeedback
        public ActionResult Index()
        {
            return View();
        }
    }
}