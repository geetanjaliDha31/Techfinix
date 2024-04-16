import 'dart:convert';

GetLessonDetails GetLessonDetailsFromJson(String str) =>
    GetLessonDetails.fromJson(json.decode(str));

String GetLessonDetailsToJson(GetLessonDetails data) =>
    json.encode(data.toJson());

class GetLessonDetails {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetLessonDetails({this.response, this.error, this.resultArray, this.message});

    GetLessonDetails.fromJson(Map<String, dynamic> json) {
        response = json["response"];
        error = json["error"];
        resultArray = json["result_array"] == null ? null : (json["result_array"] as List).map((e) => ResultArray.fromJson(e)).toList();
        message = json["message"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["response"] = response;
        _data["error"] = error;
        if(resultArray != null) {
            _data["result_array"] = resultArray?.map((e) => e.toJson()).toList();
        }
        _data["message"] = message;
        return _data;
    }
}

class ResultArray {
    int? lessonId;
    String? projectName;
    String? departmentName;
    String? subject;
    String? problem;
    String? solution;
    String? lesson;
    String? lessonImage;

    ResultArray({this.lessonId, this.projectName, this.departmentName, this.subject, this.problem, this.solution, this.lesson, this.lessonImage});

    ResultArray.fromJson(Map<String, dynamic> json) {
        lessonId = json["lesson_id"];
        projectName = json["project_name"];
        departmentName = json["department_name"];
        subject = json["subject"];
        problem = json["problem"];
        solution = json["solution"];
        lesson = json["lesson"];
        lessonImage = json["lesson_image"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["lesson_id"] = lessonId;
        _data["project_name"] = projectName;
        _data["department_name"] = departmentName;
        _data["subject"] = subject;
        _data["problem"] = problem;
        _data["solution"] = solution;
        _data["lesson"] = lesson;
        _data["lesson_image"] = lessonImage;
        return _data;
    }
}