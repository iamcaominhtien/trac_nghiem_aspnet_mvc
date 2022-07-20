using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using trac_nghiem_project.Common;

namespace trac_nghiem_project.Controllers
{
    public class ManagersController : Controller
    {

        protected override void OnActionExecuting(ActionExecutingContext filterContext) //Note: private, not public
        {
            var sess = (LoginSession)Session["LOGIN"];

            if (sess == null)
            {
                //var temp2= Request.ServerVariables["SCRIPT_NAME"].ToString();
                filterContext.Result = new RedirectToRouteResult(new
                    System.Web.Routing.RouteValueDictionary(new { controller = "UserSession", action = "Login",area="" }));
            }
            base.OnActionExecuting(filterContext);
        }

        // GET: Managers
    }
}