import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/widgets/textfield.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfPasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 7, 0, 6),
            child: Container(
              // height: 2,
              width: 10,
              decoration: BoxDecoration(
                  border: Border.all(color: grey1, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "Enter New Password",
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                Text(
                  'Enter new password and confirm',
                  maxLines: 1,
                  // overflow: TextOverflow.visible,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),

                TextBox(
                  controller: passwordController,
                  label: "",
                  hinttext: "Password",
                  isPassword: true,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextBox(
                  controller: cnfPasswordcontroller,
                  label: "",
                  hinttext: "Confirm Password",
                  isPassword: true,
                  obscureText: false,
                ),

                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    HttpApiCall().updatePassword(
                      context,
                      {
                        'new_password': passwordController.text,
                        'confirm_password': cnfPasswordcontroller.text,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
