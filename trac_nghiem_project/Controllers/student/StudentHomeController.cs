﻿using System;
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
    [RoutePrefix("sinh-vien")]
    public class StudentHomeController : ManagersController
    {
        static List<CreatedQuestion> list_questions = new List<CreatedQuestion>();

        private trac_nghiem_aspEntities db = new trac_nghiem_aspEntities();

        [Route("")]
        [Route("danh-sach-mon-hoc")]        
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

        [Route("danh-sach-bai-kiem-tra/{id_subject_grade}")]
        public ActionResult ListExam(long id_subject_grade)
        {
            var query = db.exams.Where(s => s.id_subject_grade == id_subject_grade).ToList();
            return View(query);
        }

        [Route("chi-tiet-bai-kiem-tra/{id_exam}")]
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
            //var all_question = db.Database.SqlQuery<CreatedQuestion>("exec SelectAllQuestionFrom @id_exam", new SqlParameter("id_exam", id_exam));
            //if (!all_question.Any())
            //{
            //    canDo = false;
            //}

            var id_question_bank = db.question_bank.Where(s => s.id_subject_grade == exam.id_subject_grade).ToList()[0].id_question_bank;
            var query_qB_question = db.question_bank_questions.Where(s => s.id_question_bank == id_question_bank);
            if (!query_qB_question.Any())
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

        //[Route("kiem-tra/{id_exam}")]
        [Route("kiem-tra/{id_exam}")]
        public ActionResult StartExam(long id_exam, long? stt=1)
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

            //Lấy thông tin bài kiểm tra và id_question_bank
            var exam = db.exams.Find(id_exam);
            var id_question_bank = db.question_bank.Where(s => s.id_subject_grade == exam.id_subject_grade).ToList()[0].id_question_bank;

            //Phân trang
            if (stt == null)
                stt = 1;

                //Lấy số lượng câu hỏi
            list_questions = db.Database.SqlQuery<CreatedQuestion>("exec SelectRandomQuestionFrom @id_question_bank, @number_of_question", 
                new SqlParameter("id_question_bank", id_question_bank),
                new SqlParameter("number_of_question", exam.number_of_questions)).ToList();

            if (list_questions == null)
            {
                return HttpNotFound();
            }
            ViewBag.number_all_question = list_questions.Count;
            ViewBag.current_page = stt;
            var question = list_questions[(int)stt-1];
            question.id_exam = id_exam;
            ViewBag.current_id_question = question.id_question;

            //Hiển thị những câu đã làm tại nút chuyển trang
            int n = list_questions.Count;
            List<bool> isCheck = new List<bool>();
            for (int i = 0; i < n; i++)
            {
                var checkIn = db.Database.SqlQuery<do_exam>("exec CheckDoExam @id_exam, @id_question, @id_student", 
                    new SqlParameter("id_exam", list_questions[i].id_exam),
                    new SqlParameter("id_question", list_questions[i].id_question),
                    new SqlParameter("id_student", student.id_user)).ToList();
                if (checkIn.Any())
                {
                    isCheck.Add(true);
                    if (list_questions[i].id_question == question.id_question)
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
        //[Route("kiem-tra/{id_exam}")]
        [Route("kiem-tra/{id_exam}")]
        public ActionResult StartExam(long id_exam, long stt, string correct, long current_id_question, long time_count, int finish=0)
        {
            var student = getStudentInfo();

            if (list_questions == null)
            {
                return HttpNotFound();
            }
            ViewBag.number_all_question = list_questions.Count;
            ViewBag.current_page = Convert.ToInt16(stt);
            var question = list_questions[(int)stt - 1];
            question.id_exam = id_exam;
            Console.Write(correct);
            ViewBag.current_id_question = question.id_question;

            //Lưu vào bảng do_exam
            var my_do = new do_exam();
            my_do.id_student = student.id_user;
            my_do.id_exam = id_exam;
            my_do.id_question = current_id_question;
            my_do.finsh_time = DateTime.Now;
            my_do.chose = correct;
            //list_questions[stt-1]

            //Kiểm tra đã đánh hay chưa đánh
            var query = db.do_exam.Where(s => (s.id_exam == my_do.id_exam && s.id_question == my_do.id_question && s.id_student == my_do.id_student ));
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

            //Lưu phương án đã chọn vào list_question
            for (int i = 0; i < list_questions.Count; i++)
            {
                if (list_questions[i].id_question == current_id_question)
                {
                    list_questions[i].correct = correct;
                    break;
                }
            }

            if (finish != 1)
            {
                //Hiển thị những câu đã làm tại nút chuyển trang
                int n = list_questions.Count;
                List<bool> isCheck = new List<bool>();
                //for (int i = 0; i < n; i++)
                //{
                //    var checkIn = db.Database.SqlQuery<do_exam>("exec CheckDoExam @id_exam, @id_question, @id_student",
                //        new SqlParameter("id_exam", list_questions[i].id_exam),
                //        new SqlParameter("id_question", list_questions[i].id_question),
                //        new SqlParameter("id_student", student.id_user)).ToList();
                //    if (checkIn.Any())
                //    {
                //        isCheck.Add(true);
                //        if (list_questions[i].id_question == question.id_question)
                //        {
                //            question.correct = checkIn.ToList()[0].chose;
                //        }
                //    }
                //    else
                //    {
                //        isCheck.Add(false);
                //    }
                //}

                for (int i = 0; i < n; i++)
                {
                    if (String.IsNullOrEmpty(list_questions[i].correct) == false)
                    {
                        isCheck.Add(true);
                    }
                    else
                    {
                        isCheck.Add(false);
                    }
                }

                ViewBag.isCheck = isCheck;

                //hiển thị thời gian làm bài
                ViewBag.timer = time_count;

                return View(question);
            }
            else
            {
                return RedirectToAction("SubmitExam", new { id_exam = id_exam });
            }
        }
  
        public ActionResult SubmitExam(long id_exam)
        {
            var student = getStudentInfo();

            var detailDoExam = db.Database.SqlQuery<DetailDoExam>("exec getDetailDoExam @id_exam, @id_user", new SqlParameter("id_exam", id_exam),
                new SqlParameter("id_user", student.id_user)).ToList();
            var exam = db.exams.Find(id_exam);

            var my_exam = new score_of_exam();
            my_exam.id_exam = id_exam;
            my_exam.id_student = student.id_user;
            my_exam.finish_time = DateTime.Now;
            
            try
            {
                my_exam.score = 1.0*detailDoExam.Sum(s => s.status) / list_questions.Count()*exam.score;
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

        private students_user getStudentInfo()
        {
            var session = (LoginSession)Session["login"];
            var user = db.students_user.Find(session.id_user);
            return user;
        }
    }
}