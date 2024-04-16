import 'dart:convert';

GetAnnouncement GetAnnouncementFromJson(String str) =>
    GetAnnouncement.fromJson(json.decode(str));

String GetAnnouncementToJson(GetAnnouncement data) =>
    json.encode(data.toJson());

class GetAnnouncement {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetAnnouncement({this.response, this.error, this.resultArray, this.message});

    GetAnnouncement.fromJson(Map<String, dynamic> json) {
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
    String? announcement;

    ResultArray({this.announcement});

    ResultArray.fromJson(Map<String, dynamic> json) {
        announcement = json["announcement"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["announcement"] = announcement;
        return _data;
    }
}