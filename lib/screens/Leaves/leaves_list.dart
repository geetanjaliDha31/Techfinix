// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_leave_card_details.dart';
import 'package:techfinix/screens/Leaves/leaves_list_card.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/no_data.dart';

class LeavesListPage extends StatefulWidget {
  const LeavesListPage({super.key});

  @override
  State<LeavesListPage> createState() => _LeavesListPageState();
}

class _LeavesListPageState extends State<LeavesListPage> {
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
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 31,
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
        future: HttpApiCall().getLeaveCardDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            LeaveCardDetails cardDetails = snapshot.data!;
            final cardData = cardDetails.resultArray![0];

            List<Map<String, dynamic>> leavesCount = [
              {
                'leave_type': "Casual Leaves",
                'balance_count':
                    cardData.casualLeaveCountArray![0].balanceLeaves.toString(),
                'applied_count': cardData
                    .casualLeaveCountArray![0].appliedCasualLeaves
                    .toString(),
                'total_count':
                    cardData.casualLeaveCountArray![0].totalLeaves.toString(),
              },
              {
                'leave_type': "Sick Leaves",
                'balance_count':
                    cardData.sickLeaveCountArray![0].balanceLeaves.toString(),
                'applied_count': cardData
                    .sickLeaveCountArray![0].appliedSickLeaves
                    .toString(),
                'total_count':
                    cardData.sickLeaveCountArray![0].totalLeaves.toString(),
              },
              {
                'leave_type': "Privilege Leaves",
                'balance_count': cardData
                    .privilegeLeaveCountArray![0].balancePrivledgeLeaves
                    .toString(),
                'applied_count': cardData
                    .privilegeLeaveCountArray![0].appliedPrivilegeLeaves
                    .toString(),
                'total_count': cardData
                    .privilegeLeaveCountArray![0].totalPrivilegeLeaves
                    .toString(),
              },
              {
                'leave_type': "Outdoor Leaves",
                'balance_count': cardData
                    .outdoorActivityCountArray![0].balanceOutddorActivity
                    .toString(),
                'applied_count': cardData
                    .outdoorActivityCountArray![0].appliedOutdoorActivity
                    .toString(),
                'total_count': cardData
                    .outdoorActivityCountArray![0].totalOutddorActivity
                    .toString(),
              },
              {
                'leave_type': "Comp.off Leaves",
                'balance_count':
                    cardData.compOffCountArray![0].balanceCompOff.toString(),
                'applied_count':
                    cardData.compOffCountArray![0].appliedCompOff.toString(),
                'total_count':
                    cardData.compOffCountArray![0].totalCompOff.toString(),
              },
            ];
            return leavesCount.isEmpty
                ? NoDataPage()
                : Stack(
                    children: [
                      SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0; i < leavesCount.length; i++)
                                LeavesListCard(data: leavesCount[i]),
                            ],
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
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
