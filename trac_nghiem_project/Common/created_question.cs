using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace trac_nghiem_project.Common
{
    public class CreatedQuestion
    {
        public long id_exam { get; set; }
        public long id_question_bank { get; set; }

        public long id_question { get; set; }

        public Nullable<long> id_question_type { get; set; }

        public string question { get; set; }

        public string answer_1 { get; set; }

        public string answer_2 { get; set; }

        public string answer_3 { get; set; }

        public string answer_4 { get; set; }

        public string correct { get; set; }

        public string note { get; set; }

        public string question_type { get; set; }

        public bool isChose { get; set; }

        public Nullable<System.DateTime> date_create { get; set; }
        public Nullable<System.DateTime> finish_time { get; set; }
        public Nullable<System.DateTime> start_time { get; set; }
    }
}