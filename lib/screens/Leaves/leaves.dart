// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_leave_card_details.dart';
import 'package:techfinix/models/get_leaves_status_details.dart';
import 'package:techfinix/screens/Leaves/add_leaves.dart';
import 'package:techfinix/screens/Leaves/leaves_count_card.dart';
import 'package:techfinix/screens/Leaves/leaves_detail_card.dart';
import 'package:techfinix/screens/Leaves/leaves_list.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/drawer.dart';
import 'package:techfinix/widgets/no_data.dart';

class LeavesPage extends StatefulWidget {
  // final GlobalKey<ScaffoldState> scaffoldKey;

  const LeavesPage({
    super.key,
  });

  @override
  State<LeavesPage> createState() => _LeavesPageState();
}

class _LeavesPageState extends State<LeavesPage> {
  int index = 0;
  bool isPanelOpen = false;
  final PanelController _controller = PanelController();

  Widget _buildPanelContent() {
    if (index == 0) {
      return Announcement(
        controller: _controller,
      );
    } else {
      return AddLeaveSlidingPanel(
        controller: _controller,
      );
    }
  }

  double _panelHeight() {
    if (index == 1) {
      return MediaQuery.of(context).size.height * 0.73;
    } else {
      return MediaQuery.of(context).size.height * 0.74;
    }
  }

  void _togglePanel(int idx) {
    setState(() {
      index = idx;
      isPanelOpen ? _controller.close() : _controller.open();
      isPanelOpen = !isPanelOpen;
    });
  }

  // List<Map<String, dynamic>> leavesDetails = [
  //   {
  //     "dates": "1 Apr 2024 - 3 Apr 2024",
  //     "status": "Applied",
  //     "apply_days": 3,
  //     "balance_leaves": 20,
  //     "leave_type": "Personal Leave"
  //   },
  //   {
  //     "dates": "4 Apr 2024 - 5 Apr 2024",
  //     "status": "Applied",
  //     "apply_days": 2,
  //     "balance_leaves": 18,
  //     "leave_type": "Medical Leave"
  //   },
  //   {
  //     "dates": "6 Apr 2024 - 8 Apr 2024",
  //     "status": "Rejected",
  //     "apply_days": 2,
  //     "balance_leaves": 16,
  //     "leave_type": "Personal Leave"
  //   },
  //   {
  //     "dates": "1 Apr 2024 - 3 Apr 2024",
  //     "status": "Applied",
  //     "apply_days": 3,
  //     "balance_leaves": 20,
  //     "leave_type": "Personal Leave"
  //   }
  // ];

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
              const Text(
                'Leaves',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  _togglePanel(0);
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: HttpApiCall().getLeaveCardDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        LeaveCardDetails details = snapshot.data!;
                        final cardDetails =
                            details.resultArray![0].totalLeaveCountArray![0];
                        List<Map<String, dynamic>> leavesCount = [
                          {
                            'title': 'Balance Leaves',
                            'count': cardDetails.balanceLeaves.toString(),
                          },
                          {
                            'title': 'Applied Leaves',
                            'count': cardDetails.appliedLeaves.toString(),
                          },
                          {
                            'title': 'Total Leaves',
                            'count': cardDetails.totalLeaves.toString(),
                          }
                        ];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  for (int i = 0; i < leavesCount.length; i++)
                                    Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child:
                                          LeavesCountCard(data: leavesCount[i]),
                                    ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 0),
                                child: TextButton(
                                  onPressed: () {
                                    print(leavesCount.length);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LeavesListPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'VIEW MORE',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: color1,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
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
                        return Center(child: const CircularProgressIndicator());
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: bg1,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              _togglePanel(1);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color1,
                              minimumSize: const Size(90, 40),
                              maximumSize: const Size(90, 40),
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/add_voucher.svg",
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  width: 15,
                                  height: 15,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  "Apply",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder(
                          future: HttpApiCall().getLeavesStatusDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              LeaveStatusDetails details = snapshot.data!;
                              final leaves =
                                  details.resultArray![0].leaveArray!;
                              List<Map<String, dynamic>> leavesDetails = [];
                              for (int i = 0; i < leaves.length; i++) {
                                leavesDetails.add(
                                  {
                                    'dates':
                                        '${leaves[i].startDate}-${leaves[i].endDate}',
                                    'status': leaves[i].status,
                                    'apply_days':
                                        leaves[i].applyDays.toString(),
                                    'balance_leaves':
                                        leaves[i].balanceLeave.toString(),
                                    'leave_type': leaves[i].leaveName
                                  },
                                );
                              }
                              return leavesDetails.isEmpty
                                  ? NoDataPage()
                                  : ListView.builder(
                                      itemCount: leavesDetails.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          child: LeavesDetailCard(
                                            data: leavesDetails[index],
                                          ),
                                        );
                                      },
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SlidingUpPanel(
              controller: _controller,
              minHeight: 0.0,
              maxHeight: _panelHeight(),
              panelBuilder: (sc) {
                return _buildPanelContent();
              },
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              // backdropTapClosesPanel: true,
              // isDraggable: false,
              backdropEnabled: true,
              backdropColor: Colors.black,
              backdropOpacity: 0.4,

              onPanelClosed: () {
                index = 0;
                isPanelOpen = false;
              },
            )
          ],
        ),
      ),
    );
  }
}
