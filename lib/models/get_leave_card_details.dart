import 'dart:convert';

LeaveCardDetails LeaveCardDetailsFromJson(String str) =>
    LeaveCardDetails.fromJson(json.decode(str));

String LeaveCardDetailsToJson(LeaveCardDetails data) =>
    json.encode(data.toJson());

class LeaveCardDetails {
    String? response;
    bool? error;
    List<ResultArray>? resultArray;
    String? message;

    LeaveCardDetails({this.response, this.error, this.resultArray, this.message});

    LeaveCardDetails.fromJson(Map<String, dynamic> json) {
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
    List<TotalLeaveCountArray>? totalLeaveCountArray;
    List<CasualLeaveCountArray>? casualLeaveCountArray;
    List<SickLeaveCountArray>? sickLeaveCountArray;
    List<PrivilegeLeaveCountArray>? privilegeLeaveCountArray;
    List<OutdoorActivityCountArray>? outdoorActivityCountArray;
    List<CompOffCountArray>? compOffCountArray;

    ResultArray({this.totalLeaveCountArray, this.casualLeaveCountArray, this.sickLeaveCountArray, this.privilegeLeaveCountArray, this.outdoorActivityCountArray, this.compOffCountArray});

    ResultArray.fromJson(Map<String, dynamic> json) {
        totalLeaveCountArray = json["total_leave_count_array"] == null ? null : (json["total_leave_count_array"] as List).map((e) => TotalLeaveCountArray.fromJson(e)).toList();
        casualLeaveCountArray = json["casual_leave_count_array"] == null ? null : (json["casual_leave_count_array"] as List).map((e) => CasualLeaveCountArray.fromJson(e)).toList();
        sickLeaveCountArray = json["sick_leave_count_array"] == null ? null : (json["sick_leave_count_array"] as List).map((e) => SickLeaveCountArray.fromJson(e)).toList();
        privilegeLeaveCountArray = json["privilege_leave_count_array"] == null ? null : (json["privilege_leave_count_array"] as List).map((e) => PrivilegeLeaveCountArray.fromJson(e)).toList();
        outdoorActivityCountArray = json["outdoor_activity_count_array"] == null ? null : (json["outdoor_activity_count_array"] as List).map((e) => OutdoorActivityCountArray.fromJson(e)).toList();
        compOffCountArray = json["comp_off_count_array"] == null ? null : (json["comp_off_count_array"] as List).map((e) => CompOffCountArray.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(totalLeaveCountArray != null) {
            _data["total_leave_count_array"] = totalLeaveCountArray?.map((e) => e.toJson()).toList();
        }
        if(casualLeaveCountArray != null) {
            _data["casual_leave_count_array"] = casualLeaveCountArray?.map((e) => e.toJson()).toList();
        }
        if(sickLeaveCountArray != null) {
            _data["sick_leave_count_array"] = sickLeaveCountArray?.map((e) => e.toJson()).toList();
        }
        if(privilegeLeaveCountArray != null) {
            _data["privilege_leave_count_array"] = privilegeLeaveCountArray?.map((e) => e.toJson()).toList();
        }
        if(outdoorActivityCountArray != null) {
            _data["outdoor_activity_count_array"] = outdoorActivityCountArray?.map((e) => e.toJson()).toList();
        }
        if(compOffCountArray != null) {
            _data["comp_off_count_array"] = compOffCountArray?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class CompOffCountArray {
    int? balanceCompOff;
    int? appliedCompOff;
    int? totalCompOff;

    CompOffCountArray({this.balanceCompOff, this.appliedCompOff, this.totalCompOff});

    CompOffCountArray.fromJson(Map<String, dynamic> json) {
        balanceCompOff = json["balance_comp_off"];
        appliedCompOff = json["applied_comp_off"];
        totalCompOff = json["total_comp_off"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["balance_comp_off"] = balanceCompOff;
        _data["applied_comp_off"] = appliedCompOff;
        _data["total_comp_off"] = totalCompOff;
        return _data;
    }
}

class OutdoorActivityCountArray {
    int? balanceOutddorActivity;
    int? appliedOutdoorActivity;
    int? totalOutddorActivity;

    OutdoorActivityCountArray({this.balanceOutddorActivity, this.appliedOutdoorActivity, this.totalOutddorActivity});

    OutdoorActivityCountArray.fromJson(Map<String, dynamic> json) {
        balanceOutddorActivity = json["balance_outddor_activity"];
        appliedOutdoorActivity = json["applied_outdoor_activity"];
        totalOutddorActivity = json["total_outddor_activity"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["balance_outddor_activity"] = balanceOutddorActivity;
        _data["applied_outdoor_activity"] = appliedOutdoorActivity;
        _data["total_outddor_activity"] = totalOutddorActivity;
        return _data;
    }
}

class PrivilegeLeaveCountArray {
    int? balancePrivledgeLeaves;
    int? appliedPrivilegeLeaves;
    int? totalPrivilegeLeaves;

    PrivilegeLeaveCountArray({this.balancePrivledgeLeaves, this.appliedPrivilegeLeaves, this.totalPrivilegeLeaves});

    PrivilegeLeaveCountArray.fromJson(Map<String, dynamic> json) {
        balancePrivledgeLeaves = json["balance_privledge_leaves"];
        appliedPrivilegeLeaves = json["applied_privilege_leaves"];
        totalPrivilegeLeaves = json["total_privilege_leaves"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["balance_privledge_leaves"] = balancePrivledgeLeaves;
        _data["applied_privilege_leaves"] = appliedPrivilegeLeaves;
        _data["total_privilege_leaves"] = totalPrivilegeLeaves;
        return _data;
    }
}

class SickLeaveCountArray {
    int? balanceLeaves;
    int? appliedSickLeaves;
    int? totalLeaves;

    SickLeaveCountArray({this.balanceLeaves, this.appliedSickLeaves, this.totalLeaves});

    SickLeaveCountArray.fromJson(Map<String, dynamic> json) {
        balanceLeaves = json["balance_leaves"];
        appliedSickLeaves = json["applied_sick_leaves"];
        totalLeaves = json["total_leaves"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["balance_leaves"] = balanceLeaves;
        _data["applied_sick_leaves"] = appliedSickLeaves;
        _data["total_leaves"] = totalLeaves;
        return _data;
    }
}

class CasualLeaveCountArray {
    int? balanceLeaves;
    int? appliedCasualLeaves;
    int? totalLeaves;

    CasualLeaveCountArray({this.balanceLeaves, this.appliedCasualLeaves, this.totalLeaves});

    CasualLeaveCountArray.fromJson(Map<String, dynamic> json) {
        balanceLeaves = json["balance_leaves"];
        appliedCasualLeaves = json["applied_casual_leaves"];
        totalLeaves = json["total_leaves"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["balance_leaves"] = balanceLeaves;
        _data["applied_casual_leaves"] = appliedCasualLeaves;
        _data["total_leaves"] = totalLeaves;
        return _data;
    }
}

class TotalLeaveCountArray {
    int? balanceLeaves;
    int? appliedLeaves;
    int? totalLeaves;

    TotalLeaveCountArray({this.balanceLeaves, this.appliedLeaves, this.totalLeaves});

    TotalLeaveCountArray.fromJson(Map<String, dynamic> json) {
        balanceLeaves = json["balance_leaves"];
        appliedLeaves = json["applied_leaves"];
        totalLeaves = json["total_leaves"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["balance_leaves"] = balanceLeaves;
        _data["applied_leaves"] = appliedLeaves;
        _data["total_leaves"] = totalLeaves;
        return _data;
    }
}