import 'dart:convert';

GetLessonList GetLessonListFromJson(String str) =>
    GetLessonList.fromJson(json.decode(str));

String GetLessonListToJson(GetLessonList data) => json.encode(data.toJson());

class GetLessonList {
  String? response;
  bool? error;
  List<ResultArray>? resultArray;
  String? message;

  GetLessonList({this.response, this.error, this.resultArray, this.message});

  GetLessonList.fromJson(Map<String, dynamic> json) {
    response = json["response"];
    error = json["error"];
    resultArray = json["result_array"] == null
        ? null
        : (json["result_array"] as List)
            .map((e) => ResultArray.fromJson(e))
            .toList();
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["response"] = response;
    _data["error"] = error;
    if (resultArray != null) {
      _data["result_array"] = resultArray?.map((e) => e.toJson()).toList();
    }
    _data["message"] = message;
    return _data;
  }
}

class ResultArray {
  String? lessonId;
  String? projectName;
  String? departmentName;
  String? subject;

  ResultArray(
      {this.lessonId, this.projectName, this.departmentName, this.subject});

  ResultArray.fromJson(Map<String, dynamic> json) {
    lessonId = json["lesson_id"];
    projectName = json["project_name"];
    departmentName = json["department_name"];
    subject = json["subject"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["lesson_id"] = lessonId;
    _data["project_name"] = projectName;
    _data["department_name"] = departmentName;
    _data["subject"] = subject;
    return _data;
  }
}
