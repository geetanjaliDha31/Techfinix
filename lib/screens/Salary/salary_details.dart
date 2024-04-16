// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/widgets/announcement.dart';

class SalaryDetailsPage extends StatefulWidget {
  const SalaryDetailsPage({super.key});

  @override
  State<SalaryDetailsPage> createState() => _SalaryDetailsPageState();
}

class _SalaryDetailsPageState extends State<SalaryDetailsPage> {
  Map<String, dynamic> data = {
    "basic_details": {
      "Basic Salary": "23,227",
      "DA": "0",
      "TRA": "8000",
      "Conveyance": "6000",
      "Education Allowance": "1000",
      "Medical Expenses": "100",
      "Expense": "0",
      "Retention Bonus": "0",
    },
    "Sub Total": "19000",
    "Total Gross Salary": "28000",
    "advance": {
      "Deductions": "2000",
      "Contribution to PF": "0",
      "Professional Tax": "1000",
      "TDS": "2000",
      "Advance Salary": "1400",
      "Loan EMI": "2800",
    },
    "Total Deductions": "5200",
    "NET TAKE HOME": "20000",
    "structure_details": {
      "Total Attendance": "31",
      "Total Leave": "5",
      "Allowed Leave": "3",
      "Loss of Pay days": "2",
    },
    "Total Salary Days": "29"
  };
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
              Text(
                'Salary Details',
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
        padding: const EdgeInsets.fromLTRB(20, 10, 15, 20),
        child: ElevatedButton(
          onPressed: () {},
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
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          for (var entry in data['basic_details'].entries)
                            dataRow(
                              entry.key,
                              entry.value,
                              FontWeight.w400,
                              FontWeight.w500,
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Divider(
                              color: grey1,
                              thickness: 0.5,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          dataRow(
                            "Sub Total",
                            data['Sub Total'],
                            FontWeight.w400,
                            FontWeight.w600,
                          ),
                          dataRow(
                            "Total Gross Salary",
                            data['Total Gross Salary'],
                            FontWeight.w600,
                            FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          for (var entry in data['advance'].entries)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                              child: dataRow(
                                entry.key,
                                entry.value,
                                FontWeight.w400,
                                FontWeight.w500,
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 34, right: 34),
                            child: Divider(
                              color: grey1,
                              thickness: 0.5,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: dataRow(
                              "Total Deductions",
                              data['Total Deductions'],
                              FontWeight.w600,
                              FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 43,
                            decoration: BoxDecoration(
                              color: color3,
                              border: Border.all(color: color1, width: 1),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "NET TAKE HOME",
                                    style: GoogleFonts.inter(
                                      color: color1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "₹ ${data['NET TAKE HOME']}",
                                    style: GoogleFonts.inter(
                                      color: color1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Structure Details",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          for (var entry in data['structure_details'].entries)
                            dataRow(
                              entry.key,
                              entry.value,
                              FontWeight.w400,
                              FontWeight.w500,
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Divider(
                              color: grey1,
                              thickness: 0.5,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          dataRow(
                            "Total Salary Days",
                            data['Total Salary Days'],
                            FontWeight.w600,
                            FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 57,
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

  Widget dataRow(
    String key,
    String value,
    FontWeight fw1,
    FontWeight fw2,
  ) {
    return SizedBox(
      height: 38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: GoogleFonts.inter(
              color: black2,
              fontSize: 15,
              fontWeight: fw1,
            ),
          ),
          Text(
            "₹ $value",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 15,
              fontWeight: fw2,
            ),
          ),
        ],
      ),
    );
  }
}
