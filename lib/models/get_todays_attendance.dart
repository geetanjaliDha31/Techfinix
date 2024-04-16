import 'dart:convert';

GetTodaysAttendance GetTodaysAttendanceFromJson(String str) =>
    GetTodaysAttendance.fromJson(json.decode(str));

String GetTodaysAttendanceToJson(GetTodaysAttendance data) =>
    json.encode(data.toJson());

class GetTodaysAttendance {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetTodaysAttendance({this.response, this.error, this.resultArray, this.message});

    GetTodaysAttendance.fromJson(Map<String, dynamic> json) {
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
    List<PunchInArray>? punchInArray;
    List<PunchOutArray>? punchOutArray;
    List<TotalHoursArray>? totalHoursArray;

    ResultArray({this.punchInArray, this.punchOutArray, this.totalHoursArray});

    ResultArray.fromJson(Map<String, dynamic> json) {
        punchInArray = json["punch_in_array"] == null ? null : (json["punch_in_array"] as List).map((e) => PunchInArray.fromJson(e)).toList();
        punchOutArray = json["punch_out_array"] == null ? null : (json["punch_out_array"] as List).map((e) => PunchOutArray.fromJson(e)).toList();
        totalHoursArray = json["total_hours_array"] == null ? null : (json["total_hours_array"] as List).map((e) => TotalHoursArray.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(punchInArray != null) {
            _data["punch_in_array"] = punchInArray?.map((e) => e.toJson()).toList();
        }
        if(punchOutArray != null) {
            _data["punch_out_array"] = punchOutArray?.map((e) => e.toJson()).toList();
        }
        if(totalHoursArray != null) {
            _data["total_hours_array"] = totalHoursArray?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class TotalHoursArray {
    String? totalHours;

    TotalHoursArray({this.totalHours});

    TotalHoursArray.fromJson(Map<String, dynamic> json) {
        totalHours = json["total_hours"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["total_hours"] = totalHours;
        return _data;
    }
}

class PunchOutArray {
    String? punchOut;
    String? status;

    PunchOutArray({this.punchOut, this.status});

    PunchOutArray.fromJson(Map<String, dynamic> json) {
        punchOut = json["punch_out"];
        status = json["status"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["punch_out"] = punchOut;
        _data["status"] = status;
        return _data;
    }
}

class PunchInArray {
    String? punchIn;
    String? status;

    PunchInArray({this.punchIn, this.status});

    PunchInArray.fromJson(Map<String, dynamic> json) {
        punchIn = json["punch_in"];
        status = json["status"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["punch_in"] = punchIn;
        _data["status"] = status;
        return _data;
    }
}