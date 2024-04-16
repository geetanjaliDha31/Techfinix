// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:techfinix/constants.dart';
import 'package:techfinix/screens/Man%20Hours/report_card.dart';
import 'package:techfinix/widgets/drawer.dart';

class ManHourReport extends StatefulWidget {
  const ManHourReport({
    super.key,
  });

  @override
  State<ManHourReport> createState() => _ManHourReportState();
}

class _ManHourReportState extends State<ManHourReport> {
  int index = 0;
  List<Map<String, dynamic>> checkedItems = [];
  void updateCheckedItems(List<Map<String, dynamic>> items) {
    setState(() {
      checkedItems = items;
    });
  }

  List<Map<String, dynamic>> projectList = [
    {
      "project_name": "All Projects",
    },
    {
      "project_name": "TEM-2013-103 - PIPE RACK",
    },
    {
      "project_name": "TEM-2023-214 - Tank",
    },
    {
      "project_name": "TEM-2013-103 - PIPE RACK",
    },
    {
      "project_name": "TEM-2023-214 - Tank",
    },
    {
      "project_name": "TEM-2013-103 - PIPE RACK",
    },
    {
      "project_name": "TEM-2023-214 - Tank",
    },
    {
      "project_name": "TEM-2013-103 - PIPE RACK",
    },
    {
      "project_name": "TEM-2023-214 - Tank",
    },
    {
      "project_name": "TEM-2013-103 - PIPE RACK",
    },
    {
      "project_name": "TEM-2023-214 - Tank",
    },
  ];

  List<Map<String, dynamic>> employeeList = [
    {
      "project_name": "All Employees",
    },
    {
      "project_name": "TPL-01 Shrikant",
    },
    {
      "project_name": "TPL-02 Amruta",
    },
    {
      "project_name": "TPL-01 Shrikant",
    },
    {
      "project_name": "TPL-02 Amruta",
    },
    {
      "project_name": "TPL-01 Shrikant",
    },
    {
      "project_name": "TPL-02 Amruta",
    },
    {
      "project_name": "TPL-01 Shrikant",
    },
    {
      "project_name": "TPL-02 Amruta",
    },
    {
      "project_name": "TPL-01 Shrikant",
    },
    {
      "project_name": "TPL-02 Amruta",
    },
  ];

  List<Map<String, dynamic>> get filteredReportList {
    final List<Map<String, dynamic>> reportList =
        index == 0 ? projectList : employeeList;

    return reportList;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
                'Man-Hour Report',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
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
        padding: const EdgeInsets.fromLTRB(20, 10, 15, 20),
        child: ElevatedButton(
          onPressed: () {
            print('items');
            print(checkedItems);
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
              horizontal: 88,
              vertical: 6,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/download.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 20,
                  height: 20,
                ),
                Text(
                  "Download",
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 40,
                    width: 240,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              index = 0;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 115,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: index == 0 ? color1 : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Project",
                              style: GoogleFonts.inter(
                                color: index == 0 ? Colors.white : color1,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              index = 1;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 115,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: index == 1 ? color1 : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Employee",
                              style: GoogleFonts.inter(
                                color: index == 1 ? Colors.white : color1,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 32,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/calendar2.svg',
                        colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
                        width: 18,
                        height: 18,
                      ),
                      Text(
                        '01/01/24 - 15/02/24',
                        style: GoogleFonts.inter(
                          color: color1,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredReportList.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 13),
                      child: ReportCard(
                        data: filteredReportList[i],
                        onItemsChecked: updateCheckedItems,
                        checkedItems: checkedItems,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
