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
    
    public partial class question
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public question()
        {
            this.do_exam = new HashSet<do_exam>();
            this.exam_question = new HashSet<exam_question>();
        }
    
        public long id_question { get; set; }
        public Nullable<long> id_question_type { get; set; }
        
		[DisplayName("Hình ảnh")]
        [DataType(DataType.Upload)]
        public string avatar { get; set; }

        [DisplayName("Câu hỏi")]
        [Required(ErrorMessage ="Không được để trống")]
        [DataType(DataType.MultilineText)]
        public string question1 { get; set; }

        [DisplayName("Câu trả lời 1")]
        [DataType(DataType.MultilineText)]
        public string answer_1 { get; set; }

        [DisplayName("Câu trả lời 2")]
        [DataType(DataType.MultilineText)]
        public string answer_2 { get; set; }

        [DisplayName("Câu trả lời 3")]
        [DataType(DataType.MultilineText)]
        public string answer_3 { get; set; }

        [DisplayName("Câu trả lời 4")]
        [DataType(DataType.MultilineText)]
        public string answer_4 { get; set; }

        [DisplayName("Đáp án")]
        [DataType(DataType.MultilineText)]
        public string correct { get; set; }

        [DisplayName("Ghi chú")]
        [DataType(DataType.MultilineText)]
        public string note { get; set; }

        [DisplayName("Ngày tạo")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public Nullable<System.DateTime> date_create { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<do_exam> do_exam { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<exam_question> exam_question { get; set; }
        public virtual question_types question_types { get; set; }
    }
}
