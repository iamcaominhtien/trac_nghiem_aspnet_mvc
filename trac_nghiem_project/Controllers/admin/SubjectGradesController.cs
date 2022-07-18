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
    public class SubjectGradesController : Controller
    {
        private trac_nghiemEntities db = new trac_nghiemEntities();

        // GET: SubjectGrades
        public ActionResult Index()
        {
            var subject_grade = db.subject_grade.Include(s => s.grade).Include(s => s.subject).Include(s => s.user);
            return View(subject_grade.ToList());
        }

        // GET: SubjectGrades/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            subject_grade subject_grade = db.subject_grade.Find(id);
            if (subject_grade == null)
            {
                return HttpNotFound();
            }
            return View(subject_grade);
        }

        // GET: SubjectGrades/Create
        public ActionResult Create()
        {
            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name");
            ViewBag.id_subject = new SelectList(db.subjects, "id_subject", "name");
            ViewBag.id_teacher = new SelectList(db.users.Where(s=>s.id_right==2), "id_user", "name");
            return View();
        }

        // POST: SubjectGrades/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_subject_grade,id_subject,id_grade,id_teacher,note")] subject_grade subject_grade)
        {
            if (ModelState.IsValid)
            {
                db.subject_grade.Add(subject_grade);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name", subject_grade.id_grade);
            ViewBag.id_subject = new SelectList(db.subjects, "id_subject", "name", subject_grade.id_subject);
            ViewBag.id_teacher = new SelectList(db.users.Where(s => s.id_right == 2), "id_user", "name", subject_grade.id_teacher);
            return View(subject_grade);
        }

        // GET: SubjectGrades/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            subject_grade subject_grade = db.subject_grade.Find(id);
            if (subject_grade == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name", subject_grade.id_grade);
            ViewBag.id_subject = new SelectList(db.subjects, "id_subject", "name", subject_grade.id_subject);
            ViewBag.id_teacher = new SelectList(db.users.Where(s => s.id_right == 2), "id_user", "name", subject_grade.id_teacher);
            return View(subject_grade);
        }

        // POST: SubjectGrades/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_subject_grade,id_subject,id_grade,id_teacher,note")] subject_grade subject_grade)
        {
            if (ModelState.IsValid)
            {
                db.Entry(subject_grade).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_grade = new SelectList(db.grades, "id_grade", "name", subject_grade.id_grade);
            ViewBag.id_subject = new SelectList(db.subjects, "id_subject", "name", subject_grade.id_subject);
            ViewBag.id_teacher = new SelectList(db.users.Where(s => s.id_right == 2), "id_user", "name", subject_grade.id_teacher);
            return View(subject_grade);
        }

        // GET: SubjectGrades/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            subject_grade subject_grade = db.subject_grade.Find(id);
            if (subject_grade == null)
            {
                return HttpNotFound();
            }
            return View(subject_grade);
        }

        // POST: SubjectGrades/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            subject_grade subject_grade = db.subject_grade.Find(id);
            db.subject_grade.Remove(subject_grade);
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
