using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using trac_nghiem_project.Models;

namespace trac_nghiem_project.Controllers.admin
{
    public class ManageExamController : Controller
    {
        private trac_nghiemEntities7 db = new trac_nghiemEntities7();

        // GET: ManageExam
        public ActionResult Index()
        {
            var exams = db.exams.Include(e => e.subject);
            return View(exams.ToList());
        }

        // GET: ManageExam/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            exam exam = db.exams.Find(id);
            if (exam == null)
            {
                return HttpNotFound();
            }
            return View(exam);
        }

        // GET: ManageExam/Create
        public ActionResult Create()
        {
            ViewBag.id_subject = new SelectList(db.subjects, "id_subject", "name");
            return View();
        }

        // POST: ManageExam/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_exam,name,start_time,end_time,time_to_do,date_create,note,id_subject,status")] exam exam)
        {
            if (ModelState.IsValid)
            {
                exam.date_create = DateTime.Now;
                db.exams.Add(exam);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_subject = new SelectList(db.subjects, "id_subject", "name", exam.id_subject);
            return View(exam);
        }

        // GET: ManageExam/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            exam exam = db.exams.Find(id);
            if (exam == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_subject = new SelectList(db.subjects, "id_subject", "name", exam.id_subject);
            return View(exam);
        }

        // POST: ManageExam/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_exam,name,start_time,end_time,time_to_do,date_create,note,id_subject,status")] exam exam)
        {
            if (ModelState.IsValid)
            {
                db.Entry(exam).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_subject = new SelectList(db.subjects, "id_subject", "name", exam.id_subject);
            return View(exam);
        }

        // GET: ManageExam/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            exam exam = db.exams.Find(id);
            if (exam == null)
            {
                return HttpNotFound();
            }
            return View(exam);
        }

        // POST: ManageExam/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            exam exam = db.exams.Find(id);
            db.exams.Remove(exam);
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
