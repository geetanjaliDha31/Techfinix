// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/screens/Man%20Hours/man_hours_form.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/textfield.dart';

class AddManHours extends StatefulWidget {
  // String date;

  const AddManHours({
    super.key,
    // required this.date,
  });

  @override
  State<AddManHours> createState() => _AddManHoursState();
}

class _AddManHoursState extends State<AddManHours> {
  bool isDataLoaded = false;
  TextEditingController dateController = TextEditingController();
  List<TextEditingController> deptControllers = [];
  List<TextEditingController> deptIdControllers = [];
  List<TextEditingController> projectController = [];
  List<TextEditingController> projectIdController = [];
  List<TextEditingController> budgetController = [];
  List<TextEditingController> consumedController = [];
  List<TextEditingController> workController = [];
  List<TextEditingController> acitivityController = [];
  List<DateTime> disabledDates = [
    DateTime(2024, 3, 11),
    DateTime(2024, 3, 9),
    DateTime(2024, 3, 7),
    DateTime(2024, 3, 5),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addManHours();
    calculateTotalWork();
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

  void addManHours() {
    setState(() {
      projectController.add(TextEditingController());
      projectIdController.add(TextEditingController());
      workController.add(TextEditingController());
      acitivityController.add(TextEditingController());

      // deptControllers.add(TextEditingController());
      // deptIdControllers.add(TextEditingController());
      // budgetController.add(TextEditingController());
      // consumedController.add(TextEditingController());
    });
  }

  void removeManHours(int index) {
    setState(() {
      projectController.removeAt(index);
      projectIdController.removeAt(index);
      workController.removeAt(index);
      acitivityController.removeAt(index);

      // deptControllers.remove(TextEditingController());
      // deptIdControllers.remove(TextEditingController());
      // budgetController.remove(TextEditingController());
      // consumedController.remove(TextEditingController());
    });
  }

  String calculateTotalWork() {
    int totalHours = 0;
    int totalMinutes = 0;

    for (int i = 0; i < workController.length; i++) {
      if (workController[i].text.isNotEmpty) {
        List<String> timeParts = workController[i].text.split(':');
        if (timeParts.length == 2) {
          try {
            int hours = int.parse(timeParts[0]);
            int minutes = int.parse(timeParts[1]);

            // If minutes are 60 or more, add them to hours and show hours only
            if (minutes >= 60) {
              hours += minutes ~/ 60; // Adding whole hours
              totalHours += hours;
              totalMinutes = 0; // Reset total minutes
            } else {
              totalHours += hours;
              totalMinutes += minutes;
            }
          } catch (e) {
            print("Error parsing input: ${workController[i].text}");
          }
        } else {
          print("Invalid input format: ${workController[i].text}");
        }
      }
    }

    if (totalMinutes >= 60) {
      totalHours += totalMinutes ~/ 60;
      totalMinutes %= 60;
    }

    String totalTime = '$totalHours:${totalMinutes.toString().padLeft(2, '0')}';
    print("Total work time: $totalTime");
    return totalTime;
  }

  double _submit() {
    String totalTime = calculateTotalWork();
    double parsedTime = double.tryParse(totalTime.split(':')[0]) ?? 0;
    return parsedTime;
  }

  @override
  Widget build(BuildContext context) {
    bool isEnabled = _submit() >= 9;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              Text(
                'Add Man-Hours',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
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
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 6,
                    right: 6,
                  ),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                          height: 50,
                          width: 162,
                          decoration: BoxDecoration(
                            color: color3,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'TARGET HOURS',
                                style: GoogleFonts.inter(
                                  color: color1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Container(
                                height: 40,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '9:00',
                                    style: GoogleFonts.inter(
                                      color: color1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                          height: 50,
                          width: 165,
                          decoration: BoxDecoration(
                            color: color3,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'HOURS BOOKED',
                                style: GoogleFonts.inter(
                                  color: color1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Container(
                                height: 40,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    calculateTotalWork(),
                                    style: GoogleFonts.inter(
                                      color: color1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 8),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextBox(
                            controller: dateController,
                            width: MediaQuery.of(context).size.width * 0.86,
                            hinttext: "Date",
                            icon: Icons.calendar_month_outlined,
                            // enabled: false,
                            readOnly: true,
                            label: "",
                            labelFontsize: 13,
                            obscureText: false,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1999),
                                lastDate: DateTime(2025),
                                selectableDayPredicate: (DateTime date) {
                                  // Disable future dates and dates in the disabledDates list
                                  final DateTime today = DateTime.now();
                                  return !disabledDates.contains(date) &&
                                      !date.isAfter(today);
                                },
                              ).then((value) {
                                setState(() {
                                  dateController.text =
                                      value!.toLocal().toString().split(' ')[0];
                                });
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          for (int i = 0; i < projectController.length; i++)
                            ManHoursForm(
                                projectController: projectController[i],
                                acitivityController: acitivityController[i],
                                workController: workController[i],
                                projectIdController: projectIdController[i],
                                // budgetController: budgetController[i],
                                // consumedController: consumedController[i],
                                // deptIdController: deptIdControllers[i],
                                // deptController: deptControllers[i],
                                onWorkHoursChanged: (String workHours) {
                                  setState(() {});
                                },
                                onDelete: () {
                                  removeManHours(i);
                                }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  addManHours();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: color1,
                                      size: 20,
                                    ),
                                    Text(
                                      "Add Project",
                                      style: GoogleFonts.inter(
                                        color: color1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: isEnabled
                                ? () {
                                    List<Map<String, dynamic>>
                                        manHoursDataList = [];
                                    for (int i = 0;
                                        i < projectController.length;
                                        i++) {
                                      String projectId =
                                          projectIdController[i].text;
                                      String workHours = workController[i].text;
                                      String activity =
                                          acitivityController[i].text;
                                      DateTime parsedTime =
                                          DateFormat.Hm().parse(workHours);

                                      String formattedTime =
                                          DateFormat.Hms().format(parsedTime);

                                      Map<String, dynamic> manHoursData = {
                                        'project_id': projectId,
                                        'work_hours': formattedTime,
                                        'activity': activity,
                                      };
                                      manHoursDataList.add(manHoursData);
                                    }
                                    String jsonData =
                                        jsonEncode(manHoursDataList);
                                    print(jsonData);
                                    HttpApiCall().addManHours(context, {
                                      'date': dateController.text,
                                      'project_details': jsonData,
                                    });
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isEnabled ? color1 : color2,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 105,
                                vertical: 6,
                              ),
                              child: Text(
                                "Submit",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
      ),
    );
  }
}
