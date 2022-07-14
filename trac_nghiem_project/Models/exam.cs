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

    public partial class exam
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public exam()
        {
            this.do_exam = new HashSet<do_exam>();
            this.exam_question = new HashSet<exam_question>();
        }
    
        public long id_exam { get; set; }

        [DisplayName("Tên bài kiểm tra")]
        [Required(ErrorMessage ="Không được bỏ trống")]
        public string name { get; set; }

        [DisplayName("Thời gian bắt đầu")]
        [Required(ErrorMessage = "Không được bỏ trống")]
        [DataType(DataType.DateTime)]
        public Nullable<System.DateTime> start_time { get; set; }

        [DisplayName("Thời gian kết thúc")]
        [Required(ErrorMessage = "Không được bỏ trống")]
        [DataType(DataType.DateTime)]
        public Nullable<System.DateTime> end_time { get; set; }

        [DisplayName("Thời gian làm bài")]
        [Required(ErrorMessage = "Không được bỏ trống")]
        public Nullable<int> time_to_do { get; set; }

        [DisplayName("Ngày tạo")]
        [DataType(DataType.Date)]
        public Nullable<System.DateTime> date_create { get; set; }

        [DisplayName("Ghi chú")]
        [DataType(DataType.MultilineText)]
        public string note { get; set; }
        public Nullable<long> id_subject { get; set; }

        [DisplayName("Trạng thái")]
        public Nullable<bool> status { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<do_exam> do_exam { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<exam_question> exam_question { get; set; }
        public virtual subject subject { get; set; }
    }
}
