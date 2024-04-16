import 'dart:convert';

GetExpenseCard GetExpenseCardFromJson(String str) =>
    GetExpenseCard.fromJson(json.decode(str));

String GetExpenseCardToJson(GetExpenseCard data) => json.encode(data.toJson());

class GetExpenseCard {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetExpenseCard({this.response, this.error, this.resultArray, this.message});

    GetExpenseCard.fromJson(Map<String, dynamic> json) {
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
    List<VoucherArray>? voucherArray;
    List<VoucherDetailsArray>? voucherDetailsArray;

    ResultArray({this.voucherArray, this.voucherDetailsArray});

    ResultArray.fromJson(Map<String, dynamic> json) {
        voucherArray = json["voucher_array"] == null ? null : (json["voucher_array"] as List).map((e) => VoucherArray.fromJson(e)).toList();
        voucherDetailsArray = json["voucher_details_array"] == null ? null : (json["voucher_details_array"] as List).map((e) => VoucherDetailsArray.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(voucherArray != null) {
            _data["voucher_array"] = voucherArray?.map((e) => e.toJson()).toList();
        }
        if(voucherDetailsArray != null) {
            _data["voucher_details_array"] = voucherDetailsArray?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class VoucherDetailsArray {
    String? expenseName;
    int? amount;
    String? voucherBill;

    VoucherDetailsArray({this.expenseName, this.amount, this.voucherBill});

    VoucherDetailsArray.fromJson(Map<String, dynamic> json) {
        expenseName = json["expense_name"];
        amount = json["amount"];
        voucherBill = json["voucher_bill"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["expense_name"] = expenseName;
        _data["amount"] = amount;
        _data["voucher_bill"] = voucherBill;
        return _data;
    }
}

class VoucherArray {
    String? voucherDate;
    String? voucherNo;
    String? projectName;
    int? totalAmount;

    VoucherArray({this.voucherDate, this.voucherNo, this.projectName, this.totalAmount});

    VoucherArray.fromJson(Map<String, dynamic> json) {
        voucherDate = json["voucher_date"];
        voucherNo = json["voucher_no"];
        projectName = json["project_name"];
        totalAmount = json["total_amount"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["voucher_date"] = voucherDate;
        _data["voucher_no"] = voucherNo;
        _data["project_name"] = projectName;
        _data["total_amount"] = totalAmount;
        return _data;
    }
}