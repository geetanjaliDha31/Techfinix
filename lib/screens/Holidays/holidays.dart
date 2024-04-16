// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_holiday_list.dart';
import 'package:techfinix/screens/Holidays/holiday_card.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/drawer.dart';
import 'package:techfinix/widgets/no_data.dart';

class HolidayPage extends StatefulWidget {
  const HolidayPage({
    super.key,
  });

  @override
  State<HolidayPage> createState() => _HolidayPageState();
}

class _HolidayPageState extends State<HolidayPage> {
  List<Map<String, dynamic>> data = [
    {'date': "22 January 2024", "day": "Monday", "event": "Ram Mandir Opening"},
    {'date': "26 January 2024", "day": "Friday", "event": "Republic Day"},
    {'date': "15 August 2024", "day": "Monday", "event": "Independence Day"},
  ];
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
      key: scaffoldKey,
      drawer: const DrawerWidget(),
      backgroundColor: bg1,
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
                'Holiday List',
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
      body: FutureBuilder(
        future: HttpApiCall().getHolidayList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            HolidayList holiday = snapshot.data!;
            final data = holiday.resultArray!;
            List<Map<String, dynamic>> holidayList = [];
            for (int i = 0; i < data.length; i++) {
              holidayList.add(
                {
                  'date': data[i].date ?? '',
                  'event': data[i].occasionName ?? '',
                  'day': data[i].day ?? '',
                },
              );
            }
            return data.isEmpty
                ? NoDataPage()
                : Stack(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(20),
                        shrinkWrap: true,
                        itemCount: holidayList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: HolidayCard(data: holidayList[index]),
                          );
                        },
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
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
