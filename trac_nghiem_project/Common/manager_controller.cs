using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace trac_nghiem_project.Common
{
    public class LoginSession
    {
        [Required(ErrorMessage = "Điền đầy đủ họ tên")]
        public string name_of_user { get; set; }
        public string username_or_email { get; set; }

        [DisplayName("Tên đăng nhập")]
        [Required(ErrorMessage = "Username không được để trống")]
        public string username { get; set; }

        [DisplayName("Email")]
        [DataType(DataType.EmailAddress,ErrorMessage ="Email không đúng định dạng")]
        [Required(ErrorMessage = "Email không được để trống")]
        public string email { get; set; }

        [DisplayName("Mật khẩu")]
        [DataType(DataType.Password)]
        [Required(ErrorMessage = "Mật khẩu không được để trống")]
        public string password { get; set; }
        public string retype_password { get; set; }

        [DisplayName("Giới tính")]
        public Nullable<bool> gender { get; set; }

        [Required(ErrorMessage ="Chọn một lớp")]
        public Nullable<long> id_grade { get; set; }

        [DisplayName("Avatar")]
        [DataType(DataType.Upload)]
        public string avatar { get; set; }

        [DisplayName("Ngày sinh")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> birthday { get; set; }

        public Nullable<long> id_right { get; set; }

        public Nullable<long> id_user { get; set; }
    }
}