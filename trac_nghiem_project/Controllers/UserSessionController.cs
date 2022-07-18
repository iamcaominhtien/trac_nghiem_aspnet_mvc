using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using trac_nghiem_project.Common;
using trac_nghiem_project.Models;

namespace trac_nghiem_project.Controllers
{
    public class UserSessionController : Controller
    {
        private trac_nghiemEntities db = new trac_nghiemEntities();

        // GET: UserSession
        public ActionResult Logout()
        {
            Session.Abandon();
            if (Request.Cookies["cookies"] != null)
            {
                HttpCookie myCookie = new HttpCookie("cookies");
                myCookie.Expires = DateTime.Now.AddDays(-1d);
                Response.Cookies.Add(myCookie);
            }
            return RedirectToAction("Login");
        }


        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(FormCollection form)
        {
            var login = new LoginSession();
            login.username_or_email = form["username_or_email"].ToString();
            login.password = form["password"].ToString();

            //Check empty
            if (login.username_or_email=="" && login.password=="")
            {
                ModelState.AddModelError("username_or_email", "Không được để trống");
                ModelState.AddModelError("password", "Không được để trống");
                return View(login);
            }    
            else if (login.username_or_email == "")
            {
                ModelState.AddModelError("username_or_email", "Không được để trống");
                return View(login);
            }
            else if (login.password == "")
            {
                ModelState.AddModelError("password", "Không được để trống");
                return View(login);
            }

            //Check username_or_email
            var query = db.users.Where(s => s.username == login.username_or_email || s.email == login.username_or_email);
            if (!query.Any())
            {
                ModelState.AddModelError("username_or_email", "Tên đăng nhập hoặc email không tồn tại");
                return View(login);
            }

            //Check password

            var query_2 = query.Where(s => s.password == login.password).ToList();
            if (!query_2.Any())
            {
                ModelState.AddModelError("password", "Mật khẩu không đúng");
                return View(login);
            }

            login.name_of_user = query_2[0].name;
            login.id_user = query_2[0].id_user;
            login.id_right = query_2[0].id_right;
            Session["login"] = login;
            HttpCookie ck = new HttpCookie("cookies");
            ck["name"] = query_2[0].name;
            Response.Cookies.Add(ck);
            Session.Timeout = 120;
            try
            {
                if (Convert.ToInt16(form["RememberMe"].ToString()) == 1)
                {
                    Session.Timeout = 1440;
                    ck.Expires = DateTime.Now.AddDays(3);
                }
            }
            catch
            {

            }

            if (query_2[0].id_right == 1)
            {
                //Admin
                return RedirectToAction("Index", "Home");
            }
            else if (query_2[0].id_right == 2)
            {
                return RedirectToAction("Index", "TeacherHome");
            }
            return RedirectToAction("Index", "StudentHome");
        }

        public ActionResult Register()
        {
            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name");
            return View();
        }

        [HttpPost]
        public ActionResult Register([Bind(Include = "name_of_user, username_or_email, username, email, password, retype_password, gender, id_grade, avatar, birthday, id_right")] LoginSession user)
        {
            if (ModelState.IsValid)
            {
                var query_1=db.users.Where(s=>s.username==user.username);
                if (query_1.Any())
                {
                    ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name");
                    ModelState.AddModelError("username", "UserName đã tồn tại");
                    return View(user);
                }

                var query_2=db.users.Where(s=>s.email==user.email);
                if (query_2.Any())
                {
                    ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name");
                    ModelState.AddModelError("email", "Email đã được đăng kí");
                    return View(user);
                }
            }

            var addUser = new user();
            addUser.name = user.name_of_user;
            addUser.avatar = user.avatar;
            addUser.email = user.email;
            addUser.username = user.username;
            addUser.password = user.password;
            addUser.id_grade = user.id_grade;
            addUser.id_right = 3;
            addUser.birthday = user.birthday;
            addUser.date_create = DateTime.Now;
            try
            {
                db.users.Add(addUser);
                db.SaveChanges();
            }
            catch
            {
                ModelState.AddModelError("", "Đăng kí không thành công, vui lòng thử lại sau");
                ModelState.AddModelError("email", "Email đã được đăng kí");
                return View(user);
            }

            return RedirectToAction("Login");
        }
    }
}