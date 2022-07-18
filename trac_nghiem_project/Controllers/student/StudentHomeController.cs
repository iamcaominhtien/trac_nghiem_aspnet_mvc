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
using trac_nghiem_project.Models;

namespace trac_nghiem_project.Controllers.student
{
    public class StudentHomeController : ManagersController
    {
        private trac_nghiemEntities db = new trac_nghiemEntities();
        // GET: StudentHome
        public ActionResult Index()
        {
            var student = getStudentInfo();

            //Lấy ra id_subject từ bảng subject_student
            var query_1 = db.subject_student.Where(s => s.id_student == student.id_user).ToList();
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

            //Lấy tên các giáo viên
            List<string> name_teachers = all_query.Select(s => s.name_teacher).ToList();

            //Lấy id các môn học
            List<long> id_subject_grades = all_query.Select(s => s.id_subject_grade).ToList();
            ViewBag.name_subjects = name_subjects;
            ViewBag.name_classes = name_classes;
            ViewBag.name_teachers = name_teachers;
            ViewBag.id_subject_grades = id_subject_grades;

            //Lấy ra danh sách các môn học hiện có
            var query = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query, "id_subject_grade", "name_subject_grade");
            return View();
        }

        public JsonResult DeleteSubject(long id_subject_grade)
        {
            var status = true;
            try
            {
                var student = getStudentInfo();
                var query = db.subject_student.Where(s => s.id_student == student.id_user && s.id_subject_grade == id_subject_grade).ToList()[0];
                db.subject_student.Remove(query);
                db.SaveChanges();
            }
            catch
            {
                status = false;
            }

            return Json(new
            {
                status = status
            }); ;
        }

        public JsonResult AddNewSubject(long id_subject_grade) 
        {
            int status = -1;
            var student = getStudentInfo();
            var query = db.subject_student.Where(s => (s.id_student == student.id_user && s.id_subject_grade == id_subject_grade));
            if (query.Any())
            {
                status = 0;
            }
            else
            {
                try
                {
                    var newSubjectRegister = new subject_student();
                    newSubjectRegister.id_subject_grade = id_subject_grade;
                    newSubjectRegister.id_student = student.id_user;
                    db.subject_student.Add(newSubjectRegister);
                    db.SaveChanges();
                    status = 1;
                }
                catch
                {
                    status = -1;
                }
            }

            return Json(new
            {
                status = status
            }); 
        }

        public ActionResult ListExam(long id_subject_grade)
        {
            var query = db.exams.Where(s => s.id_subject_grade == id_subject_grade).ToList();
            return View(query);
        }

        public ActionResult GoToExam(long id_exam)
        {
            var exam = db.exams.Find(id_exam);
            var student = getStudentInfo();
            var query = db.score_of_exam.Where(s => (s.id_exam == id_exam && s.id_student == student.id_user));
            var done = false;
            var score = 0.0;
            var canDo = true;

            //Đã làm chưa?
            if (query.Any())
            {
                done = true;
                try
                {
                    score = (double)query.ToList()[0].score;
                }
                catch
                {
                    done = false;
                    canDo = true;
                }
            }

            //Có câu hỏi nào không?
            var all_question = db.Database.SqlQuery<CreatedQuestion>("exec SelectAllQuestionFrom @id_exam", new SqlParameter("id_exam", id_exam));
            if (!all_question.Any())
            {
                canDo = false;
            }

            //Tới hạn/ quá hạn chưa?
            if (exam.start_time.HasValue)
            {
                if (exam.start_time > DateTime.Now)
                    canDo = false;

                if (exam.end_time.HasValue)
                {
                    if (exam.end_time < DateTime.Now)
                        canDo = false;
                }   
            }

            //Có bị khóa không
            if (exam.status == false)
            {
                canDo = false;
            }

            ViewBag.done = done;
            ViewBag.score = score;
            ViewBag.canDo = canDo;
            return View(exam);
        }

        public ActionResult StartExam(long id_exam, long? stt)
        {
            //Lưu thông tin kiểm tra
            var student = getStudentInfo();
            var my_exam = new score_of_exam();
            my_exam.id_exam = id_exam;
            my_exam.id_student = student.id_user;
            my_exam.start_time = DateTime.Now;

            var check_my_exam = db.score_of_exam.Where(s => (s.id_student == my_exam.id_student && s.id_exam == my_exam.id_exam));
            if (check_my_exam.Any())
            {
                db.Entry(my_exam).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
            }
            else
            {
                db.score_of_exam.Add(my_exam);
                db.SaveChanges();
            }

            if (stt == null)
                stt = 1;
            var all_question = db.Database.SqlQuery<CreatedQuestion>("exec SelectAllQuestionFrom @id_exam", new SqlParameter("id_exam", id_exam)).ToList();

            if (all_question == null)
            {
                return HttpNotFound();
            }
            ViewBag.number_all_question = all_question.Count;
            ViewBag.current_page = stt;
            var question = db.Database.SqlQuery<CreatedQuestion>("exec SelectOneQuestionFrom @id_exam, @stt",
                new SqlParameter("id_exam", id_exam),
                new SqlParameter("stt", stt)).ToList()[0];
            ViewBag.current_id_question = question.id_question;

            //Hiển thị những câu đã làm tại nút chuyển trang
            int n = all_question.Count;
            List<bool> isCheck = new List<bool>();
            for (int i = 0; i < n; i++)
            {
                var checkIn = db.Database.SqlQuery<do_exam>("exec CheckDoExam @id_exam, @id_question, @id_student", 
                    new SqlParameter("id_exam", all_question[i].id_exam),
                    new SqlParameter("id_question", all_question[i].id_question),
                    new SqlParameter("id_student", student.id_user)).ToList();
                if (checkIn.Any())
                {
                    isCheck.Add(true);
                    if (all_question[i].id_question == question.id_question)
                    {
                        question.correct = checkIn.ToList()[0].chose;
                    }
                }
                else
                {
                    isCheck.Add(false);
                }
            }
            ViewBag.isCheck = isCheck;

            //hiển thị thời gian làm bài
            ViewBag.timer = (db.exams.Find(id_exam).time_to_do)*60;

            return View(question);
        }

