import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/constants.dart';

class ReportCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final Function(List<Map<String, dynamic>>) onItemsChecked;
  final List<Map<String, dynamic>> checkedItems;
  const ReportCard({
    super.key,
    required this.data,
    required this.onItemsChecked,
    required this.checkedItems,
  });

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => PolicyDetailsPage(data: widget.data),
        //   ),
        // );
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: grey3, borderRadius: BorderRadius.circular(5)),
              child: SvgPicture.asset(
                "assets/report.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                width: 15,
                height: 15,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.data['project_name'],
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                  if (isChecked) {
                    widget
                        .onItemsChecked([...widget.checkedItems, widget.data]);
                  } else {
                    widget.onItemsChecked(
                        [...widget.checkedItems]..remove(widget.data));
                  }
                });
              },
              child: Container(
                height: 26,
                width: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isChecked ? color1 : grey3,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: isChecked
                    ? const Icon(
                        CupertinoIcons.checkmark_alt,
                        color: Colors.white,
                        size: 20,
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
