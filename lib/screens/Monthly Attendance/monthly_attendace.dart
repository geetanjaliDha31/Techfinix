// ignore_for_file: avoid_print, prefer_const_constructors, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_attendance_details.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/drawer.dart';
import 'package:techfinix/widgets/no_data.dart';

class MonthlyAttendance extends StatefulWidget {
  const MonthlyAttendance({super.key});

  @override
  State<MonthlyAttendance> createState() => _MonthlyAttendanceState();
}

class _MonthlyAttendanceState extends State<MonthlyAttendance> {
  @override
  void initState() {
    super.initState();
    getDropdownData();
  }

  List<dynamic> monthList = [];
  List<dynamic> yearList = [];
  String selectedMonth = '';
  String selectedYear = '';
  Map<String, dynamic> initialMonth = {};
  Map<String, dynamic> initialYear = {};

  bool isDataLoaded = false;

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

  // Future<void> getDropdownData() async {
  //   final response = await HttpApiCall().getDropdownData();
  //   if (response.isNotEmpty &&
  //       response['month_array'].isNotEmpty &&
  //       response['year_array'].isNotEmpty) {
  //     print(response['month_array']);
  //     print(response['year_array']);
  //     monthList = response['month_array'];
  //     yearList = response['year_array'];

  //     setState(() {
  //       isDataLoaded = true;
  //     });
  //   }
  // }

  Future<void> getDropdownData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      monthList = [
        {'month_id': 1, 'month_name': 'Jan'},
        {'month_id': 2, 'month_name': 'Feb'},
        {'month_id': 3, 'month_name': 'Mar'},
        {"month_id": 4, "month_name": "Apr"},
        {"month_id": 5, "month_name": "May"},
        {"month_id": 6, "month_name": "June"},
        {"month_id": 7, "month_name": "July"},
        {"month_id": 8, "month_name": "Aug"},
        {"month_id": 9, "month_name": "Sept"},
        {"month_id": 10, "month_name": "Oct"},
        {"month_id": 11, "month_name": "Nov"},
        {"month_id": 12, "month_name": "Dec"},
      ];
      int currentYear = DateTime.now().year;
      yearList = List.generate(
        currentYear - 1999, // Years from 2000 till the current year
        (index) => {'year': 2000 + index},
      );
      // Find the index of the current month and year
      int currentMonthIndex = monthList
          .indexWhere((element) => element['month_id'] == DateTime.now().month);
      int currentYearIndex = yearList
          .indexWhere((element) => element['year'] == DateTime.now().year);

      // Set selectedMonth and selectedYear
      selectedMonth = monthList[currentMonthIndex]['month_id'].toString();
      selectedYear = yearList[currentYearIndex]['year'].toString();

