import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/constants.dart';

class LeavesSmallCountCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const LeavesSmallCountCard({super.key, required this.data});

  @override
  State<LeavesSmallCountCard> createState() => _LeavesSmallCountCardState();
}

class _LeavesSmallCountCardState extends State<LeavesSmallCountCard> {
  @override
  void initState() {
    // TODO: implement initState
    assignColor();
    super.initState();
  }

  Color mainColor = color1;
  Color secColor = color3;
  void assignColor() {
    if (widget.data['title'] == "Applied") {
      mainColor = green1;
      secColor = green2.withOpacity(0.7);
    }
    if (widget.data['title'] == "Total") {
      mainColor = black2;
      secColor = grey3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            widget.data['count'],
            style:GoogleFonts.inter(
              color: mainColor,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          Text(
            widget.data['title'],
            style: GoogleFonts.inter(
              color: mainColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
