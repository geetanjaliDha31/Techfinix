import 'dart:convert';

GetAllProjectList GetAllProjectListFromJson(String str) =>
    GetAllProjectList.fromJson(json.decode(str));

String GetAllProjectListToJson(GetAllProjectList data) =>
    json.encode(data.toJson());

class GetAllProjectList {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    GetAllProjectList({this.response, this.error, this.resultArray, this.message});

    GetAllProjectList.fromJson(Map<String, dynamic> json) {
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
    List<ProjectArray>? projectArray;

    ResultArray({this.projectArray});

    ResultArray.fromJson(Map<String, dynamic> json) {
        projectArray = json["project_array"] == null ? null : (json["project_array"] as List).map((e) => ProjectArray.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(projectArray != null) {
            _data["project_array"] = projectArray?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class ProjectArray {
    String? projectId;
    String? projectName;
    String? hoursRemaining;
    int? totalPrecentage;
    String? projectStatus;
    List<ProfilePhotoArray>? profilePhotoArray;

    ProjectArray({this.projectId, this.projectName, this.hoursRemaining, this.totalPrecentage, this.projectStatus, this.profilePhotoArray});

    ProjectArray.fromJson(Map<String, dynamic> json) {
        projectId = json["project_id"];
        projectName = json["project_name"];
        hoursRemaining = json["hours_remaining"];
        totalPrecentage = json["total_precentage"];
        projectStatus = json["project_status"];
        profilePhotoArray = json["profile_photo_array"] == null ? null : (json["profile_photo_array"] as List).map((e) => ProfilePhotoArray.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["project_id"] = projectId;
        _data["project_name"] = projectName;
        _data["hours_remaining"] = hoursRemaining;
        _data["total_precentage"] = totalPrecentage;
        _data["project_status"] = projectStatus;
        if(profilePhotoArray != null) {
            _data["profile_photo_array"] = profilePhotoArray?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class ProfilePhotoArray {
    String? profilePhoto;

    ProfilePhotoArray({this.profilePhoto});

    ProfilePhotoArray.fromJson(Map<String, dynamic> json) {
        profilePhoto = json["profile_photo"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["profile_photo"] = profilePhoto;
        return _data;
    }
}