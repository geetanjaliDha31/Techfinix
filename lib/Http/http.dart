// ignore_for_file: use_build_context_synchronously, avoid_print, unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_all_project_list.dart';
import 'package:techfinix/models/get_announcement.dart';
import 'package:techfinix/models/get_attendance_details.dart';
import 'package:techfinix/models/get_expense_card.dart';
import 'package:techfinix/models/get_expense_list.dart';
import 'package:techfinix/models/get_leave_card_details.dart';
import 'package:techfinix/models/get_leaves_status_details.dart';
import 'package:techfinix/models/get_lesson_details.dart';
import 'package:techfinix/models/get_lesson_list.dart';
import 'package:techfinix/models/get_lesson_search.dart';
import 'package:techfinix/models/get_man_hours_list.dart';
import 'package:techfinix/models/get_policy_details.dart';
import 'package:techfinix/models/get_policy_list.dart';
import 'package:techfinix/models/get_policy_search.dart';
import 'package:techfinix/models/get_project_hour_details.dart';
import 'package:techfinix/models/get_salary_list.dart';
import 'package:techfinix/models/get_todays_attendance.dart';
import 'package:techfinix/models/get_year_dropdown.dart';
import 'package:techfinix/models/get_holiday_list.dart';
import 'package:techfinix/screens/Expense%20Claim/expense_claim_page.dart';
import 'package:techfinix/screens/Home/home.dart';
import 'package:techfinix/screens/Leaves/leaves.dart';
import 'package:techfinix/screens/Lesson%20Learnt/lessons.dart';
import 'package:techfinix/screens/Login/login.dart';
import 'package:techfinix/screens/Login/pin_enter.dart';
import 'package:techfinix/screens/Login/reset_password.dart';
import 'package:techfinix/screens/Man%20Hours/man_hours.dart';
import 'package:techfinix/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpApiCall {
  Future<String> retrieveEmpId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("employee id $empId");
    return empId = prefs.getString('emp_id') ?? '';
  }

  Future<void> loginWithPassword(
      BuildContext context, Map<String, dynamic> data) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/loginWithPassword.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      "email": data['email'],
      'password': data['password'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("loginInned", true);
        await prefs.setString("emp_id", d['emp_id'].toString());
        await prefs.setString("name", d['name']);
        await prefs.setString("mobile", d["mobile"]);
        await prefs.setString("email", d["email"]);
        await prefs.setString("designation", d["designation"]);
        await prefs.setString("blood_group", d["blood_group"]);
        const CircularProgressIndicator();
      } else {
        print("Error: ${d['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

 Future<void> deleteAccount(BuildContext context) async {
    String empId = await retrieveEmpId();

    var request =
        http.MultipartRequest('POST', Uri.parse('$mainUrl/delete_account.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
          (route) => false,
        );
      } else {
        print("Error: ${d['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }


  Future<void> forgetPassword(
      BuildContext context, Map<String, dynamic> data) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/forget_password.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      "email": data['email'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PinEnterPage(),
          ),
        );
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> verifyOTP(
      BuildContext context, Map<String, dynamic> data) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$mainUrl/verify_otp.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'otp': data['otp'],
      "email": data['email'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("emp_id", d['emp_id'].toString());
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResetPasswordPage(),
          ),
        );
      } else {
        print("Error: ${d['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> resendOTP(
      BuildContext context, Map<String, dynamic> data) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$mainUrl/resendOTP.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      "email": data['email'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      showToast(context, d['message'], 3);
      print(d['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> updatePassword(
      BuildContext context, Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/update_password.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      'new_password': data['new_password'],
      "confirm_password": data['confirm_password'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        print("Error: ${d['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> changePassword(
      BuildContext context, Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/change_password.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      'current_password': data['current_password'],
      'new_password': data['new_password'],
      "confirm_password": data['confirm_password'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        print("Error: ${d['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> addProjectFeedback(
      BuildContext context, Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/add_project_feedback.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      'project_id': data['project_id'],
      "department_id": data['department_id'],
      "scope": data['scope'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        print("Error: ${d['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> addExpense(
      BuildContext context, Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request =
        http.MultipartRequest('POST', Uri.parse('$mainUrl/add_voucher.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'employee_tbl_id': empId,
      "voucher_date": data['voucher_date'],
      'project_id': data['project_id'],
      "vouchers_details": data['vouchers_details'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ExpenseClaimPage(),
          ),
        );
      } else {
        print("Error: ${d['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<GetExpenseList?> getExpenseList(
      // Map<String, dynamic> data
      ) async {
    String empId = await retrieveEmpId();
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_voucher_list.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetExpenseListFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<GetExpenseCard?> getSingleExpenseCard(
      Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_single_voucher.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      'voucher_id': data['voucher_id'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetExpenseCardFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<Map<String, dynamic>> getDropdownData() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_all_parameters.php'));
    request.fields.addAll({
      'API_KEY': apikey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return json.decode(responsedata.body) as Map<String, dynamic>;
    } else {
      print(response.reasonPhrase);
      return {};
    }
  }

  Future<GetTodaysAttendance?> getTodaysAttendance() async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_todays_attendence.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetTodaysAttendanceFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<GetAttendanceDetails?> getAttendanceDetails(
      Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_attendence_details.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      'month_id': data['month_id'],
      'year': data['year'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetAttendanceDetailsFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<GetManHoursList?> getManhoursList() async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_manhours_list.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetManHoursListFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<GetAllProjectList?> getAllProjectList() async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_all_projects.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetAllProjectListFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<GetProjectHourDetails?> getProjectHourDetails(
      Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_project_hours_details.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      'project_id': data['project_id'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetProjectHourDetailsFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<GetSalaryList?> getSalaryList() async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_salary_list.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetSalaryListFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<HolidayList?> getHolidayList() async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_holiday_list.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return HolidayListFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<LeaveStatusDetails?> getLeavesStatusDetails() async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_leave_status_details.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return LeaveStatusDetailsFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<void> applyLeave(
      BuildContext context, Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request =
        http.MultipartRequest('POST', Uri.parse('$mainUrl/apply_leaves.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      "start_date": data['start_date'],
      'end_date': data['end_date'],
      "leave_type": data['leave_type'],
      "reason": data['reason'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LeavesPage(),
          ),
        );
      } else {
        print("Error: ${d['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<LeaveCardDetails?> getLeaveCardDetails() async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_leave_details.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return LeaveCardDetailsFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<void> addManHours(
      BuildContext context, Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request =
        http.MultipartRequest('POST', Uri.parse('$mainUrl/add_man_hours.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'employee_tbl_id': empId,
      "date": data['date'],
      'project_details': data['project_details'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ManHoursPage(),
          ),
        );
      } else {
        print("Error: ${d['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<GetPolicyList?> getPolicyList() async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_policy_list.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetPolicyListFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<GetPolicyDetails?> getPolicyDetails(Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_policy_details.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      'policies_tbl_id': data['policies_tbl_id'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetPolicyDetailsFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<GetLessonList?> getLessonList() async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_lesson_list.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetLessonListFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<GetLessonDetails?> getLessonDetails(Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_lesson_details.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      'lesson_id': data['lesson_id'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetLessonDetailsFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<SearchLesson?> getLessonSearch(Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request =
        http.MultipartRequest('POST', Uri.parse('$mainUrl/searchLesson.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      'keyword': data['keyword'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return SearchLessonFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<void> addLesson(
      BuildContext context, Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request =
        http.MultipartRequest('POST', Uri.parse('$mainUrl/add_lesson.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      "project_id": data['project_id'],
      'department_id': data['department_id'],
      'prepared_by': data['prepared_by'],
      'subject': data['subject'],
      'problem': data['problem'],
      'solution': data['solution'],
      'lesson': data['lesson'],
      'lesson_img': data['lesson_img'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final d = json.decode(responsedata.body) as Map<String, dynamic>;

      print(d['message']);
      showToast(context, d['message'], 3);
      if (d['error'] == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LessonsListPage(),
          ),
        );
      } else {
        print("Error: ${d['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<SearchPolicy?> getPolicySearch(Map<String, dynamic> data) async {
    String empId = await retrieveEmpId();

    var request =
        http.MultipartRequest('POST', Uri.parse('$mainUrl/searchPolicies.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
      'keyword': data['keyword'],
      'index': data['index'],
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return SearchPolicyFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  Future<GetAnnouncement?> getAnnouncement() async {
    String empId = await retrieveEmpId();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainUrl/get_announcement.php'));
    request.fields.addAll({
      'API_KEY': apikey,
      'emp_id': empId,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return GetAnnouncementFromJson(responsedata.body);
    } else {
      print("in else");
      print(response.reasonPhrase);
    }
    return null;
  }

  // Future<GetYearDropdown?> getYearDropdown() async {
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('$mainUrl/get_all_parameters.php'));
  //   request.fields.addAll({
  //     'API_KEY': apikey,
  //   });

  //   http.StreamedResponse response = await request.send();
  //   var responsedata = await http.Response.fromStream(response);

  //   if (response.statusCode == 200) {
  //     return GetYearDropdownFromJson(responsedata.body);
  //   } else {
  //     print("in else");
  //     print(response.reasonPhrase);
  //   }
  //   return null;
  // }
}
