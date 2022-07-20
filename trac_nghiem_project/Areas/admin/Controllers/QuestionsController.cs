﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Validation;
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
    public class QuestionsController : ManagersController
    {
        private trac_nghiemEntities db = new trac_nghiemEntities();

        public JsonResult ListQuestion(long? id_question)
        {
            question _question = db.questions.Find(id_question);
            if (_question == null)
            {
                return Json(new
                {
                    status = false,
                });
            }
            int numberOfRadio = 4;
            if (empty(_question.answer_4))
                numberOfRadio -= 1;
            if (empty(_question.answer_3))
                numberOfRadio -= 1;
            return Json(new
            {
                status = true,
                question = _question.question1,
                answer_1 = _question.answer_1,
                answer_2 = _question.answer_2,
                answer_3=_question.answer_4,
                answer_4 = _question.answer_4,
                correct = _question.correct,
                note = _question.note,
                numberOfRadio = numberOfRadio,
                id_question = _question.id_question,
                id_question_type = _question.id_question_type,
                avatar = _question.avatar,
                date_create = Convert.ToDateTime(_question.date_create).ToString("yyyy/MM/dd"),
            });
        }

        public ActionResult ListAllQuestionFrom(long? id_exam)
        {
            if (id_exam == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var question = db.Database.SqlQuery<CreatedQuestion>("exec SelectAllQuestionFrom @id_exam", new SqlParameter("id_exam", id_exam)).ToList();
            Console.Write(question.Count);

            if (question==null)
            {
                return HttpNotFound();
            }

            return PartialView(question);
        }


        [ChildActionOnly]
        public ActionResult Create(long? id_exam)
        {
            ViewBag.id_question_type = new SelectList(db.question_types, "id_question_type", "name");
            ViewBag.selected = "1";
            ViewBag.id_exam = id_exam;
            return PartialView();
        }

        private bool empty(string check)
        {
            return check == null || check == "";
        }

        bool checkValid(question question)
        {
            if (empty(question.question1))
                return false;
            if (empty(question.correct))
                return false;
            if (question.id_question_type!=3)
            {
                if (empty(question.answer_1) || empty(question.answer_2))
                    return false;
            }
            return true;
        }

        public JsonResult CreateAQuestion(long? id_question, long? id_question_type,
                    string avatar,
                    string question,
                    string answer_1,
                    string answer_2,
                    string answer_3,
                    string answer_4,
                    string correct,
                    string note,
                    DateTime? date_create,
                    long? id_exam
                    )
        {
            var _question = new question();
            //_question.id_question = null;
            _question.id_question_type = id_question_type;
            _question.avatar = avatar;
            _question.question1 = question;
            _question.answer_1 = answer_1;
            _question.answer_2 = answer_2;
            _question.answer_3 = answer_3;
            _question.answer_4 = answer_4;
            _question.correct = correct;
            _question.note = note;
            _question.date_create = date_create;

            bool _status = false;
            if (checkValid(_question))
            {
                _question.date_create = DateTime.Now;
                try
                {
                    db.questions.Add(_question);
                    db.SaveChanges();

                    var _exam_question = new exam_question();
                    _exam_question.id_exam = (long)id_exam;
                    _exam_question.id_question = (long)_question.id_question;
                    _exam_question.date_create = DateTime.Now;
                    db.exam_question.Add(_exam_question);
                    db.SaveChanges();

                    _status = true;
                    var Lquestion = db.Database.SqlQuery<CreatedQuestion>("exec SelectAllQuestionFrom @id_exam", new SqlParameter("id_exam", id_exam)).ToList();
                    Console.Write(Lquestion.Last().question_type);

                    return Json(new
                    {
                        status = _status,
                        stt = Lquestion.Count,
                        question = Lquestion.Last().question,
                        id_question_type = Lquestion.Last().id_question_type,
                        question_type = Lquestion.Last().question_type,
                        created_date = Convert.ToDateTime(Lquestion.Last().date_create).ToString("dd/MM/yyyy"),
                        id_question = Lquestion.Last().id_question,
                    });
                }
                catch (DbEntityValidationException dbEx)
                {
                    foreach (var validationErrors in dbEx.EntityValidationErrors)
                    {
                        foreach (var validationError in validationErrors.ValidationErrors)
                        {
                            System.Console.WriteLine("Property: {0} Error: {1}", validationError.PropertyName, validationError.ErrorMessage);
                        }
                    }
                    _status = false;
                }
            }

            return Json(new
            {
                status = _status,
            });
        }

        public JsonResult UpdateQuestion(long? id_question, long? id_question_type,
                    string avatar,
                    string question,
                    string answer_1,
                    string answer_2,
                    string answer_3,
                    string answer_4,
                    string correct,
                    string note,
                    DateTime? date_create)
        {
            var _question = new question();
            _question.id_question = (long)id_question;
            _question.id_question_type = id_question_type;
            _question.avatar = avatar;
            _question.question1 = question;
            _question.answer_1 = answer_1;
            _question.answer_2 = answer_2;
            _question.answer_3 = answer_3;
            _question.answer_4 = answer_4;
            _question.correct = correct;
            _question.note = note;
            _question.date_create = date_create;

            bool _status = false;

            if (checkValid(_question))
            {
                try
                {
                    db.Entry(_question).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    _status = true;
                }
                catch
                {
                    _status = false;
                }
            }

            return Json(new
            {
                status = _status
            }); ;
        }

        public JsonResult DeleteQuestion(long? id_question)
        {
            bool _status = false;
            try
            {
                question question = db.questions.Find(id_question);
                db.questions.Remove(question);
                db.SaveChanges();
                _status = true;
            }
            catch
            {
                _status = false;
            }

            return Json(new
            {
                status=_status,
            });
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