import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/constants.dart';

class LeavesCountCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const LeavesCountCard({super.key, required this.data});

  @override
  State<LeavesCountCard> createState() => _LeavesCountCardState();
}

class _LeavesCountCardState extends State<LeavesCountCard> {
  @override
  void initState() {
    // TODO: implement initState
    assignColor();
    super.initState();
  }

  Color mainColor = color1;
  Color secColor = color3;
  void assignColor() {
    if (widget.data['title'] == "Applied Leaves") {
      mainColor = green1;
      secColor = green2.withOpacity(0.7);
    }
    if (widget.data['title'] == "Total Leaves") {
      mainColor = black2;
      secColor = grey3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 94,
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
            widget.data['title'],
            style: GoogleFonts.inter(
              color: mainColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            widget.data['count'],
            style: GoogleFonts.inter(
              color: mainColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
