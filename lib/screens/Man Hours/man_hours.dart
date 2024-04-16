// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_man_hours_list.dart';
import 'package:techfinix/screens/Man%20Hours/add_man_hours.dart';
import 'package:techfinix/screens/Man%20Hours/man_hours_calendar.dart';
import 'package:techfinix/screens/Man%20Hours/man_hours_card.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/drawer.dart';
import 'package:techfinix/widgets/no_data.dart';

class ManHoursPage extends StatefulWidget {
  const ManHoursPage({super.key});

  @override
  State<ManHoursPage> createState() => _ManHoursPageState();
}

class _ManHoursPageState extends State<ManHoursPage> {
  // List<Map<String, dynamic>> data = [
  //   {
  //     "date": "Today",
  //     "timeline": [
  //       {
  //         "project_name": "Coastal Road",
  //         "time_worked": 5,
  //       },
  //       {
  //         "project_name": "Linking Road",
  //         "time_worked": 2,
  //       },
  //       {
  //         "project_name": "Expressway Road",
  //         "time_worked": 1,
  //       },
  //     ]
  //   },
  //   {
  //     "date": "20 Jan 2024",
  //     "timeline": [
  //       {
  //         "project_name": "Coastal Road",
  //         "time_worked": 8,
  //       },
  //     ]
  //   },
  //   {
  //     "date": "19 Jan 2024",
  //     "timeline": [
  //       {
  //         "project_name": "Coastal Road",
  //         "time_worked": 5,
  //       },
  //       {
  //         "project_name": "Linking Road",
  //         "time_worked": 2,
  //       },
  //     ]
  //   },
  // ];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
      key: scaffoldKey,
      drawer: const DrawerWidget(),
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
                'Man-Hours',
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddManHours(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 105,
              vertical: 6,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
                Text(
                  "Add",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: HttpApiCall().getManhoursList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            GetManHoursList manHours = snapshot.data!;
            final manHoursData = manHours.resultArray!;
            List<Map<String, dynamic>> manHoursList = [];
            for (int i = 0; i < manHoursData.length; i++) {
              List<Map<String, dynamic>> timelineList = [];
              for (int j = 0; j < manHoursData[i].timeline!.length; j++) {
                timelineList.add({
                  'project_name': manHoursData[i].timeline![j].projectName,
                  'time_worked': manHoursData[i].timeline![j].timeWorked,
                });
              }
              manHoursList.add({
                'date': manHoursData[i].date,
                'timeline': timelineList,
              });
            }
            return manHoursData.isEmpty
                ? NoDataPage()
                : Stack(
                    children: [
                      SafeArea(
                        child: ListView.builder(
                          itemCount: manHoursList.length,
                          padding: const EdgeInsets.all(24),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: index == manHoursList.length - 1
                                  ? const EdgeInsets.all(0)
                                  : const EdgeInsets.only(bottom: 8),
                              child: ManHoursCard(data: manHoursList[index]),
                            );
                          },
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
