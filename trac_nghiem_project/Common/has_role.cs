using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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
    }
}