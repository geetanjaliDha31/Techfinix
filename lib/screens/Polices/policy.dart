// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';

import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_policy_list.dart';
import 'package:techfinix/models/get_policy_search.dart';
import 'package:techfinix/screens/Polices/policy_card.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/drawer.dart';
import 'package:techfinix/widgets/no_data.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  int index = 2;

  // List<Map<String, dynamic>> get filteredPolicyList {
  //   final String searchText = _searchController.text.toLowerCase();
  //   final List<Map<String, dynamic>> policyList =
  //       index == 0 ? companyPolicyList : hrPolicyList;

  //   return policyList
  //       .where((policy) =>
  //           policy['policy_name'].toLowerCase().contains(searchText))
  //       .toList();
  // }

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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
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
              const SizedBox(width: 5),
              Text(
                'Policies',
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
      body: Stack(
        children: [
          SafeArea(
            child: FutureBuilder(
              future: HttpApiCall().getPolicyList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  GetPolicyList? companyPolicy = snapshot.data!;
                  final comList =
                      companyPolicy.resultArray![0].companyPolicyArray!;
                  final hrList = companyPolicy.resultArray![0].hrPolicyArray!;
                  List<Map<String, dynamic>> companyPolicyList = [];
                  List<Map<String, dynamic>> hrPolicyList = [];
                  for (int i = 0; i < comList.length; i++) {
                    companyPolicyList.add(
                      {
                        'policy_id': comList[i].policiesId,
                        "policy_name": comList[i].policyName,
                        'policies_tbl_id': comList[i].policiesTblId.toString(),
                      },
                    );
                  }
                  for (int i = 0; i < hrList.length; i++) {
                    hrPolicyList.add(
                      {
                        'policy_id': hrList[i].policiesId,
                        "policy_name": hrList[i].policyName,
                        'policies_tbl_id': hrList[i].policiesTblId.toString(),
                      },
                    );
                  }
                  return SingleChildScrollView(
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
                                        index = 2;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 115,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            index == 2 ? color1 : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "Company",
                                        style: GoogleFonts.inter(
                                          color: index == 2
                                              ? Colors.white
                                              : color1,
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
                                        color:
                                            index == 1 ? color1 : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "HR",
                                        style: GoogleFonts.inter(
                                          color: index == 1
                                              ? Colors.white
                                              : color1,
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
                            height: 12,
                          ),
                          Center(
                            child: Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                  hintText: "Search...",
                                  hintStyle: GoogleFonts.inter(color: grey1),

                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  // error: SizedBox.shrink(),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  suffixIcon: _searchController.text.isEmpty
                                      ? Icon(
                                          Icons.search_rounded,
                                          color: grey1,
                                          size: 22,
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.clear,
                                            color: grey1,
                                            size: 22,
                                          ),
                                          onPressed: () {
                                            _searchController.clear();
                                          },
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _searchController.text.isEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: index == 2
                                      ? companyPolicyList.length
                                      : hrPolicyList.length,
                                  itemBuilder: (context, i) {
                                    final Map<String, dynamic> policy =
                                        index == 2
                                            ? companyPolicyList[i]
                                            : hrPolicyList[i];
                                    return policy.isEmpty
                                        ? NoDataPage()
                                        : Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 13),
                                            child: PolicyCard(data: policy),
                                          );
                                  },
                                )
                              : FutureBuilder(
                                  future: HttpApiCall().getPolicySearch({
                                    'keyword':
                                        _searchController.text.toLowerCase(),
                                    'index': index.toString(),
                                  }),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      SearchPolicy policy = snapshot.data!;
                                      final policyData = policy.resultArray!;
                                      if (policyData.isNotEmpty) {
                                        List<Map<String, dynamic>> searchList =
                                            [];
                                        for (int i = 0;
                                            i < policyData.length;
                                            i++) {
                                          searchList.add(
                                            {
                                              'policy_id':
                                                  policyData[i].policiesId,
                                              "policy_name":
                                                  policyData[i].policyName,
                                              'policies_tbl_id': policyData[i]
                                                  .policiesTblId
                                                  .toString(),
                                            },
                                          );
                                        }
                                        return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: searchList.length,
                                          itemBuilder: (context, i) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 13),
                                              child: PolicyCard(
                                                data: searchList[i],
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return NoDataPage();
                                      }
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
                                          child:
                                              const CircularProgressIndicator());
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: const Text(
                      "Something went wrong !",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
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
