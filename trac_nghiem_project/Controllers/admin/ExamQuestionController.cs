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
    public class ExamQuestionController : Controller
    {
        private trac_nghiemEntities7 db = new trac_nghiemEntities7();

        // GET: ExamQuestion
        public ActionResult Index()
        {
            var exam_question = db.exam_question.Include(e => e.exam).Include(e => e.question);
            return View(exam_question.ToList());
        }

        // GET: ExamQuestion/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            exam_question exam_question = db.exam_question.Find(id);
            if (exam_question == null)
            {
                return HttpNotFound();
            }
            return View(exam_question);
        }

        // GET: ExamQuestion/Create
        public ActionResult Create()
        {
            ViewBag.id_exam = new SelectList(db.exams, "id_exam", "name");
            ViewBag.id_question = new SelectList(db.questions, "id_question", "avatar");
            return View();
        }

        // POST: ExamQuestion/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_exam,id_question,note,date_create")] exam_question exam_question)
        {
            if (ModelState.IsValid)
            {
                db.exam_question.Add(exam_question);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_exam = new SelectList(db.exams, "id_exam", "name", exam_question.id_exam);
            ViewBag.id_question = new SelectList(db.questions, "id_question", "avatar", exam_question.id_question);
            return View(exam_question);
        }

        // GET: ExamQuestion/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            exam_question exam_question = db.exam_question.Find(id);
            if (exam_question == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_exam = new SelectList(db.exams, "id_exam", "name", exam_question.id_exam);
            ViewBag.id_question = new SelectList(db.questions, "id_question", "avatar", exam_question.id_question);
            return View(exam_question);
        }

        // POST: ExamQuestion/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_exam,id_question,note,date_create")] exam_question exam_question)
        {
            if (ModelState.IsValid)
            {
                db.Entry(exam_question).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_exam = new SelectList(db.exams, "id_exam", "name", exam_question.id_exam);
            ViewBag.id_question = new SelectList(db.questions, "id_question", "avatar", exam_question.id_question);
            return View(exam_question);
        }

        // GET: ExamQuestion/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            exam_question exam_question = db.exam_question.Find(id);
            if (exam_question == null)
            {
                return HttpNotFound();
            }
            return View(exam_question);
        }

        // POST: ExamQuestion/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            exam_question exam_question = db.exam_question.Find(id);
            db.exam_question.Remove(exam_question);
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
