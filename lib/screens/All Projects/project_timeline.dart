// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_project_hour_details.dart';
import 'package:techfinix/screens/All%20Projects/project_timeline_card.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/no_data.dart';

class ProjectTimeline extends StatefulWidget {
  final Map<String, dynamic> data;
  const ProjectTimeline({super.key, required this.data});

  @override
  State<ProjectTimeline> createState() => _ProjectTimelineState();
}

class _ProjectTimelineState extends State<ProjectTimeline> {
  // List<Map<String, dynamic>> data = [
  //   {
  //     //"project_name": "Coastal Roads",
  //     "date": "10 Jan 2024",
  //     "worked_hours": 3,
  //     "desc":
  //         "Implemented user authentication flow and integrated with backend APIs.",
  //   },
  //   {
  //     //"project_name": "Linking Road",
  //     "date": "12 Jan 2024",
  //     "worked_hours": 5,
  //     "desc":
  //         "Resolved critical bugs reported by users and optimized application performance."
  //   },
  //   {
  //     //"project_name": "Expressway road",
  //     "date": "14 Jan 2024",
  //     "worked_hours": 6,
  //     "desc":
  //         "Added new features such as user profile customization and notifications. Also, enhanced existing functionalities."
  //   },
  //   {
  //     "date": "16 Jan 2024",
  //     "worked_hours": 4,
  //     "desc":
  //         "Revamped user interface design, focusing on improving user experience and visual appeal."
  //   },
  //   {
  //     //"project_name": "Flutter Developement",
  //     "date": "18 Jan 2024",
  //     "worked_hours": 7,
  //     "desc":
  //         "Optimized database queries to improve data retrieval speed and overall application responsiveness."
  //   },
  //   {
  //     //"project_name": "Backend development",
  //     "date": "20 Jan 2024",
  //     "worked_hours": 3,
  //     "desc":
  //         "Implemented a robust data caching mechanism to enhance offline user experience."
  //   },
  //   {
  //     //"project_name": "Ulhasnagar Road Development",
  //     "date": "21 Jan 2024",
  //     "worked_hours": 5,
  //     "desc":
  //         "Conducted a code refactoring for better code organization and maintainability, ensuring adherence to best practices."
  //   },
  // ];
  bool isPanelOpen = false;
  final PanelController controller = PanelController();

  void togglePanel() {
    setState(() {
      if (isPanelOpen) {
        controller.close();
        isPanelOpen = false;
      } else {
        controller.open();
        isPanelOpen = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: Container(
          height: 105,
          decoration: BoxDecoration(
            color: color1,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            image: const DecorationImage(
              image: AssetImage("assets/app_bar.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.only(top: 28, bottom: 8),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 31,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                width: 250,
                child: Text(
                  widget.data['project_name'],
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  togglePanel();
                },
                icon: SvgPicture.asset(
                  'assets/loudspeaker.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 22,
                  height: 22,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: HttpApiCall().getProjectHourDetails(
          {
            'project_id': widget.data['project_id'],
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            GetProjectHourDetails project = snapshot.data!;
            final projectHourDetails =
                project.resultArray![0].projectDetailsArray!;
            List<Map<String, dynamic>> data = [];
            for (int i = 0; i < projectHourDetails.length; i++) {
              data.add(
                {
                  'date': projectHourDetails[i].date,
                  'worked_hours': projectHourDetails[i].workHours,
                  'desc': projectHourDetails[i].activity,
                },
              );
            }
            return projectHourDetails.isEmpty
                ? NoDataPage()
                : Stack(
                    children: [
                      SafeArea(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: 10,
                                // ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return ProjectTimelineCard(
                                      data: data[index],
                                      isFirst: index == 0,
                                      isLast: index == data.length - 1,
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SlidingUpPanel(
                        controller: controller,
                        minHeight: 0.0,
                        maxHeight: MediaQuery.of(context).size.height * 0.73,
                        panelBuilder: (sc) {
                          return Announcement(
                            controller: controller,
                          );
                        },
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        // backdropTapClosesPanel: true,
                        // isDraggable: false,
                        backdropEnabled: true,
                        backdropColor: Colors.black,
                        backdropOpacity: 0.4,
                        onPanelClosed: () {
                          isPanelOpen = false;
                        },
                      ),
                    ],
                  );
          } else if (snapshot.hasError) {
            return const Text(
              'Something Went Wrong',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
