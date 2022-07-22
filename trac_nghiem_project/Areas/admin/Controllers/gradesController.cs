using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using trac_nghiem_project.Controllers;
using trac_nghiem_project.Models;

namespace trac_nghiem_project.Areas.admin.Controllers
{
    [RouteArea("admin", AreaPrefix = "quan-tri-vien")]
    [RoutePrefix("quan-li-lop-hoc")]
    public class gradesController : ManagersController
    {
        private trac_nghiem_aspEntities db = new trac_nghiem_aspEntities();

        // GET: grades
        [Route("danh-sach-cac-lop-hoc", Order = 0)]
        [Route("", Order = 1)]
        public ActionResult Index()
        {
            var grades = db.grades.Include(g => g.field);
            ViewBag.id_field = new SelectList(db.fields, "id_field", "name");
            return View(grades.ToList());
        }

        // GET: grades/Create
        public JsonResult AddNewGrade(string name, long? id_field)
        {
            string error = "Thêm lớp học thành công";
            int status = 1;
            if (name == null || name == "")
            {
                error = "Tên lớp học không được để trống";
                status = -1;
            }
            else if (id_field == null)
            {
                error = "Vui lòng chọn một chuyên ngành";
                status = -1;
            }
            else
            {
                var new_grade = new grade();
                new_grade.name = name;
                new_grade.id_field = id_field;
                new_grade.date_create = DateTime.Now;

                //Kiểm tra xem có lớp này chưa
                var query = db.grades.Where(s => (s.id_field == id_field && s.name == name));
                if (query.Any())
                {
                    status = 0;
                    error = "Lớp học đã tồn tại";
                }
                else
                {
                    try
                    {
                        db.grades.Add(new_grade);
                        db.SaveChanges();
                    }
                    catch
                    {
                        status = -1;
                        error = "Không thêm được. Vui lòng thử lại sau";
                    }
                }
            }

            return Json(new
            {
                status = status,
                error = error,
            }) ;
        }

        public JsonResult DelGrade(long? id)
        {
            int status = 1;
            try
            {
                grade grade = db.grades.Find(id);
                db.grades.Remove(grade);
                db.SaveChanges();
            }
            catch
            {
                status = -1;
            }
            return Json(new{
                status=status
            });
        }
        // GET: grades/Edit/5
        public JsonResult updateGrade(long id_grade, string name, long? id_field)
        {
            string error = "Cập nhật lớp học thành công";
            int status = 1;
            if (name == null || name == "")
            {
                error = "Tên lớp học không được để trống";
                status = -1;
            }
            else if (id_field == null)
            {
                error = "Vui lòng chọn một chuyên ngành";
                status = -1;
            }
            else
            {
                var grade = db.grades.Find(id_grade);
                grade.name = name;
                grade.id_field = id_field;

                try
                {
                    db.Entry(grade).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                }
                catch
                {
                    status = -1;
                    error = "Không cập nhật được. Vui lòng thử lại sau";
                }
            }

            return Json(new
            {
                status = status,
                error = error,
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
