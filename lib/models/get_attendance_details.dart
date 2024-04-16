import 'dart:convert';

GetAttendanceDetails GetAttendanceDetailsFromJson(String str) =>
    GetAttendanceDetails.fromJson(json.decode(str));

String GetAttendanceDetailsToJson(GetAttendanceDetails data) =>
    json.encode(data.toJson());

class GetAttendanceDetails {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetAttendanceDetails({this.response, this.error, this.resultArray, this.message});

    GetAttendanceDetails.fromJson(Map<String, dynamic> json) {
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
    String? punchIn;
    String? punchOut;
    String? date;

    ResultArray({this.punchIn, this.punchOut, this.date});

    ResultArray.fromJson(Map<String, dynamic> json) {
        punchIn = json["punch_in"];
        punchOut = json["punch_out"];
        date = json["date"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["punch_in"] = punchIn;
        _data["punch_out"] = punchOut;
        _data["date"] = date;
        return _data;
    }
}