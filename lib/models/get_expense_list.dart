import 'dart:convert';

GetExpenseList GetExpenseListFromJson(String str) =>
    GetExpenseList.fromJson(json.decode(str));

String GetExpenseListToJson(GetExpenseList data) => json.encode(data.toJson());

class GetExpenseList {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetExpenseList({this.response, this.error, this.resultArray, this.message});

    GetExpenseList.fromJson(Map<String, dynamic> json) {
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
    int? voucherId;
    String? voucherNo;
    String? voucherDate;
    String? projectName;
    int? amount;
    String? departmentName;
    String? status;

    ResultArray({this.voucherId, this.voucherNo, this.voucherDate, this.projectName, this.amount, this.departmentName, this.status});

    ResultArray.fromJson(Map<String, dynamic> json) {
        voucherId = json["voucher_id"];
        voucherNo = json["voucher_no"];
        voucherDate = json["voucher_date"];
        projectName = json["project_name"];
        amount = json["amount"];
        departmentName = json["department_name"];
        status = json["status"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["voucher_id"] = voucherId;
        _data["voucher_no"] = voucherNo;
        _data["voucher_date"] = voucherDate;
        _data["project_name"] = projectName;
        _data["amount"] = amount;
        _data["department_name"] = departmentName;
        _data["status"] = status;
        return _data;
    }
}