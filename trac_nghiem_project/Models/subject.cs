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
    
    public partial class subject
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public subject()
        {
            this.subject_grade = new HashSet<subject_grade>();
        }
    
        public long id_subject { get; set; }
		
		[DisplayName("Môn học")]
        [Required(ErrorMessage ="Không được để trống")]
        public string name { get; set; }

        [DataType(DataType.Date)]
        public Nullable<System.DateTime> date_create { get; set; }
		
		[DisplayName("Chuyên ngành")]
		[Required(ErrorMessage ="Không được để trống")]
        public Nullable<long> id_field { get; set; }
    
        public virtual field field { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<subject_grade> subject_grade { get; set; }
    }
}
