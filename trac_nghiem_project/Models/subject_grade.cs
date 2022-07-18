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

    public partial class subject_grade
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public subject_grade()
        {
            this.exams = new HashSet<exam>();
            this.subject_student = new HashSet<subject_student>();
        }
        
        public long id_subject_grade { get; set; }

        [Required(ErrorMessage ="Vui lòng chọn 1 môn học")]
        [DisplayName("Môn học")]
        public long id_subject { get; set; }


        [Required(ErrorMessage = "Vui lòng chọn 1 lớp")]
        [DisplayName("Lớp")]
        public long id_grade { get; set; }

        [DisplayName("Giáo viên")]
        [Required(ErrorMessage = "Vui lòng chọn 1 giáo viên")]
        public Nullable<long> id_teacher { get; set; }

        [DisplayName("Ghi chú")]
        [DataType(DataType.MultilineText)]
        public string note { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<exam> exams { get; set; }
        public virtual grade grade { get; set; }
        public virtual subject subject { get; set; }
        public virtual user user { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<subject_student> subject_student { get; set; }
    }
}
