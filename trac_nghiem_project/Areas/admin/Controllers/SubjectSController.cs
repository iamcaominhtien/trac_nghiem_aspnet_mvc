﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using trac_nghiem_project.Models;

namespace trac_nghiem_project.Areas.admin.Controllers
{
    [RouteArea("admin", AreaPrefix = "quan-tri-vien")]
    [RoutePrefix("quan-li-mon-hoc")]
    public class SubjectSController : Controller
    {
        private trac_nghiemEntities db = new trac_nghiemEntities();

        // GET: SubjectS
        [Route("danh-sach-mon-hoc", Order = 1)]
        [Route("", Order = 1)]
        public ActionResult Index()
        {
            return View(db.subjects.ToList());
        }

        // GET: SubjectS/Details/5
        [Route("thong-tin-mon-hoc/{id}")]
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            subject subject = db.subjects.Find(id);
            if (subject == null)
            {
                return HttpNotFound();
            }
            return View(subject);
        }

        // GET: SubjectS/Create
        [Route("them-mon-hoc-moi")]
        public ActionResult Create()
        {
            return View();
        }

        // POST: SubjectS/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("them-mon-hoc-moi")]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_subject,name,date_create")] subject subject)
        {
            if (ModelState.IsValid)
            {
                subject.date_create = DateTime.Now;
                db.subjects.Add(subject);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(subject);
        }

        // GET: SubjectS/Edit/5
        [Route("cap-nhat-thong-tin-mon-hoc/{id}")]
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            subject subject = db.subjects.Find(id);
            if (subject == null)
            {
                return HttpNotFound();
            }
            return View(subject);
        }

        // POST: SubjectS/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("cap-nhat-thong-tin-mon-hoc/{id}")]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_subject,name,date_create")] subject subject)
        {
            if (ModelState.IsValid)
            {
                db.Entry(subject).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(subject);
        }

        // GET: SubjectS/Delete/5
        [Route("xoa-mon-hoc/{id}")]
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            subject subject = db.subjects.Find(id);
            if (subject == null)
            {
                return HttpNotFound();
            }
            return View(subject);
        }

        // POST: SubjectS/Delete/5
        [HttpPost, ActionName("Delete")]
        [Route("xoa-mon-hoc/{id}")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            subject subject = db.subjects.Find(id);
            db.subjects.Remove(subject);
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