using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace trac_nghiem_project.Common
{
    public class HasRoleAttribute:AuthorizeAttribute
    {
        public string RoleID { get; set; }

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            var session = (LoginSession)HttpContext.Current.Session["login"];
            if (session == null) return false;

            if (RoleID.Contains(session.id_right.ToString()))
            {
                return true;
            }

            return false;
        }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary(new { controller = "UserSession", action = "Login" ,area=""})
                );
        }
    }
}