import 'dart:convert';

GetSalaryList GetSalaryListFromJson(String str) =>
    GetSalaryList.fromJson(json.decode(str));

String GetSalaryListToJson(GetSalaryList data) =>
    json.encode(data.toJson());

class GetSalaryList {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetSalaryList({this.response, this.error, this.resultArray, this.message});

    GetSalaryList.fromJson(Map<String, dynamic> json) {
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
    int? salariesId;
    int? grossSalary;
    int? netSalary;
    String? date;

    ResultArray({this.salariesId, this.grossSalary, this.netSalary, this.date});

    ResultArray.fromJson(Map<String, dynamic> json) {
        salariesId = json["salaries_id"];
        grossSalary = json["gross_salary"];
        netSalary = json["net_salary"];
        date = json["date"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["salaries_id"] = salariesId;
        _data["gross_salary"] = grossSalary;
        _data["net_salary"] = netSalary;
        _data["date"] = date;
        return _data;
    }
}