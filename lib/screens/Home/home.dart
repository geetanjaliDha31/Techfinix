// ignore_for_file: prefer_const_constructors, avoid_print, unused_import

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_all_project_list.dart';
import 'package:techfinix/models/get_todays_attendance.dart';
import 'package:techfinix/screens/All%20Projects/all_projects.dart';
import 'package:techfinix/screens/Home/attendance_card.dart';
import 'package:techfinix/screens/Home/project_card.dart';
import 'package:techfinix/screens/Monthly%20Attendance/monthly_attendace.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/drawer.dart';
import 'package:techfinix/widgets/no_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedValue = "Today";
  String name = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? '';
    });
  }

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

  // List<Map<String, dynamic>> attendanceCard = [
  //   {
  //     "context": "Punch In",
  //     "time": "9:46 AM",
  //     "remark": "Punched in Late",
  //     "isLate": "yes"
  //   },
  //   {
  //     "context": "Punch Out",
  //     "time": "6:35 PM",
  //     "remark": "On Time",
  //     "onTime": "yes"
  //   },
  //   {
  //     "context": "Total Hours",
  //     "time": "9h 12m",
  //     "remark": "Working Hours",
  //   },
  //   {
  //     "context": "Weekly Hours",
  //     "time": "45h 31m",
  //     "remark": "Working Hours",
  //   }
  // ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerWidget(),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 105),
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
              )),
          padding: const EdgeInsets.only(top: 28),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  print('tapped');
                  scaffoldKey.currentState?.openDrawer();
                },
                padding: const EdgeInsets.all(0),
                icon: SvgPicture.asset(
                  "assets/drawer.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 17,
                  height: 19,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  togglePanel();
                },
                icon: SvgPicture.asset(
                  'assets/loudspeaker.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  width: 22,
                  height: 22,
                ),
              ),
              const SizedBox(
                width: 5,
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                EasyDateTimeLine(
                  initialDate: DateTime.now(),
                  onDateChange: (selectedDate) {
                    //`selectedDate` the new date selected.
                    print(selectedDate);
                  },
                  headerProps: const EasyHeaderProps(
                    // showHeader: false,
                    monthPickerType: MonthPickerType.dropDown,
                    dateFormatter: DateFormatter.fullDateDMY(),
                  ),
                  dayProps: EasyDayProps(
                    width: 64,
                    height: 80,
                    dayStructure: DayStructure.dayStrDayNum,
                    todayStyle: DayStyle(
                      dayNumStyle: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      dayStrStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                        color: color3,
                        border: Border.all(color: color1, width: 1.5),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    activeDayStyle: DayStyle(
                      dayNumStyle: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      dayStrStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: color1,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    inactiveDayStyle: DayStyle(
                      dayNumStyle: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      dayStrStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                        color: color3,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: bg1,
                  ),
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's Attendance",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            height: 26,
                            width: 72,
                            padding: const EdgeInsets.only(left: 5, right: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.5),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: const Icon(
                                  CupertinoIcons.chevron_down,
                                ),
                                iconSize: 14,
                                value: selectedValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                    if (newValue == "Monthly ") {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MonthlyAttendance(),
                                        ),
                                      );
                                    }
                                  });
                                },
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: black2,
                                ),
                                items: <String>[
                                  "Today",
                                  'Monthly ',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: SizedBox(
                                      width: 48,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: black2,
                                        ),
                                      ),
                                    ),
                                    onTap: () {},
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder(
                        future: HttpApiCall().getTodaysAttendance(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            GetTodaysAttendance data = snapshot.data!;
                            if (data.resultArray != null &&
                                data.resultArray!.isNotEmpty) {
                              final details = data.resultArray![0];
                              final punchInData = details.punchInArray ?? [];
                              final punchOutData = details.punchOutArray ?? [];
                              final totalHours = details.totalHoursArray ?? [];

                              // Check if lists are not empty before accessing index 0
                              if (punchInData.isNotEmpty &&
                                  punchOutData.isNotEmpty &&
                                  totalHours.isNotEmpty) {
                                List<Map<String, dynamic>> attendanceCard = [
                                  {
                                    'context': 'Punch In',
                                    'time': punchInData[0].punchIn ?? '-',
                                    'remark': punchInData[0].status ?? '-',
                                    "isLate": "yes"
                                  },
                                  {
                                    'context': 'Punch Out',
                                    'time': punchOutData[0].punchOut ?? '-',
                                    'remark': punchOutData[0].status ?? '-',
                                    "onTime": "yes"
                                  },
                                  {
                                    'context': 'Total Hours',
                                    'time': totalHours[0].totalHours ?? '-',
                                    "remark": "Working Hours",
                                  },
                                ];

                                // Return GridView with data
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    childAspectRatio: 139 / 90,
                                  ),
                                  itemCount: attendanceCard.length,
                                  itemBuilder: (context, index) {
                                    return AttendanceCardHome(
                                      data: attendanceCard[index],
                                    );
                                  },
                                );
                              }
                            }
                            // If any of the arrays are empty, show NoDataPage()
                            return Image.asset(
                              'assets/no_data.png',
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
                            // return Center(
                            //   child: const CircularProgressIndicator(),
                            // );
                            return SizedBox();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                        future: HttpApiCall().getAllProjectList(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            GetAllProjectList allProject = snapshot.data!;
                            final projects =
                                allProject.resultArray![0].projectArray!;
                            List<Map<String, dynamic>> projectList = [];
                            for (int i = 0; i < projects.length; i++) {
                              List<String> profilePhotoList = [];
                              for (int j = 0;
                                  j < projects[i].profilePhotoArray!.length;
                                  j++) {
                                profilePhotoList.add(projects[i]
                                        .profilePhotoArray![j]
                                        .profilePhoto ??
                                    '');
                              }
                              projectList.add(
                                {
                                  'project_name': projects[i].projectName,
                                  'time_left': projects[i].hoursRemaining,
                                  'progress':
                                      projects[i].totalPrecentage.toString(),
                                  'progress_status': projects[i].projectStatus,
                                  'project_id': projects[i].projectId,
                                  'images': profilePhotoList
                                },
                              );
                            }
                            return projects.isEmpty
                                ? NoDataPage()
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Projects",
                                            style: GoogleFonts.inter(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AllProjectsPage(),
                                                ),
                                              );
                                            },
                                            icon: Text(
                                              "View all",
                                              style: GoogleFonts.inter(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: color1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 3,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(top: 15),
                                            child: ProjectCardHome(
                                                data: projectList[index]),
                                          );
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
                            return Center(
                              child: const CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
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
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
      ),
    );
  }
}
