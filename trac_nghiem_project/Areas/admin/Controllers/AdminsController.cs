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
    [RoutePrefix("quan-li-quan-tri-vien")]
    public class AdminsController : ManagersController
    {
        private trac_nghiem_aspEntities db = new trac_nghiem_aspEntities();

        // GET: Admins
        [Route("danh-sach",Order = 0)]
        [Route("",Order=1)]
        [HasRole(RoleID = "1")]
        public ActionResult Index()
        {
            var users = db.managers.Include(u => u.right);
            return View(users.ToList());
        }

        // GET: Admins/Details/5
        [Route("chi-tiet-quan-tri-vien/{id}")]
        [HasRole(RoleID = "1")]
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            manager user = db.managers.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: Admins/Create
        [Route("them-quan-tri-vien")]
        [HasRole(RoleID = "1")]
        public ActionResult Create()
        {
            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name");
            ViewBag.id_right = new SelectList(db.rights, "id_right", "name");
            return View();
        }

        // POST: Admins/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("them-quan-tri-vien")]
        [HasRole(RoleID = "1")]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_manager,email,username,name,id_right,password,note")] manager user)
        {
            if (ModelState.IsValid)
            {
                user.id_right = 1;
                user.password = LoginSession.MD5Hash(user.password);
                db.managers.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(user);
        }

        // GET: Admins/Edit/5
        [Route("cap-nhat-quan-tri-vien/{id}")]
        [HasRole(RoleID = "1")]
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            manager user = db.managers.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }

            return View(user);
        }

        // POST: Admins/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("cap-nhat-quan-tri-vien/{id}")]
        [HasRole(RoleID = "1")]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_manager,email,username,name,id_right,password,note")] manager user)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(user);
        }

        // GET: Admins/Delete/5
        [Route("xoa-quan-tri-vien/{id}")]
        [HasRole(RoleID = "1")]
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            manager user = db.managers.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Admins/Delete/5
        [HttpPost, ActionName("Delete")]
        [Route("xoa-quan-tri-vien/{id}")]
        [HasRole(RoleID = "1")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            manager user = db.managers.Find(id);
            db.managers.Remove(user);
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
