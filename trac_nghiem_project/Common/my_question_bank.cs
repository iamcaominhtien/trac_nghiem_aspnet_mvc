using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace trac_nghiem_project.Common
{
    public class MyQuestionBank
    {
        public long id_question_bank { get; set; }
        public long id_subject_grade { get; set; }
        public string grade { get; set; }
        public string teacher { get; set; }
        public string subject { get; set; }

        [DisplayName("Ngày tạo")]
        [DataType(DataType.Date)]
        public Nullable<System.DateTime> date_create { get; set; }
    }
}