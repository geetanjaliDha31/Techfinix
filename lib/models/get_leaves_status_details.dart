import 'dart:convert';

LeaveStatusDetails LeaveStatusDetailsFromJson(String str) =>
    LeaveStatusDetails.fromJson(json.decode(str));

String LeaveStatusDetailsToJson(LeaveStatusDetails data) =>
    json.encode(data.toJson());

class LeaveStatusDetails {
  String? response;
  bool? error;
  List<ResultArray>? resultArray;
  String? message;

  LeaveStatusDetails(
      {this.response, this.error, this.resultArray, this.message});

  LeaveStatusDetails.fromJson(Map<String, dynamic> json) {
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
  List<LeaveArray>? leaveArray;

  ResultArray({this.leaveArray});

  ResultArray.fromJson(Map<String, dynamic> json) {
    leaveArray = json["leave_array"] == null
        ? null
        : (json["leave_array"] as List)
            .map((e) => LeaveArray.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (leaveArray != null) {
      _data["leave_array"] = leaveArray?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class LeaveArray {
  String? startDate;
  String? endDate;
  String? leaveName;
  int? applyDays;
  int? balanceLeave;
  String? status;

  LeaveArray(
      {this.startDate,
      this.endDate,
      this.leaveName,
      this.applyDays,
      this.balanceLeave,
      this.status});

  LeaveArray.fromJson(Map<String, dynamic> json) {
    startDate = json["start_date"];
    endDate = json["end_date"];
    leaveName = json["leave_name"];
    applyDays = json["apply_days"];
    balanceLeave = json["balance_leave"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["start_date"] = startDate;
    _data["end_date"] = endDate;
    _data["leave_name"] = leaveName;
    _data["apply_days"] = applyDays;
    _data["balance_leave"] = balanceLeave;
    _data["status"] = status;
    return _data;
  }
}
