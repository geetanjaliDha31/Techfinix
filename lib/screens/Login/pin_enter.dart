import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/provider/email_provider.dart';

class PinEnterPage extends StatefulWidget {
  const PinEnterPage({super.key});

  @override
  State<PinEnterPage> createState() => _PinEnterPageState();
}

class _PinEnterPageState extends State<PinEnterPage> {
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<EmailAddress>(context).email;
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
                  "Verify your email",
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Please enter the code we sent to email',
                  maxLines: 1,
                  // overflow: TextOverflow.visible,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  email,
                  maxLines: 1,
                  // overflow: TextOverflow.visible,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: color1, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                Pinput(
                  length: 4,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    textStyle: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E2E2),
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: const Color(0xFFE2E2E2), width: 1),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    textStyle: GoogleFonts.inter(
                        fontSize: 24, fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E2E2),
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(color: const Color(0xFFE2E2E2), width: 1),
                    ),
                  ),
                  onCompleted: (pin) {
                    setState(() {
                      print(pin);
                      pinController.text = pin;
                    });
                  },
                  validator: (pin) {
                    if (pin!.length != 4) {
                      return "Enter a valid pin";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Didn't receive the OTP?",
                  maxLines: 1,
                  // overflow: TextOverflow.visible,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: color3,
                      minimumSize: const Size(60, 30),
                      maximumSize: const Size(60, 30),
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    HttpApiCall().resendOTP(
                      context,
                      {
                        'email': email,
                      },
                    );
                  },
                  child: Text(
                    "Resend",
                    maxLines: 1,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        color: color1,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (pinController.text.isNotEmpty) {
                      HttpApiCall().verifyOTP(context, {
                        'email': email,
                        'otp': pinController.text,
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Verify",
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
