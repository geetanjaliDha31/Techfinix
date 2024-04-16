import 'dart:convert';

GetManHoursList GetManHoursListFromJson(String str) =>
    GetManHoursList.fromJson(json.decode(str));

String GetManHoursListToJson(GetManHoursList data) =>
    json.encode(data.toJson());


class GetManHoursList {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetManHoursList({this.response, this.error, this.resultArray, this.message});

    GetManHoursList.fromJson(Map<String, dynamic> json) {
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
    String? date;
    List<Timeline>? timeline;

    ResultArray({this.date, this.timeline});

    ResultArray.fromJson(Map<String, dynamic> json) {
        date = json["date"];
        timeline = json["timeline"] == null ? null : (json["timeline"] as List).map((e) => Timeline.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["date"] = date;
        if(timeline != null) {
            _data["timeline"] = timeline?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Timeline {
    String? projectName;
    String? timeWorked;

    Timeline({this.projectName, this.timeWorked});

    Timeline.fromJson(Map<String, dynamic> json) {
        projectName = json["project_name"];
        timeWorked = json["time_worked"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["project_name"] = projectName;
        _data["time_worked"] = timeWorked;
        return _data;
    }
}