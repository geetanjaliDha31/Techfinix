import 'dart:convert';

SearchPolicy SearchPolicyFromJson(String str) =>
    SearchPolicy.fromJson(json.decode(str));

String SearchPolicyToJson(SearchPolicy data) =>
    json.encode(data.toJson());

class SearchPolicy {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    SearchPolicy({this.response, this.error, this.resultArray, this.message});

    SearchPolicy.fromJson(Map<String, dynamic> json) {
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
    int? policiesTblId;
    String? policiesId;
    String? policyName;

    ResultArray({this.policiesTblId, this.policiesId, this.policyName});

    ResultArray.fromJson(Map<String, dynamic> json) {
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