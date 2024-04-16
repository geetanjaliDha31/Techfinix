import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/constants.dart';

class AttendanceCardHome extends StatefulWidget {
  final Map<String, dynamic> data;
  const AttendanceCardHome({super.key, required this.data});

  @override
  State<AttendanceCardHome> createState() => _AttendanceCardHomeState();
}

class _AttendanceCardHomeState extends State<AttendanceCardHome> {
  IconData iconFetcher() {
    if (widget.data['context'] == "Punch In") {
      return Icons.login_outlined;
    } else if (widget.data['context'] == "Punch Out") {
      return Icons.logout_rounded;
    } else if (widget.data['context'] == 'Total Hours') {
      return Icons.chair_alt_rounded;
    } else {
      return Icons.access_time;
    }
  }

  Color mainColor = grey1;
  void assignColor() {
    if (widget.data['remark'] == "Punched In Late") {
      mainColor = red1;
    }
    if (widget.data['remark'] == "Punched out early") {
      mainColor = red1;
    }
    if (widget.data['remark'] == "On Time") {
      mainColor = green1;
    }
  }

  @override
  Widget build(BuildContext context) {
    assignColor();
    return Container(
      width: 139,
      height: 90,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 22,
                width: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color3,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  iconFetcher(),
                  size: 15,
                  color: color1,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.data['context'],
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: grey2,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            widget.data['time'],
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: black1,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.data['remark'],
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: mainColor,
            ),
          )
        ],
      ),
    );
  }
}
