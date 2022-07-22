//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace trac_nghiem_project.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;

    public partial class teachers_user
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public teachers_user()
        {
            this.subject_grade = new HashSet<subject_grade>();
        }

        public long id_teacher { get; set; }

        [DisplayName("UserName")]
        [Required(ErrorMessage ="Không được bỏ trống")]
        public string username { get; set; }

        [DisplayName("Họ và tên")]
        [Required(ErrorMessage = "Không được bỏ trống")]
        public string name { get; set; }

        [DisplayName("Mật khẩu")]
        [Required(ErrorMessage = "Không được bỏ trống")]
        [DataType(DataType.Password)]
        public string password { get; set; }

        [DisplayName("Email")]
        [Required(ErrorMessage = "Không được bỏ trống")]
        [DataType(DataType.EmailAddress,ErrorMessage ="Email không đúng định dạng")]
        public string email { get; set; }
		
		[DisplayName("Số điện thoại")]
        [DataType(DataType.PhoneNumber)]
        public string phone { get; set; }
		
		[DisplayName("Avatar")]
        [DataType(DataType.Upload)]
        public string avatar { get; set; }
		
        [DisplayName("Giới tính")]
        public Nullable<bool> gender { get; set; }

        [DisplayName("Ngày sinh")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> birthday { get; set; }

        [DisplayName("Ngày tạo")]
        [DataType(DataType.Date)]
        public Nullable<System.DateTime> date_create { get; set; }
        public Nullable<long> id_grade { get; set; }
        
		public Nullable<long> id_right { get; set; }
    
        public virtual right right { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<subject_grade> subject_grade { get; set; }
    }
}
