using System;
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
    [RoutePrefix("ngan-hang-cau-hoi")]
    public class QuestionBankController : ManagersController
    {
        private trac_nghiem_aspEntities db = new trac_nghiem_aspEntities();

        // GET: admin/QuestionBank
        [Route("danh-sach-mon-hoc", Order = 0)]
        [Route("", Order = 1)]
        [HasRole(RoleID = "1")]
        public ActionResult Index()
        {
            var query = (from b in db.question_bank
                           join s_g in db.subject_grade on b.id_subject_grade equals s_g.id_subject_grade
                           join g in db.grades on s_g.id_grade equals g.id_grade
                           join t in db.teachers_user on s_g.id_teacher equals t.id_teacher
                           join s in db.subjects on s_g.id_subject equals s.id_subject
                           select new MyQuestionBank
                           {
                               id_subject_grade = b.id_subject_grade,
                               grade = g.name,
                               teacher = t.name,
                               subject = s.name,
                               date_create = b.date_create,
                               id_question_bank = b.id_question_bank,
                           }).Distinct();

            var count_question = new List<int>();
            foreach (var item in query.Select(s=>s.id_question_bank))
            {
                count_question.Add(db.question_bank_questions.Count(s=>s.id_question_bank==item));
            }    

            var query_2 = subjectGradeFilter(null, null, null);
            ViewBag.id_subject_grade = new SelectList(query_2, "id_subject_grade", "name_subject_grade");
            ViewBag.count_question = count_question;

            //Đếm số câu hỏi

            return View(query.ToList());
        }

        [HasRole(RoleID = "1")]
        public JsonResult Create(long? id_subject_grade, string note)
        {
            int status = 1;
            string error = "Thêm lớp học thành công";
            if (id_subject_grade == null)
            {
                status = -1;
                error = "Vui lòng chọn 1 lớp học";
            }
            else
            {
                var query = db.question_bank.Where(s => s.id_subject_grade == id_subject_grade);
                if (query.Any())
                {
                    status = 0;
                    error = "Lớp học này đã tồn tại";
                }
                else
                {
                    try
                    {
                        var qB = new question_bank();
                        qB.id_subject_grade = (long)id_subject_grade;
                        qB.note = note;
                        qB.date_create = DateTime.Now;

                        db.question_bank.Add(qB);
                        db.SaveChanges();
                    }
                    catch
                    {
                        status = -1;
                        error = "Có lỗi xảy ra, vui lòng thử lại sau";
                    }
                }
            }

            return Json(new
            {
                status = status,
                error = error,
            });
        }

        [HasRole(RoleID = "1")]
        public JsonResult Delete(long? id_question_bank)
        {
            int status = 1;
            try
            {
                question_bank qB = db.question_bank.Find(id_question_bank);
                db.question_bank.Remove(qB);
                db.SaveChanges();
            }
            catch
            {
                status = -1;
            }
            return Json(new
            {
                status = status
            });
        }

        [Route("cap-nhat-ngan-hang-cau-hoi-cho-lop-hoc-{id_question_bank}")]
        [HasRole(RoleID = "1")]
        public ActionResult Edit(long? id_question_bank)
        {
            if (id_question_bank == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            ViewBag.id_question_bank = id_question_bank;

            return View();
        }

        private List<SubjectGradeFilter> subjectGradeFilter(long? id_subject, long? id_teacher, long? id_grade)
        {
            var string_query = "exec subject_grade_filter '" + id_subject.ToString() + "','" + id_teacher.ToString() + "','" + id_grade.ToString() + "'";
            var query = db.Database.SqlQuery<SubjectGradeFilter>(string_query).ToList();
            return query;
        }
    }
}