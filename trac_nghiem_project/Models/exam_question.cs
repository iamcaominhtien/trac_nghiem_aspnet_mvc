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
    
    public partial class exam_question
    {
        public long id_exam { get; set; }
        public long id_question { get; set; }
        public string note { get; set; }
        public Nullable<System.DateTime> date_create { get; set; }
    
        public virtual exam exam { get; set; }
        public virtual question question { get; set; }
    }
}
