using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using trac_nghiem_project.Common;
using trac_nghiem_project.Models;

namespace trac_nghiem_project.Controllers
{
    [RoutePrefix("quan-li-phien")]
    public class UserSessionController : Controller
    {
        private trac_nghiem_aspEntities db = new trac_nghiem_aspEntities();

        public ActionResult RedirectToLogin()
        {
            return RedirectToAction("Login");
        }

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

        [Route("dang-nhap")]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [Route("dang-nhap")]
        public ActionResult Login(FormCollection form)
        {
            var login = new LoginSession();
            login.username_or_email = form["username_or_email"].ToString();
            login.password = LoginSession.MD5Hash(form["password"].ToString());
            var rememberMe = false;
            try
            {
                if (!String.IsNullOrEmpty(form["RememberMe"]))
                    rememberMe = Convert.ToInt16(form["RememberMe"].ToString()) == 1;
                else rememberMe = false;
            }
            catch
            {
                rememberMe = false;
            }

            //Check empty
            if (String.IsNullOrEmpty(login.username_or_email) && String.IsNullOrEmpty(login.password))
            {
                ModelState.AddModelError("username_or_email", "Không được để trống");
                ModelState.AddModelError("password", "Không được để trống");
                return View(login);
            }    
            else if (String.IsNullOrEmpty(login.username_or_email))
            {
                ModelState.AddModelError("username_or_email", "Không được để trống");
                return View(login);
            }
            else if (String.IsNullOrEmpty(login.password))
            {
                ModelState.AddModelError("password", "Không được để trống");
                return View(login);
            }

            //Check admin
            var query_admin = db.managers.Where(s => s.username == login.username_or_email || s.email == login.username_or_email);
            if (!query_admin.Any())
            {
                //check teacher
                var query_teacher = db.teachers_user.Where(s => s.username == login.username_or_email || s.email == login.username_or_email);
                if (!query_teacher.Any())
                {
                    //check student
                    var query_student = db.students_user.Where(s => s.username == login.username_or_email || s.email == login.username_or_email);
                    if (!query_student.Any())
                    {
                        ModelState.AddModelError("username_or_email", "Tên đăng nhập hoặc email không tồn tại");
                        return View(login);
                    }
                    else
                    {
                        var query_student_pass = query_student.Where(s => s.password == login.password).ToList();
                        if (!query_student_pass.Any())
                        {
                            ModelState.AddModelError("password", "Mật khẩu không đúng");
                            return View(login);
                        }
                        else
                        {
                            saveSession(query_student_pass, rememberMe);
                            return RedirectToAction("Index", "StudentHome");
                        }
                    }
                }
                else
                {
                    var query_teacher_pass = query_teacher.Where(s => s.password == login.password).ToList();
                    if (!query_teacher_pass.Any())
                    {
                        ModelState.AddModelError("password", "Mật khẩu không đúng");
                        return View(login);
                    }
                    else
                    {
                        saveSession(query_teacher_pass, rememberMe);
                        return RedirectToAction("Index", "TeacherHome", new { area = "teacher" });
                    }
                }
            }
            else
            {
                var query_admin_pass = query_admin.Where(s => s.password == login.password).ToList();
                if (!query_admin_pass.Any())
                {
                    ModelState.AddModelError("password", "Mật khẩu không đúng");
                    return View(login);
                }
                else
                {
                    saveSession(query_admin_pass, rememberMe);
                    return RedirectToAction("Index", "Home", new { area = "admin" });
                }
            }
        }

        void saveSession(dynamic query, bool rememberMe)
        {
            var login = new LoginSession();
            login.name_of_user = query[0].name;
            login.id_right = query[0].id_right;
            if (login.id_right==1)
                login.id_user = query[0].id_manager;
            else if (login.id_right==2)
                login.id_user = query[0].id_teacher;
            else login.id_user = query[0].id_user;
            Session["login"] = login;
            HttpCookie ck = new HttpCookie("cookies");
            ck["name"] = query[0].name;
            Response.Cookies.Add(ck);
            Session.Timeout = 120;
            try
            {
                if (rememberMe)
                {
                    Session.Timeout = 1440;
                    ck.Expires = DateTime.Now.AddDays(3);
                }
            }
            catch
            {

            }
        }

        [Route("dang-ki")]
        public ActionResult Register()
        {
            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name");
            return View();
        }

        [HttpPost]
        [Route("dang-ki")]
        public ActionResult Register([Bind(Include = "name_of_user, username_or_email, username, email, password, retype_password, gender, id_grade, avatar, birthday, id_right")] LoginSession user)
        {
            if (ModelState.IsValid)
            {
                var query_1=db.students_user.Where(s=>s.username==user.username);
                if (query_1.Any())
                {
                    ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name");
                    ModelState.AddModelError("username", "UserName đã tồn tại");
                    return View(user);
                }

                var query_2=db.students_user.Where(s=>s.email==user.email);
                if (query_2.Any())
                {
                    ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name");
                    ModelState.AddModelError("email", "Email đã được đăng kí");
                    return View(user);
                }
            }

            var addUser = new students_user();
            addUser.name = user.name_of_user;
            addUser.avatar = user.avatar;
            addUser.email = user.email;
            addUser.username = user.username;
            addUser.password = LoginSession.MD5Hash(user.password);
            addUser.id_grade = user.id_grade;
            addUser.id_right = 3;
            addUser.birthday = user.birthday;
            addUser.date_create = DateTime.Now;
            try
            {
                db.students_user.Add(addUser);
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