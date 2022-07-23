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
    [RouteArea("teacher", AreaPrefix = "giang-vien")]
    [RoutePrefix("trang-quan-ly")]
    public class TeacherHomeController : ManagersController
    {
        private trac_nghiem_aspEntities db = new trac_nghiem_aspEntities();

        private teachers_user getTeacherInfo()
        {
            var session = (LoginSession)Session["login"];
            var user = db.teachers_user.Find(session.id_user);
            return user;
        }

        //Danh sách các lớp học
        [Route("danh-sach-lop-hoc",Order =0)]
        [Route("",Order =1)]
        [HasRole(RoleID = "2")]
        public ActionResult Index()
        {
            //var users = db.users.Include(u => u.grade).Include(u => u.right).Where(s=>s.id_right==2);
            //return View(users.ToList());
            var teacher = getTeacherInfo();

            //Lấy ra id_subject từ bảng subject_student
            var query_1 = db.subject_grade.Where(s => s.id_teacher == teacher.id_teacher).ToList();
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

        [Route("them-bai-kiem-tra")]
        [HasRole(RoleID = "2")]
        public ActionResult Create(long id_subject_grade)
        {
            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade", id_subject_grade);

            return View();
        }

        [HttpPost]
        [Route("them-bai-kiem-tra")]
        [ValidateAntiForgeryToken]
        [HasRole(RoleID = "2")]
        public ActionResult Create([Bind(Include = "id_exam,name,start_time,end_time,time_to_do,date_create,note,id_subject,id_subject_grade,status,score,number_of_questions,number_of_redo")] exam exam)
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
                    if (exam.number_of_redo == null)
                        exam.number_of_redo = 1;
                    exam.date_create = DateTime.Now;
                    db.exams.Add(exam);
                    db.SaveChanges();
                    return RedirectToAction("ListExam", new { id_subject_grade = exam.id_subject_grade });
                }
            }

            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade", exam.id_subject_grade);
            return View(convertExamToAddExam(exam));
        }

        [Route("danh-sach-bai-kiem-tra/{id_subject_grade}")]
        [HasRole(RoleID = "2")]
        public ActionResult ListExam(long id_subject_grade)
        {
            var query = db.exams.Where(s => s.id_subject_grade == id_subject_grade).ToList();
            ViewBag.id_subject_grade = id_subject_grade;
            long id_question_bank = -1;
            try
            {
                //Đã có question bank
                id_question_bank = db.question_bank.Where(s => s.id_subject_grade == id_subject_grade).ToList()[0].id_question_bank;
            }
            catch
            {
                //chưa có question bank
                var qB = new question_bank();
                qB.id_subject_grade = (long)id_subject_grade;
                qB.date_create = DateTime.Now;

                db.question_bank.Add(qB);
                db.SaveChanges();

                id_question_bank = qB.id_question_bank;
            }
            //get grade name
            //get subject name
            var query_2 = db.subject_grade.Find(id_subject_grade);
            ViewBag.name_grade = db.grades.Find(query_2.id_grade).name;
            ViewBag.name_subject = db.subjects.Find(query_2.id_subject).name;
            ViewBag.id_question_bank = id_question_bank;
            return View(query);
        }

        [Route("cap-nhat-bai-kiem-tra/{id_exam}")]
        [HasRole(RoleID = "2")]
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
        [Route("cap-nhat-bai-kiem-tra/{id_exam}")]
        [HasRole(RoleID = "2")]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_exam,name,start_time,end_time,time_to_do,date_create,note,id_subject_grade,status,score,number_of_questions,number_of_redo")] exam exam)
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

                if (exam.score == null)
                {
                    exam.score = 10.0;
                }
                if (exam.number_of_questions == null)
                {
                    exam.number_of_questions = Convert.ToInt32(exam.score);
                }
                if (exam.number_of_redo == null)
                    exam.number_of_redo = 1;

                db.Entry(exam).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("ListExam", new { id_subject_grade = exam.id_subject_grade });
            }
            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade", exam.id_subject_grade);
            return View(convertExamToAddExam(exam));
        }

        [Route("cap-nhat-ngan-hang-cau-hoi/{id_question_bank}")]
        [HasRole(RoleID = "2")]
        public ActionResult UpdateQuestionBank(long? id_question_bank)
        {
            if (id_question_bank == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            ViewBag.id_question_bank = id_question_bank;
            ViewBag.id_subject_grade = db.question_bank.Find(id_question_bank).id_subject_grade;
            
            //get grade name
            //get subject name
            var query_2 = db.subject_grade.Find(ViewBag.id_subject_grade);
            ViewBag.name_grade = db.grades.Find(query_2.id_grade).name;
            ViewBag.name_subject = db.subjects.Find(query_2.id_subject).name;

            return View();
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
            re.score = s.score;
            re.number_of_questions = s.number_of_questions;
            re.number_of_redo = s.number_of_redo;

            return re;
        }
    }
}