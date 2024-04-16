import 'dart:convert';

HolidayList HolidayListFromJson(String str) =>
    HolidayList.fromJson(json.decode(str));

String HolidayListToJson(HolidayList data) =>
    json.encode(data.toJson());

class HolidayList {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    HolidayList({this.response, this.error, this.resultArray, this.message});

    HolidayList.fromJson(Map<String, dynamic> json) {
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
    String? day;
    String? occasionName;

    ResultArray({this.date, this.day, this.occasionName});

    ResultArray.fromJson(Map<String, dynamic> json) {
        date = json["date"];
        day = json["day"];
        occasionName = json["occasion_name"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["date"] = date;
        _data["day"] = day;
        _data["occasion_name"] = occasionName;
        return _data;
    }
}