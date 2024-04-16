import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:techfinix/constants.dart';

class ManHoursCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const ManHoursCard({super.key, required this.data});

  @override
  State<ManHoursCard> createState() => _ManHoursCardState();
}

class _ManHoursCardState extends State<ManHoursCard> {
  @override
  Widget build(BuildContext context) {

    DateTime currentDate = DateTime.now();
    String formattedCurrentDate = DateFormat('dd MMM yyyy').format(currentDate);
    bool isToday = (formattedCurrentDate == widget.data['date']);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isToday ? "Today" : widget.data['date'],
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.data['timeline'].length,
          itemBuilder: (context, index) {
            return Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.only(
                  left: 20, right: 15, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data['timeline'][index]["project_name"],
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            widget.data['date'],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: grey1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 0.6,
                    color: grey1,
                  ),
                  Container(
                    width: 15,
                  ),
                  Container(
                    width: 55,
                    // padding: const EdgeInsets.only(top: 5, bottom: 5),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.data['timeline'][index]['time_worked']}",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "hours",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
