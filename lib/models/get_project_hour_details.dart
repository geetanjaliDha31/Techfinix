import 'dart:convert';

GetProjectHourDetails GetProjectHourDetailsFromJson(String str) =>
    GetProjectHourDetails.fromJson(json.decode(str));

String GetProjectHourDetailsToJson(GetProjectHourDetails data) =>
    json.encode(data.toJson());

class GetProjectHourDetails {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetProjectHourDetails({this.response, this.error, this.resultArray, this.message});

    GetProjectHourDetails.fromJson(Map<String, dynamic> json) {
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
    List<ProjectDetailsArray>? projectDetailsArray;

    ResultArray({this.projectDetailsArray});

    ResultArray.fromJson(Map<String, dynamic> json) {
        projectDetailsArray = json["project_details_array"] == null ? null : (json["project_details_array"] as List).map((e) => ProjectDetailsArray.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(projectDetailsArray != null) {
            _data["project_details_array"] = projectDetailsArray?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class ProjectDetailsArray {
    String? workHours;
    String? activity;
    String? date;

    ProjectDetailsArray({this.workHours, this.activity, this.date});

    ProjectDetailsArray.fromJson(Map<String, dynamic> json) {
        workHours = json["work_hours"];
        activity = json["activity"];
        date = json["date"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["work_hours"] = workHours;
        _data["activity"] = activity;
        _data["date"] = date;
        return _data;
    }
}