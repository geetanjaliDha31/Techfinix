import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/screens/Login/forgot_password.dart';
import 'package:techfinix/widgets/textfield.dart';
import 'package:techfinix/widgets/toast.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              Center(
                child: Text(
                  "Login",
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: emailController,
                hinttext: "Email Address",
                isNumber: false,
                obscureText: false,
                label: "",
                icon: Icons.email_rounded,
              ),
              const SizedBox(
                height: 12,
              ),
              TextBox(
                controller: passController,
                hinttext: "Password",
                label: "",
                isPassword: true,
                obscureText: true,
              ),
              Container(
                height: 35,
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.fromLTRB(0, 5, 10, 5)),
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: color1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (passController.text.isNotEmpty) {
                    HttpApiCall().loginWithPassword(
                      context,
                      {
                        "email": emailController.text,
                        "password": passController.text,
                      },
                    );
                  } else {
                    showToast(context, 'All Fields Required', 3);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color1,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "Login",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
