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
    public class FieldsController : Controller
    {
        private trac_nghiemEntities db = new trac_nghiemEntities();
        // GET: Fields
        public ActionResult Index()
        {
            return View(db.fields.ToList());
        }
        
        public JsonResult Create(string name)
        {
            string error = "Thêm chuyên ngành thành công";
            int status = 1;
            if (string.IsNullOrEmpty(name))
            {
                error = "Tên chuyên ngành không được để trống";
                status = -1;
            }
            else
            {
                //Kiểm tra xem có chuyên ngành này chưa
                var query = db.fields.Where(s => (s.name == name));
                if (query.Any())
                {
                    status = 0;
                    error = "Chuyên ngành đã tồn tại";
                }
                else
                {
                    var new_field = new field();
                    new_field.name = name;
                    new_field.date_create = DateTime.Now;
                    try
                    {
                        db.fields.Add(new_field);
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
            });
        }

        public JsonResult Delete(long? id)
        {
            int status = 1;
            try
            {
                var field = db.fields.Find(id);
                db.fields.Remove(field);
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

        public JsonResult Edit(long? id_field, string name)
        {
            string error = "Cập nhật lớp học thành công";
            int status = 1;
            if (string.IsNullOrEmpty(name))
            {
                error = "Tên chuyên ngành không được để trống";
                status = -1;
            }
            else
            {
                var field = db.fields.Find(id_field);
                field.name = name;
                try
                {
                    db.Entry(field).State = System.Data.Entity.EntityState.Modified;
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