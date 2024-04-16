import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/screens/All%20Projects/project_timeline.dart';

class ProjectCardHome extends StatefulWidget {
  final Map<String, dynamic> data;
  const ProjectCardHome({super.key, required this.data});

  @override
  State<ProjectCardHome> createState() => _ProjectCardHomeState();
}

class _ProjectCardHomeState extends State<ProjectCardHome> {
  @override
  void initState() {
    // TODO: implement initState
    colorSet();
    super.initState();
  }

  Color mainColor = color1;
  Color secColor = color3;

  void colorSet() {
    if (widget.data['progress_status'] == "Completed") {
      mainColor = green1;
      secColor = green2.withOpacity(0.7);
    } else if (widget.data['progress_status'] == "Overtime") {
      mainColor = red2;
      secColor = red3.withOpacity(0.7);
    }
  }

  String buildTimeLeftText(String timeLeftData) {
    // Split the string by colon
    List<String> parts = timeLeftData.split(':');
    if (parts.length == 2) {
      // If there are two parts (hours and minutes), parse and format them
      int hours = int.tryParse(parts[0]) ?? 0;
      int minutes = int.tryParse(parts[1]) ?? 0;
      return "$hours h $minutes min left";
    } else {
      // If the format is unexpected, return the string as it is
      return timeLeftData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProjectTimeline(
              data: widget.data,
            ),
          ),
        );
      },
      child: Container(
        height: 130,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: grey3,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.person_3_outlined,
                    size: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    widget.data['project_name'],
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  height: 28,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: secColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      buildTimeLeftText(widget.data['time_left']),
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: mainColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Team Members",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: grey2,
                ),
              ),
            ),
            Container(
              height: 30,
              width: 45 * (widget.data['images'] as List).length.toDouble(),
              margin: const EdgeInsets.only(left: 10),
              child: Stack(
                children: [
                  for (int i = 0;
                      i < (widget.data['images'] as List).length;
                      i++)
                    Positioned(
                      left: 24 * (i).toDouble(),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                widget.data['images'][i],
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3, right: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.data['progress']}%",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: mainColor,
                    ),
                  ),
                  Text(
                    widget.data['progress_status'],
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: widget.data['progress_status'] == "In Progress"
                          ? grey2
                          : mainColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            LinearProgressIndicator(
              value: double.parse(widget.data['progress']) / 100,
              color: mainColor,
              backgroundColor: grey1,
              minHeight: 6,
              borderRadius: BorderRadius.circular(6),
            )
          ],
        ),
      ),
    );
  }
}