        [HttpPost]
        public ActionResult StartExam(FormCollection form)
        {
            var student = getStudentInfo();
            var all_question = db.Database.SqlQuery<CreatedQuestion>("exec SelectAllQuestionFrom @id_exam", new SqlParameter("id_exam", form["id_exam"])).ToList();

            if (all_question == null)
            {
                return HttpNotFound();
            }
            ViewBag.number_all_question = all_question.Count;
            ViewBag.current_page = Convert.ToInt16(form["stt"]);
            var question = db.Database.SqlQuery<CreatedQuestion>("exec SelectOneQuestionFrom @id_exam, @stt",
                new SqlParameter("id_exam", form["id_exam"]),
                new SqlParameter("stt", form["stt"])).ToList()[0];
            Console.Write(form["correct"]);
            ViewBag.current_id_question = question.id_question;

            //Lưu vào bảng do_exam
            if (form["correct"] != null && form["correct"] != "")
            {
                var my_do = new do_exam();
                my_do.id_student = student.id_user;
                my_do.id_exam = Convert.ToInt32(form["id_exam"]);
                my_do.id_question = Convert.ToInt32(form["current_id_question"]);
                my_do.finsh_time = DateTime.Now;
                my_do.chose = form["correct"];

                //Kiểm tra đã đánh hay chưa đánh
                var query = db.do_exam.Where(s => (s.id_exam == my_do.id_exam && s.id_question == my_do.id_question && s.id_student == my_do.id_student));
                if (query.Any())
                {
                    db.Entry(my_do).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                }
                else
                {
                    db.do_exam.Add(my_do);
                    db.SaveChanges();
                }
            }

            //Hiển thị những câu đã làm tại nút chuyển trang
            int n = all_question.Count;
            List<bool> isCheck = new List<bool>();
            for (int i = 0; i < n; i++)
            {
                var checkIn = db.Database.SqlQuery<do_exam>("exec CheckDoExam @id_exam, @id_question, @id_student",
                    new SqlParameter("id_exam", all_question[i].id_exam),
                    new SqlParameter("id_question", all_question[i].id_question),
                    new SqlParameter("id_student", student.id_user)).ToList();
                if (checkIn.Any())
                {
                    isCheck.Add(true);
                    if (all_question[i].id_question == question.id_question)
                    {
                        question.correct = checkIn.ToList()[0].chose;
                    }
                }
                else
                {
                    isCheck.Add(false);
                }
            }
            ViewBag.isCheck = isCheck;

            //hiển thị thời gian làm bài
            ViewBag.timer = Convert.ToInt32(form["time_count"]);

            return View(question);
        }

        public ActionResult SubmitExam(long id_exam)
        {
            var student = getStudentInfo();
            ////Kiểm tra câu cuối đã được thêm chưa
            //if (form["correct"] != null && form["correct"] != "")
            //{
            //    var my_do = new do_exam();
            //    my_do.id_student = student.id_user;
            //    my_do.id_exam = Convert.ToInt32(form["id_exam"]);
            //    my_do.id_question = Convert.ToInt32(form["current_id_question"]);
            //    my_do.finsh_time = DateTime.Now;
            //    my_do.chose = form["correct"];

            //    //Kiểm tra đã đánh hay chưa đánh
            //    var query = db.do_exam.Where(s => (s.id_exam == my_do.id_exam && s.id_question == my_do.id_question && s.id_student == my_do.id_student));
            //    if (query.Any())
            //    {
            //        db.Entry(my_do).State = System.Data.Entity.EntityState.Modified;
            //        db.SaveChanges();
            //    }
            //    else
            //    {
            //        db.do_exam.Add(my_do);
            //        db.SaveChanges();
            //    }
            //}

            var detailDoExam = db.Database.SqlQuery<DetailDoExam>("exec getDetailDoExam @id_exam, @id_user", new SqlParameter("id_exam", id_exam),
                new SqlParameter("id_user", student.id_user)).ToList();
            var all_question = db.Database.SqlQuery<CreatedQuestion>("exec SelectAllQuestionFrom @id_exam", new SqlParameter("id_exam", id_exam)).ToList();

            var my_exam = new score_of_exam();
            my_exam.id_exam = id_exam;
            my_exam.id_student = student.id_user;
            my_exam.finish_time = DateTime.Now;
            try
            {
                my_exam.score = 1.0*detailDoExam.Sum(s => s.status) / all_question.Count()*10;
            }
            catch
            {
                my_exam.score = 0;
            }
            db.Entry(my_exam).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();

            return RedirectToAction("GoToExam", new {id_exam=id_exam});
        }

        private List<SubjectGradeFilter> subjectGradeFilter(long? id_subject, long? id_teacher, long? id_grade)
        {
            var string_query = "exec subject_grade_filter '" + id_subject.ToString() + "','" + id_teacher.ToString() + "','" + id_grade.ToString() + "'";
            var query = db.Database.SqlQuery<SubjectGradeFilter>(string_query).ToList();
            return query;
        }

        private user getStudentInfo()
        {
            var session = (LoginSession)Session["login"];
            var user = db.users.Find(session.id_user);
            return user;
        }
    }
}