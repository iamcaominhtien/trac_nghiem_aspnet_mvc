using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace trac_nghiem_project.Common
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    public class AddExam
    {
        public long id_exam { get; set; }

        [DisplayName("Tên bài kiểm tra")]
        [Required(ErrorMessage = "Không được bỏ trống")]
        public string name { get; set; }

        [DisplayName("Thời gian bắt đầu")]
        [Required(ErrorMessage = "Không được bỏ trống")]
        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-ddThh:mm:ss}", ApplyFormatInEditMode = true)]
        //DisplayFormat(DataFormatString = "{0:yyyy/MM/dd}", ApplyFormatInEditMode = true)
        public Nullable<System.DateTime> start_time { get; set; }

        [DisplayName("Thời gian kết thúc")]
        [Required(ErrorMessage = "Không được bỏ trống")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-ddThh:mm:ss}", ApplyFormatInEditMode = true)]
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

        public Nullable<long> id_subject_grade { get; set; }

        public Nullable<long> id_teacher { get; set; }

        public Nullable<long> id_grade { get; set; }

        [DisplayName("Trạng thái")]
        public Nullable<bool> status { get; set; }

        [DisplayName("Tổng điểm")]
        public Nullable<double> score { get; set; }

        [DisplayName("Số câu hỏi")]
        public Nullable<int> number_of_questions { get; set; }
    }
}