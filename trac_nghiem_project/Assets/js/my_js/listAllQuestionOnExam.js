function updateSTT(){
    listSTT = $('.stt');
    for (let i = 0; i < listSTT.length; i++) {
        $(listSTT[i]).html(i+1)
    } 
}

function onClickShowAboveAll(a, id_question, isDetail, id_question_type) {
    //document.getElementById("out_aboveALl").style = `height: ${document.body.scrollHeight}px`;
        document.getElementById("out_aboveALl").style = "display:block";
        if (isDetail) {
            getDetail(id_question, id_question_type)
        }
        else {
            //document.getElementById("childAboveAll").innerHTML = document.getElementById("childAboveAll_edit").innerHTML
            //document.getElementById("aboveALl").style = "width: 100%";
            getDetailForUpdate(id_question, id_question_type)
        }
}

function getDetailForUpdate(id_question, id_question_type) {
    $.ajax({
        url: "/Questions/ListQuestion",
        type: "POST",
        data: { id_question: id_question },
        dataType: 'json',
        success: function (response) {
            console.log(response)
            if (response.status) {
                document.getElementById("childAboveAll").innerHTML = ''
                var htmlPattern = document.getElementById("childAboveAll_edit_radio").innerHTML
                if (id_question_type == 3)
                    htmlPattern = document.getElementById("childAboveAll_edit_text").innerHTML
                document.getElementById("childAboveAll").innerHTML = htmlPattern.
                    replaceAll("#date_create", response.date_create).
                    replaceAll("#id_question_type", response.id_question_type).
                    replaceAll("#id_question", response.id_question).
                    replaceAll("#avatar", response.avatar).
                    replaceAll("#question", response.question).
                    replaceAll("#answer_1", response.answer_1).
                    replaceAll("#answer_2", response.answer_2).
                    replaceAll("#answer_3", response.answer_3).
                    replaceAll("#answer_4", response.answer_4).
                    replaceAll("#correct", response.correct).
                    replaceAll("#note", response.note);
                document.getElementById("aboveALl").style = "width: 100%";
            }
            else {
                alert("Có lỗi xảy ra. Vui lòng thử lại sau.")
            }
        },
        error: function (e) {
            console.log(e);
            alert("Có lỗi xảy ra. Vui lòng thử lại sau.")
        }
    });
}

function getFormValueForUpdate() {
    var answer_1, answer_2, answer_3, answer_4;
    if (document.getElementById("answer_1_edit")) answer_1 = document.getElementById("answer_1_edit").value;
    if (document.getElementById("answer_2_edit")) answer_2 = document.getElementById("answer_2_edit").value;
    if (document.getElementById("answer_3_edit")) answer_3 = document.getElementById("answer_3_edit").value;
    if (document.getElementById("answer_4_edit")) answer_4 = document.getElementById("answer_4_edit").value;
    return {
        id_question: document.getElementById("id_question_edit").value,
        id_question_type: document.getElementById("id_question_type_edit").value,
        avatar: null,
        question: document.getElementById("question_edit").value,
        answer_1: answer_1,
        answer_2: answer_2,
        answer_3: answer_3,
        answer_4: answer_4,
        correct: document.getElementById("correct_edit").value,
        note: document.getElementById("note_edit").value,
        date_create: document.getElementById("date_create_edit").value,
    };
}

function updateQuestion() {
    //UpdateQuestion
    $.ajax({
        url: "/Questions/UpdateQuestion",
        type: "POST",
        data: getFormValueForUpdate(),
        dataType: 'json',
        success: function (response) {
            console.log(response)
            if (response.status) {
                document.getElementById("out_aboveALl").style = "display:none";
                alert("Cập nhật câu hỏi thành công.")
            }
            else {
                alert("Có lỗi xảy ra. Vui lòng kiểm tra lại.")
            }
        },
        error: function (e) {
            console.log(e);
            alert("Có lỗi xảy ra. Vui lòng thử lại sau.")
        }
    });
}

function getDetail(id_question, id_question_type) {
    $.ajax({
        url: "/Questions/ListQuestion",
        type: "POST",
        data: { id_question: id_question },
        dataType: 'json',
        success: function (response) {
            console.log(response)
            if (response.status) {
                document.getElementById("childAboveAll").innerHTML =''
                if (id_question_type == 3) {
                    document.getElementById("childAboveAll").innerHTML = document.getElementById("childAboveAll_text").innerHTML.replaceAll("#question", response.question).replaceAll("#note", response.note).replaceAll("#correct", response.correct);
                }
                else {
                    if (response.numberOfRadio == 4) {
                        document.getElementById("childAboveAll").innerHTML = document.getElementById("childAboveAll_radio_4").innerHTML.replaceAll("#question", response.question).replaceAll("#note", response.note).replaceAll("#answer_1", response.answer_1).replaceAll("#answer_2", response.answer_2).replaceAll("#answer_3", response.answer_3).replaceAll("#answer_4", response.answer_4).replaceAll("#correct", response.correct);
                    }
                    else if (response.numberOfRadio == 3) {
                        document.getElementById("childAboveAll").innerHTML = document.getElementById("childAboveAll_radio_3").innerHTML.replaceAll("#question", response.question).replaceAll("#note", response.note).replaceAll("#answer_1", response.answer_1).replaceAll("#answer_2", response.answer_2).replaceAll("#answer_3", response.answer_3).replaceAll("#correct", response.correct);
                    }
                    else {
                        document.getElementById("childAboveAll").innerHTML = document.getElementById("childAboveAll_radio_2").innerHTML.replaceAll("#question", response.question).replaceAll("#note", response.note).replaceAll("#answer_1", response.answer_1).replaceAll("#answer_2", response.answer_2).replaceAll("#answer_3", response.answer_3).replaceAll("#correct", response.correct);
                    }
                }
            }
            else {
                alert("Có lỗi xảy ra. Vui lòng thử lại sau.")
            }
        },
        error: function (e) {
            console.log(e);
            alert("Có lỗi xảy ra. Vui lòng thử lại sau.")
        }
    });
}

function delQuestion(a, id_question) {
    //alert(id_question)
    $.ajax({
        url: "/Questions/DeleteQuestion",
        type: "POST",
        data: { id_question: id_question },
        dataType: 'json',
        success: function (response) {
            if (response.status) {
                $(a.parentElement.parentElement.parentElement).remove();
                $("#titleNumberOfQuestion").html($("#titleNumberOfQuestion").html() - 1);
                updateSTT();
            }
            else {
                alert("Có lỗi xảy ra. Vui lòng thử lại sau.")
            }
        },
        error: function (e) {
            console.log(e);
            alert("Có lỗi xảy ra. Vui lòng thử lại sau.")
        }
    });
}