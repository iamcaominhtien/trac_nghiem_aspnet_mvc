﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace trac_nghiem_project.Common
{
    public class ReviewQuestion
    {
        public string chose { get; set; }
        public string correct { get; set; }
        public int isCorrect { get; set; }

        public string question { get; set; }

        public string answer_1 { get; set; }

        public string answer_2 { get; set; }

        public string answer_3 { get; set; }

        public string answer_4 { get; set; }
        public Nullable<long> id_question_type { get; set; }
        public string note { get; set; }
    }
}