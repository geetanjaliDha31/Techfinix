// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/constants.dart';

class LeavesListCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const LeavesListCard({
    super.key,
    required this.data,
  });

  @override
  State<LeavesListCard> createState() => _LeavesListCardState();
}

class _LeavesListCardState extends State<LeavesListCard> {
  void initState() {
    // TODO: implement initState
    assignColor();
    super.initState();
  }

  Color mainColor = color1;
  Color secColor = color3;
  void assignColor() {
    if (widget.data['title'] == "Applied") {
   
    }
    if (widget.data['title'] == "Total") {
      mainColor = black2;
      secColor = grey3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: Container(
            height: 35,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(40, 2, 40, 2),
            decoration: BoxDecoration(
              color: color1,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Center(
              child: Text(
                widget.data['leave_type'],
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Container(
            height: 90,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 80,
                  height: 68,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: mainColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.data['balance_count'],
                        style: GoogleFonts.inter(
                          color: mainColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Balance',
                        style: GoogleFonts.inter(
                          color: mainColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  height: 68,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: green2.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: green1,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.data['applied_count'],
                        style: GoogleFonts.inter(
                          color: green1,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Applied',
                        style: GoogleFonts.inter(
                          color: green1,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  height: 68,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: grey3,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: black2,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.data['total_count'],
                        style: GoogleFonts.inter(
                          color: black2,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Total',
                        style: GoogleFonts.inter(
                          color: black2,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
