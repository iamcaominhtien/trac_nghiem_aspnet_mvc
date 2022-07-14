using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using trac_nghiem_project.Models;

namespace trac_nghiem_project.Controllers.admin
{
    public class QuestionsController : Controller
    {
        private trac_nghiemEntities7 db = new trac_nghiemEntities7();

        [ChildActionOnly]
        public ActionResult ListQuestion(long? id_kt)
        {
            if (id_kt == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            question question = db.questions.Find(id_kt);
            if (question == null)
            {
                return HttpNotFound();
            }
            return PartialView(question);
        }

        // GET: Questions
        public ActionResult Index()
        {
            var questions = db.questions.Include(q => q.question_types);
            return View(questions.ToList());
        }

        // GET: Questions/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            question question = db.questions.Find(id);
            if (question == null)
            {
                return HttpNotFound();
            }
            return PartialView(question);
        }

        // GET: Questions/Create
        [ChildActionOnly]
        public ActionResult Create()
        {
            ViewBag.id_question_type = new SelectList(db.question_types, "id_question_type", "name");
            ViewBag.selected = "1";
            return PartialView();
        }

        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //[ChildActionOnly]
        //public ActionResult Create([Bind(Include = "id_question,id_question_type,avatar,question1,answer_1,answer_2,answer_3,answer_4,correct,note,date_create")] question question)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        question.date_create = DateTime.Now;
        //        db.questions.Add(question);
        //        db.SaveChanges();
        //        return PartialView();
        //    }
        //    ViewBag.selected = question.id_question_type.ToString();

        //    ViewBag.id_question_type = new SelectList(db.question_types, "id_question_type", "name", question.id_question_type);
        //    return View(question);
        //}

        bool checkValid(question question)
        {
            if (question.question1==null || question.question1 == "")
                return false;
            if (question.correct == null)
                return false;
            if (question.answer_1 == null && question.id_question_type !=3)
                return false;
            return true;
        }

        //id_question, id_question_type,avatar, question, answer_1,answer_2, answer_3, answer_4,correct, note, date_create,
        public JsonResult CreateAQuestion(long? id_question, long? id_question_type,
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
                    _status = true;
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

        // GET: Questions/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            question question = db.questions.Find(id);
            if (question == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_question_type = new SelectList(db.question_types, "id_question_type", "name", question.id_question_type);
            return View(question);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_question,id_question_type,avatar,question1,answer_1,answer_2,answer_3,answer_4,correct,note,date_create")] question question)
        {
            if (ModelState.IsValid)
            {
                db.Entry(question).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_question_type = new SelectList(db.question_types, "id_question_type", "name", question.id_question_type);
            return View(question);
        }

        // GET: Questions/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            question question = db.questions.Find(id);
            if (question == null)
            {
                return HttpNotFound();
            }
            return View(question);
        }

        // POST: Questions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            question question = db.questions.Find(id);
            db.questions.Remove(question);
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
