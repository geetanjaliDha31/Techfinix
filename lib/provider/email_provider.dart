import 'package:flutter/cupertino.dart';

class EmailAddress extends ChangeNotifier {
  String email = '';

  String get emailAddress => email;

  void setEmailAddress(String newemailAddress) {
    email = newemailAddress;
    notifyListeners();
  }
}
