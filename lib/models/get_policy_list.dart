import 'dart:convert';

GetPolicyList GetPolicyListFromJson(String str) =>
    GetPolicyList.fromJson(json.decode(str));

String GetPolicyListToJson(GetPolicyList data) =>
    json.encode(data.toJson());

class GetPolicyList {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetPolicyList({this.response, this.error, this.resultArray, this.message});

    GetPolicyList.fromJson(Map<String, dynamic> json) {
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
    List<CompanyPolicyArray>? companyPolicyArray;
    List<HrPolicyArray>? hrPolicyArray;

    ResultArray({this.companyPolicyArray, this.hrPolicyArray});

    ResultArray.fromJson(Map<String, dynamic> json) {
        companyPolicyArray = json["company_policy_array"] == null ? null : (json["company_policy_array"] as List).map((e) => CompanyPolicyArray.fromJson(e)).toList();
        hrPolicyArray = json["hr_policy_array"] == null ? null : (json["hr_policy_array"] as List).map((e) => HrPolicyArray.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(companyPolicyArray != null) {
            _data["company_policy_array"] = companyPolicyArray?.map((e) => e.toJson()).toList();
        }
        if(hrPolicyArray != null) {
            _data["hr_policy_array"] = hrPolicyArray?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class HrPolicyArray {
    int? policiesTblId;
    String? policiesId;
    String? policyName;

    HrPolicyArray({this.policiesTblId, this.policiesId, this.policyName});

    HrPolicyArray.fromJson(Map<String, dynamic> json) {
        policiesTblId = json["policies_tbl_id"];
        policiesId = json["policies_id"];
        policyName = json["policy_name"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["policies_tbl_id"] = policiesTblId;
        _data["policies_id"] = policiesId;
        _data["policy_name"] = policyName;
        return _data;
    }
}

class CompanyPolicyArray {
    int? policiesTblId;
    String? policiesId;
    String? policyName;

    CompanyPolicyArray({this.policiesTblId, this.policiesId, this.policyName});

    CompanyPolicyArray.fromJson(Map<String, dynamic> json) {
        policiesTblId = json["policies_tbl_id"];
        policiesId = json["policies_id"];
        policyName = json["policy_name"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["policies_tbl_id"] = policiesTblId;
        _data["policies_id"] = policiesId;
        _data["policy_name"] = policyName;
        return _data;
    }
}