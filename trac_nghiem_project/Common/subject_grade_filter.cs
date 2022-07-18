using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace trac_nghiem_project.Common
{
    public class SubjectGradeFilter
    {
        public long id_subject_grade { get; set; }
        public long id_subject { get; set; }
        public long id_grade { get; set; }
        public Nullable<long> id_teacher { get; set; }

        public string name_subject { get; set; }
        public string name_grade { get; set; }
        public string name_teacher { get; set; }
        public string name_subject_grade { get; set; }
    }
}