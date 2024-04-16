// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_salary_list.dart';
import 'package:techfinix/screens/Salary/salary_card.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/drawer.dart';
import 'package:techfinix/widgets/no_data.dart';

class SalaryPage extends StatefulWidget {
  const SalaryPage({Key? key}) : super(key: key);

  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  List<dynamic> yearList = [];
  String selectedYear = '';
  bool isDataLoaded = false;
  bool isPanelOpen = false;
  final PanelController controller = PanelController();

  @override
  void initState() {
    super.initState();
    getDropdownData();
  }

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

  Future<void> getDropdownData() async {
    final response = await HttpApiCall().getDropdownData();
    if (response.isNotEmpty && response['year_array'].isNotEmpty) {
      print(response['year_array']);
      yearList = response['year_array'];
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerWidget(),
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
              const SizedBox(width: 5),
              Text(
                'Salary',
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
      body: !isDataLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: HttpApiCall().getSalaryList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  GetSalaryList salary = snapshot.data!;
                  final data = salary.resultArray!;
                  List<Map<String, dynamic>> salaryData = [];
                  for (int i = 0; i < data.length; i++) {
                    salaryData.add(
                      {
                        'salary_id': data[i].salariesId.toString(),
                        'month': data[i].date,
                        'total_gross_salary':
                            "₹${data[i].grossSalary.toString()}",
                        'net_take_home': "₹${data[i].netSalary.toString()}",
                      },
                    );
                  }
                  return data.isEmpty
                      ? NoDataPage()
                      : Stack(
                          children: [
                            SafeArea(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          DropdownMenu<dynamic>(
                                            initialSelection:
                                                yearList.isNotEmpty
                                                    ? yearList.last
                                                    : null,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.32,
                                            menuHeight: 250,
                                            textStyle: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            // hintText: 'Year',
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
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                  Colors.white,
                                                ),
                                                elevation:
                                                    MaterialStatePropertyAll<
                                                        double>(0.5),
                                                side: MaterialStatePropertyAll(
                                                  BorderSide(
                                                    color: grey3,
                                                    width: 1,
                                                  ),
                                                )),
                                            inputDecorationTheme:
                                                InputDecorationTheme(
                                              floatingLabelAlignment:
                                                  FloatingLabelAlignment.center,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              constraints: const BoxConstraints(
                                                  maxHeight: 40),
                                              border: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: grey1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: grey1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                              ),
                                            ),
                                            onSelected: (dynamic value) {
                                              setState(() {});
                                            },
                                            // underline: SizedBox.shrink(),
                                            dropdownMenuEntries: yearList.map<
                                                    DropdownMenuEntry<dynamic>>(
                                                (dynamic value) {
                                              return DropdownMenuEntry<dynamic>(
                                                value: value,
                                                label: value['year'].toString(),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListView.builder(
                                        itemCount: salaryData.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            child: SalaryCard(
                                                data: salaryData[index]),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SlidingUpPanel(
                              controller: controller,
                              minHeight: 0.0,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.73,
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
