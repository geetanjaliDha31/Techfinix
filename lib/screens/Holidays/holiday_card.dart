import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/constants.dart';

class HolidayCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const HolidayCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime currentDate = DateTime.now();
    // Parse the holiday date
    DateTime holidayDate = _parseDate(data['date']);
    // Check if the holiday date is in the past
    bool isPastDate = holidayDate.isBefore(currentDate);

    // Define the color of the first container based on whether the date is past or not
    Color firstContainerColor = isPastDate ? Colors.grey : color1;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 80,
            decoration: BoxDecoration(
              color: firstContainerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 15, 22, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_sharp,
                            size: 15,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            data['date'],
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data['event'],
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  Text(
                    data['day'],
                    style: GoogleFonts.inter(
                      color: grey1,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Function to parse the custom date format
  DateTime _parseDate(String dateString) {
    // Split the date string into day, month, and year parts
    List<String> parts = dateString.split(" ");
    int day = int.parse(parts[0]);
    String monthName = parts[1];
    int year = int.parse(parts[2]);

    // Create a DateFormat for parsing month names
    DateFormat monthFormat = DateFormat('MMMM', 'en_US');
    // Parse the month name to get its numeric representation
    int month = monthFormat.parse(monthName).month;

    // Create a DateTime object with the parsed values
    return DateTime(year, month, day);
  }
}