      // Set initialMonth and initialYear
      initialMonth = monthList[currentMonthIndex];
      initialYear = yearList[currentYearIndex];
      print(selectedMonth);
      print(selectedYear);
      isDataLoaded = true;
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerWidget(),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: Container(
          height: 105,
          decoration: BoxDecoration(
            color: color1,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.only(top: 20, bottom: 15),
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
              Text(
                'Attendance',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
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
              const SizedBox(
                width: 5,
              )
            ],
          ),
        ),
      ),
      body: !isDataLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DropdownMenu<dynamic>(
                                initialSelection: initialMonth,
                                // selectedSelection: monthList[0]['month_name'],
                                width: MediaQuery.of(context).size.width * 0.34,
                                menuHeight: 250,
                                textStyle: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                hintText: 'Month',
                                trailingIcon: Icon(
                                  CupertinoIcons.chevron_down,
                                  color: grey2,
                                  size: 13,
                                ),
                                selectedTrailingIcon: Icon(
                                  CupertinoIcons.chevron_up,
                                  color: grey2,
                                  size: 13,
                                ),
                                menuStyle: MenuStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Colors.white,
                                  ),
                                  elevation:
                                      MaterialStatePropertyAll<double>(0.5),
                                  side: MaterialStatePropertyAll(
                                    BorderSide(
                                      color: grey3,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                inputDecorationTheme: InputDecorationTheme(
                                  floatingLabelAlignment:
                                      FloatingLabelAlignment.center,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  constraints:
                                      const BoxConstraints(maxHeight: 40),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: grey1),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: grey1),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                onSelected: (dynamic value) {
                                  setState(() {
                                    selectedMonth =
                                        value!['month_id'].toString();
                                  });
                                },
                                // underline: SizedBox.shrink(),
                                dropdownMenuEntries: monthList
                                    .map<DropdownMenuEntry<dynamic>>(
                                        (dynamic value) {
                                  return DropdownMenuEntry<dynamic>(
                                    value: value,
                                    label: value['month_name'],
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              DropdownMenu<dynamic>(
                                initialSelection: initialYear,
                                width: MediaQuery.of(context).size.width * 0.32,
                                menuHeight: 250,
                                textStyle: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                hintText: 'Year',

                                trailingIcon: Icon(
                                  CupertinoIcons.chevron_down,
                                  color: grey2,
                                  size: 13,
                                ),
                                selectedTrailingIcon: Icon(
                                  CupertinoIcons.chevron_up,
                                  color: grey2,
                                  size: 13,
                                ),
                                menuStyle: MenuStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Colors.white,
                                  ),
                                  elevation:
                                      MaterialStatePropertyAll<double>(0.5),
                                  side: MaterialStatePropertyAll(
                                    BorderSide(
                                      color: grey3,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                inputDecorationTheme: InputDecorationTheme(
                                  floatingLabelAlignment:
                                      FloatingLabelAlignment.center,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  constraints:
                                      const BoxConstraints(maxHeight: 40),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: grey1),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: grey1),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                onSelected: (dynamic value) {
                                  setState(() {
                                    selectedYear = value!['year'].toString();
                                  });
                                },
                                // underline: SizedBox.shrink(),
                                dropdownMenuEntries: yearList
                                    .map<DropdownMenuEntry<dynamic>>(
                                        (dynamic value) {
                                  return DropdownMenuEntry<dynamic>(
                                    value: value,
                                    label: value['year'].toString(),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'On Time',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                          color: green1,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Late',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                          color: red2,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FutureBuilder(
                            future: HttpApiCall().getAttendanceDetails(
                              {
                                'month_id': selectedMonth,
                                'year': selectedYear,
                              },
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                GetAttendanceDetails details = snapshot.data!;
                                final attendance = details.resultArray!;
                                List<Map<String, dynamic>> data = [];
                                for (int i = 0; i < attendance.length; i++) {
                                  data.add(
                                    {
                                      "date": attendance[i].date,
                                      'punch_in': DateFormat("hh:mm a")
                                          .parse(attendance[i].punchIn ?? ''),
                                      'punch_out': DateFormat("hh:mm a")
                                          .parse(attendance[i].punchOut ?? ''),
                                      'punch_in_remark':
                                          attendance[i].punchInRemark ?? '',
                                      'punch_out_remark':
                                          attendance[i].punchOutRemark ?? '',
                                    },
                                  );
                                }
                                return attendance.isEmpty
                                    ? NoDataPage()
                                    : Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                // SizedBox(
                                                //   width: 6,
                                                // ),
                                                SizedBox(
                                                  width: 90,
                                                  child: Text(
                                                    "Punch In",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                SizedBox(
                                                  width: 90,
                                                  child: Text(
                                                    "Punch Out",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            for (int i = 0;
                                                i < data.length;
                                                i++)
                                              rowElement(data[i],
                                                  i == data.length - 1),
                                          ],
                                        ),
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
                                    child: const CircularProgressIndicator());
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
            ),
    );
  }

  Widget rowElement(Map<String, dynamic> data, bool noDivider) {
    DateTime punchInTime = data['punch_in'];
    DateTime punchOutTime = data['punch_out'];

    TimeOfDay punchInTimeOfDay = TimeOfDay.fromDateTime(punchInTime);
    TimeOfDay punchOutTimeOfDay = TimeOfDay.fromDateTime(punchOutTime);

    // int punchInMinutes = punchInTimeOfDay.hour * 60 + punchInTimeOfDay.minute;
    // int punchOutMinutes =
    //     punchOutTimeOfDay.hour * 60 + punchOutTimeOfDay.minute;

    // int latepunchInMinutes = 9 * 60 + 45; // 9:45 AM in minutes since midnight
    // int earlypunchOutMinutes = 7 * 60 + 00; // 7:00 PM in minutes since midnight

    // Color punchInColor = punchInMinutes > latepunchInMinutes ? red2 : green1;
    // Color punchOutColor =
    //     punchOutMinutes < earlypunchOutMinutes ? red2 : green1;

    Color punchInColor = data['punch_in_remark'] == "On Time" ? green1 : red2;
    Color punchOutColor = data['punch_out_remark'] == "Late" ? red2 : green1;

    String punchInTimeStr = DateFormat.jm().format(
        DateTime(2024, 1, 1, punchInTimeOfDay.hour, punchInTimeOfDay.minute));
    String punchOutTimeStr = DateFormat.jm().format(
        DateTime(2024, 1, 1, punchOutTimeOfDay.hour, punchOutTimeOfDay.minute));

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 90,
              child: Text(
                data['date'],
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 90,
              child: Text(
                punchInTimeStr,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: punchInColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 90,
              child: Text(
                punchOutTimeStr,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: punchOutColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        if (noDivider == false)
          Divider(
            color: grey1.withOpacity(0.6),
            thickness: 0.6,
          ),
      ],
    );
  }
}
