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
    [RoutePrefix("quan-li-giang-vien")]
    public class TeachersController : ManagersController
    {
        private trac_nghiem_aspEntities db = new trac_nghiem_aspEntities();

        // GET: Teachers
        [Route("danh-sach-giang-vien", Order = 0)]
        [Route("", Order = 1)]
        public ActionResult Index()
        {
            var users = db.teachers_user.Include(u => u.right);
            return View(users.ToList());
        }

        // GET: Teachers/Details/5
        [Route("thong-tin-giang-vien/{id}")]
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            teachers_user user = db.teachers_user.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: Teachers/Create
        [Route("them-giang-vien-moi")]
        public ActionResult Create()
        {
            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name");
            ViewBag.id_right = new SelectList(db.rights, "id_right", "name");
            return View();
        }

        // POST: Teachers/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("them-giang-vien-moi")]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_teacher,username,name,password,email,phone,avatar,gender,birthday,date_create,id_right")] teachers_user user)
        {
            if (ModelState.IsValid)
            {
                user.date_create = DateTime.Now;
                user.password= LoginSession.MD5Hash(user.password);
                user.id_right = 2;
                db.teachers_user.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_right = new SelectList(db.rights, "id_right", "name", user.id_right);
            return View(user);
        }

        // GET: Teachers/Edit/5
        [Route("cap-nhat-thong-tin-giang-vien/{id}")]
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            teachers_user user = db.teachers_user.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }

            ViewBag.id_right = new SelectList(db.rights, "id_right", "name", user.id_right);
            return View(user);
        }

        // POST: Teachers/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("cap-nhat-thong-tin-giang-vien/{id}")]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_teacher,username,name,password,email,phone,avatar,gender,birthday,date_create,id_right")] teachers_user user)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_right = new SelectList(db.rights, "id_right", "name", user.id_right);
            return View(user);
        }

        // GET: Teachers/Delete/5
        [Route("xoa-giang-vien/{id}")]
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            teachers_user user = db.teachers_user.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Teachers/Delete/5
        [HttpPost, ActionName("Delete")]
        [Route("xoa-giang-vien/{id}")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            teachers_user user = db.teachers_user.Find(id);
            db.teachers_user.Remove(user);
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
