using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using trac_nghiem_project.Common;
using trac_nghiem_project.Controllers;

namespace trac_nghiem_project.Areas.admin.Controllers
{
    [RouteArea("admin",AreaPrefix ="quan-tri-vien")]
    public class HomeController : ManagersController
    {
        [Route("quan-li-he-thong", Order = 0)]
        [Route("", Order = 1)]
        [HasRole(RoleID = "1")]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}