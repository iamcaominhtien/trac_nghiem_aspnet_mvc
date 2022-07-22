using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
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
    [RoutePrefix("quan-li-bai-kiem-tra")]
    public class ManageExamController : ManagersController
    {
        private trac_nghiem_aspEntities db = new trac_nghiem_aspEntities();

        // GET: ManageExam
        [Route("danh-sach-cac-bai-kiem-tra", Order = 0)]
        [Route("", Order = 1)]
        public ActionResult Index()
        {
            var exams = db.exams.Include(e => e.subject_grade).ToList();
            var query = subjectGradeFilter(null, null, null);
            List<string> name_teachers = new List<string>();
            foreach (var item in exams)
            {
                name_teachers.Add(query.Where(s => s.id_subject_grade == item.id_subject_grade).Select(s => s.name_teacher).ToList()[0]);
            }
            ViewBag.name_teachers = name_teachers;
            return View(exams);
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

            var query_subject_grade = db.subject_grade.Find(exam.id_subject_grade);
            ViewBag.name_teacher = "";
            ViewBag.name_subject = "";
            ViewBag.name_grade = "";

            try
            {
                var query = subjectGradeFilter(query_subject_grade.id_subject, query_subject_grade.id_teacher, query_subject_grade.id_grade)[0];
                ViewBag.name_teacher = query.name_teacher;
                ViewBag.name_subject = query.name_subject;
                ViewBag.name_grade = query.name_grade;
            }
            catch
            {
                ViewBag.name_teacher = "Unknown";
                ViewBag.name_subject = "Unknown";
                ViewBag.name_grade = "Unknown";
            }
            return View(exam);
        }

        // GET: ManageExam/Create
        [Route("them-bai-kiem-tra-moi")]
        public ActionResult Create()
        {
            var query = subjectGradeFilter(null,null,null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade");

            return View();
        }

        // POST: ManageExam/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("them-bai-kiem-tra-moi")]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_exam,name,start_time,end_time,time_to_do,date_create,note,id_subject_grade,status,score,number_of_questions")] exam exam)
        {
            if (ModelState.IsValid)
            {
                if (exam.start_time >= exam.end_time)
                {
                    ModelState.AddModelError("start_time", "Cài đặt thời gian không hợp lệ");
                    ModelState.AddModelError("end_time", "Cài đặt thời gian không hợp lệ");
                }
                else
                {
                    exam.date_create = DateTime.Now;
                    if (exam.score == null)
                    {
                        exam.score = 10.0;
                    }
                    if (exam.number_of_questions == null)
                    {
                        exam.number_of_questions = Convert.ToInt32(exam.score);
                    }
                    db.exams.Add(exam);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }

            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade",exam.id_subject_grade);
            return View(convertExamToAddExam(exam));
        }

        // GET: ManageExam/Edit/5
        [Route("cap-nhat-bai-kiem-tra/{id}")]
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
            //ViewBag.id_subject = new SelectList(db.subjects, "id_subject", "name", exam.id_subject);
            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade",exam.id_subject_grade);
            return View(convertExamToAddExam(exam));
        }

        // POST: ManageExam/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [Route("cap-nhat-bai-kiem-tra/{id}")]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_exam,name,start_time,end_time,time_to_do,date_create,note,id_subject_grade,status,score,number_of_questions")] exam exam)
        {
            if (ModelState.IsValid)
            {
                if (exam.start_time >= exam.end_time)
                {
                    ModelState.AddModelError("start_time", "Cài đặt thời gian không hợp lệ");
                    ModelState.AddModelError("end_time", "Cài đặt thời gian không hợp lệ");
                }
                else
                {
                    if (exam.score == null)
                    {
                        exam.score = 10.0;
                    }
                    if (exam.number_of_questions == null)
                    {
                        exam.number_of_questions = Convert.ToInt32(exam.score);
                    }
                    db.Entry(exam).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade", exam.id_subject_grade);
            return View(convertExamToAddExam(exam));
        }

        // GET: ManageExam/Delete/5
        [Route("xoa-bai-kiem-tra/{id}")]
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

            var query_subject_grade = db.subject_grade.Find(exam.id_subject_grade);
            ViewBag.name_teacher = "";
            ViewBag.name_subject = "";
            ViewBag.name_grade = "";

            try
            {
                var query = subjectGradeFilter(query_subject_grade.id_subject, query_subject_grade.id_teacher, query_subject_grade.id_grade)[0];
                ViewBag.name_teacher = query.name_teacher;
                ViewBag.name_subject = query.name_subject;
                ViewBag.name_grade = query.name_grade;
            }
            catch
            {
                ViewBag.name_teacher = "Unknown";
                ViewBag.name_subject = "Unknown";
                ViewBag.name_grade = "Unknown";
            }
            return View(exam);
        }

        // POST: ManageExam/Delete/5
        [HttpPost, ActionName("Delete")]
        [Route("xoa-bai-kiem-tra/{id}")]
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

        private List<SubjectGradeFilter> subjectGradeFilter(long? id_subject, long? id_teacher, long? id_grade)
        {
            var string_query = "exec subject_grade_filter '" + id_subject.ToString() + "','" + id_teacher.ToString() + "','" + id_grade.ToString() + "'";
            var query = db.Database.SqlQuery<SubjectGradeFilter>(string_query).ToList();
            return query;
        }

        private AddExam convertExamToAddExam(exam s)
        {
            var re = new AddExam();
            re.id_subject_grade = s.id_subject_grade;
            re.end_time= s.end_time;
            re.start_time = s.start_time;
            re.time_to_do = s.time_to_do;
            re.name = s.name;
            re.note = s.note;
            re.status = s.status;
            re.date_create = s.date_create;
            re.id_exam = s.id_exam;
            re.score = s.score;
            re.number_of_questions = s.number_of_questions;

            return re;
        }
    }
}
