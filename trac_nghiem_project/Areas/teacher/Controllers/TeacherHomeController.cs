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

namespace trac_nghiem_project.Areas.teacher.Controller
{
    public class TeacherHomeController : ManagersController
    {
        private trac_nghiemEntities db = new trac_nghiemEntities();

        private user getTeacherInfo()
        {
            var session = (LoginSession)Session["login"];
            var user = db.users.Find(session.id_user);
            return user;
        }

        public ActionResult Index()
        {
            //var users = db.users.Include(u => u.grade).Include(u => u.right).Where(s=>s.id_right==2);
            //return View(users.ToList());
            var teacher = getTeacherInfo();

            //Lấy ra id_subject từ bảng subject_student
            var query_1 = db.subject_grade.Where(s => s.id_teacher == teacher.id_user).ToList();
            List<SubjectGradeFilter> all_query = new List<SubjectGradeFilter>();

            foreach (var subject in query_1)
            {
                var getSubjectGradeTable = db.subject_grade.Find(subject.id_subject_grade);
                var query_2 = subjectGradeFilter(getSubjectGradeTable.id_subject, getSubjectGradeTable.id_teacher, getSubjectGradeTable.id_grade);
                if (query_2.Count > 0)
                {
                    all_query.Add(query_2[0]);
                }
            }

            //lấy tên các môn học
            List<string> name_subjects = all_query.Select(s => s.name_subject).ToList();

            //Lấy tên các lớp học
            List<string> name_classes = all_query.Select(s => s.name_grade).ToList();

            //Lấy id các môn học
            List<long> id_subject_grades = all_query.Select(s => s.id_subject_grade).ToList();
            ViewBag.name_subjects = name_subjects;
            ViewBag.name_classes = name_classes;
            ViewBag.id_subject_grades = id_subject_grades;

            return View();
        }

        public ActionResult Create()
        {
            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade");

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_exam,name,start_time,end_time,time_to_do,date_create,note,id_subject,id_subject_grade,status")] exam exam)
        {
            if (ModelState.IsValid)
            {
                exam.date_create = DateTime.Now;
                db.exams.Add(exam);
                db.SaveChanges();
                return RedirectToAction("ListExam", new { id_subject_grade =exam.id_subject_grade});
            }

            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade", exam.id_subject_grade);
            return View(convertExamToAddExam(exam));
        }

        public ActionResult ListExam(long id_subject_grade)
        {
            var query = db.exams.Where(s => s.id_subject_grade == id_subject_grade).ToList();
            return View(query);
        }

        public ActionResult Edit(long? id_exam)
        {
            if (id_exam == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            exam exam = db.exams.Find(id_exam);
            if (exam == null)
            {
                return HttpNotFound();
            }
            //ViewBag.id_subject = new SelectList(db.subjects, "id_subject", "name", exam.id_subject);
            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade", exam.id_subject_grade);
            return View(convertExamToAddExam(exam));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_exam,name,start_time,end_time,time_to_do,date_create,note,id_subject_grade,status")] exam exam)
        {
            if (ModelState.IsValid)
            {
                if (!exam.start_time.HasValue || !exam.end_time.HasValue)
                {
                    ModelState.AddModelError("start_time", "Không được để trống");
                    ModelState.AddModelError("end_time", "Không được để trống");
                    var _query = subjectGradeFilter(null, null, null);
                    ViewBag.id_subject_grade = new SelectList(_query, "id_subject_grade", "name_subject_grade", exam.id_subject_grade);
                    return View(convertExamToAddExam(exam));
                }
                if (exam.start_time >= exam.end_time)
                {
                    ModelState.AddModelError("start_time", "Không được lớn hơn end_time");
                    ModelState.AddModelError("end_time", "Không được nhỏ hơn start_time");
                    var _query = subjectGradeFilter(null, null, null);
                    ViewBag.id_subject_grade = new SelectList(_query, "id_subject_grade", "name_subject_grade", exam.id_subject_grade);
                    return View(convertExamToAddExam(exam));
                }

                db.Entry(exam).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("ListExam", new { id_subject_grade = exam.id_subject_grade });
            }
            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade", exam.id_subject_grade);
            return View(convertExamToAddExam(exam));
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
            re.end_time = s.end_time;
            re.start_time = s.start_time;
            re.time_to_do = s.time_to_do;
            re.name = s.name;
            re.note = s.note;
            re.status = s.status;
            re.date_create = s.date_create;
            re.id_exam = s.id_exam;

            return re;
        }
    }
}