using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using trac_nghiem_project.Common;
using trac_nghiem_project.Controllers;
using trac_nghiem_project.Models;

namespace trac_nghiem_project.Areas.admin.Controllers
{
    [RouteArea("admin", AreaPrefix = "quan-tri-vien")]
    [RoutePrefix("quan-li-sinh-vien")]
    public class StudentsController : ManagersController
    {
        private trac_nghiem_aspEntities db = new trac_nghiem_aspEntities();

        // GET: Students
        [Route("danh-sach-sinh-vien", Order = 0)]
        [Route("", Order = 1)]
        public ActionResult Index()
        {
            var users = db.students_user.Include(u => u.grade).Include(u => u.right);
            return View(users.ToList());
        }

        // GET: Students/Details/5
        [Route("chi-tiet-sinh-vien/{id}")]
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            students_user user = db.students_user.Find(id);
            var l_field = from u in db.students_user
                            join g in db.grades on u.id_grade equals g.id_grade
                          join f in db.fields
                          on g.id_field equals f.id_field
                          where u.id_user == id
                          select new
                          {
                              name = f.name
                          };
            ViewBag.field = "Unknown";
            try
            {
                ViewBag.field = l_field.ToArray()[0].name;
            }
            catch
            {
                ViewBag.field = "Unknown";
            }
            //var search1 = db.users.Find(id).id_grade;
            //var search2 = db.grades.Find(search1).id_field;
            //ViewBag.field = db.fields.Find(search2).name;

            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: Students/Create
        [Route("them-sinh-vien-moi")]
        public ActionResult Create()
        {
            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name");
            ViewBag.id_right = new SelectList(db.rights, "id_right", "name");
            return View();
        }

        // POST: Students/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("them-sinh-vien-moi")]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_user,username,name,password,email,avatar,gender,birthday,date_create,id_right,id_grade")] students_user user)
        {
            if (ModelState.IsValid)
            {
                user.date_create = DateTime.Now;
                user.id_right = 3;
                user.password = LoginSession.MD5Hash(user.password);
                db.students_user.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name", user.id_grade);
            ViewBag.id_right = new SelectList(db.rights, "id_right", "name", user.id_right);
            return View(user);
        }

        // GET: Students/Edit/5
        [Route("cap-nhat-thong-tin-sinh-vien/{id}")]
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            students_user user = db.students_user.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name", user.id_grade);
            ViewBag.id_right = new SelectList(db.rights, "id_right", "name", user.id_right);
            return View(user);
        }

        // POST: Students/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("cap-nhat-thong-tin-sinh-vien/{id}")]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_user,username,name,password,email,avatar,gender,birthday,date_create,id_right,id_grade")] students_user user)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            
            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name", user.id_grade);
            ViewBag.id_right = new SelectList(db.rights, "id_right", "name", user.id_right);
            return View(user);
        }

        // GET: Students/Delete/5
        [Route("xoa-sinh-vien/{id}")]
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            students_user user = db.students_user.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Students/Delete/5
        [HttpPost, ActionName("Delete")]
        [Route("xoa-sinh-vien/{id}")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            students_user user = db.students_user.Find(id);
            db.students_user.Remove(user);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
