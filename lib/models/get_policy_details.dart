import 'dart:convert';

GetPolicyDetails GetPolicyDetailsFromJson(String str) =>
    GetPolicyDetails.fromJson(json.decode(str));

String GetPolicyDetailsToJson(GetPolicyDetails data) =>
    json.encode(data.toJson());

class GetPolicyDetails {
  String? response;
  bool? error;
  List<ResultArray>? resultArray;
  String? message;

  GetPolicyDetails({this.response, this.error, this.resultArray, this.message});

  GetPolicyDetails.fromJson(Map<String, dynamic> json) {
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
  int? policiesTblId;
  String? policiesId;
  String? policyName;
  String? policyDescription;

  ResultArray(
      {this.policiesTblId,
      this.policiesId,
      this.policyName,
      this.policyDescription});

  ResultArray.fromJson(Map<String, dynamic> json) {
    policiesTblId = json["policies_tbl_id"];
    policiesId = json["policies_id"];
    policyName = json["policy_name"];
    policyDescription = json["policy_description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["policies_tbl_id"] = policiesTblId;
    _data["policies_id"] = policiesId;
    _data["policy_name"] = policyName;
    _data["policy_description"] = policyDescription;
    return _data;
  }
}
