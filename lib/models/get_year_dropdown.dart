import 'dart:convert';

GetYearDropdown GetYearDropdownFromJson(String str) =>
    GetYearDropdown.fromJson(json.decode(str));

String GetYearDropdownToJson(GetYearDropdown data) =>
    json.encode(data.toJson());

class GetYearDropdown {
  String? response;
  bool? error;
  String? message;
  List<YearArray>? yearArray;

  GetYearDropdown({this.response, this.error, this.message, this.yearArray});

  GetYearDropdown.fromJson(Map<String, dynamic> json) {
    response = json["response"];
    error = json["error"];
    message = json["message"];
    yearArray = json["year_array"] == null
        ? null
        : (json["year_array"] as List)
            .map((e) => YearArray.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["response"] = response;
    data["error"] = error;
    data["message"] = message;

    if (yearArray != null) {
      data["year_array"] = yearArray?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class YearArray {
  int? year;

  YearArray({this.year});

  YearArray.fromJson(Map<String, dynamic> json) {
    year = json["year"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["year"] = year;
    return data;
  }
}
