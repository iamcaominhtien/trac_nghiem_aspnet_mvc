﻿using System;
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
        private trac_nghiemEntities db = new trac_nghiemEntities();

        // GET: Admins
        [Route("danh-sach",Order = 0)]
        [Route("",Order=1)]
        public ActionResult Index()
        {
            var users = db.users.Include(u => u.grade).Include(u => u.right).Where(s=>s.id_right==1);
            return View(users.ToList());
        }

        // GET: Admins/Details/5
        [Route("chi-tiet-quan-tri-vien/{id}")]
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            user user = db.users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: Admins/Create
        [Route("them-quan-tri-vien")]
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
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_user,username,name,password,email,avatar,gender,birthday,date_create,id_right,id_grade")] user user)
        {
            if (ModelState.IsValid)
            {
                user.date_create = DateTime.Now;
                user.id_right = 1;
                db.users.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name", user.id_grade);
            ViewBag.id_right = new SelectList(db.rights, "id_right", "name", user.id_right);
            return View(user);
        }

        // GET: Admins/Edit/5
        [Route("cap-nhat-quan-tri-vien/{id}")]
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            user user = db.users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }

            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name", user.id_grade);
            ViewBag.id_right = new SelectList(db.rights, "id_right", "name", user.id_right);
            return View(user);
        }

        // POST: Admins/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("cap-nhat-quan-tri-vien/{id}")]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_user,username,name,password,email,avatar,gender,birthday,date_create,id_right,id_grade")] user user)
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

        // GET: Admins/Delete/5
        [Route("xoa-quan-tri-vien/{id}")]
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            user user = db.users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Admins/Delete/5
        [HttpPost, ActionName("Delete")]
        [Route("xoa-quan-tri-vien/{id}")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            user user = db.users.Find(id);
            db.users.Remove(user);
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