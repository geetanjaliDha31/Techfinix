// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_expense_card.dart';
import 'package:techfinix/screens/Expense%20Claim/view_bill.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/no_data.dart';

class SingleExpenseCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const SingleExpenseCard({
    super.key,
    required this.data,
  });

  @override
  State<SingleExpenseCard> createState() => _SingleExpenseCardState();
}

class _SingleExpenseCardState extends State<SingleExpenseCard> {
  // Map<String, dynamic> data = {
  //   "total": "₹ 5,000",
  //   "project_name": "EASTERN FREEWAY",
  //   "code": "#131313",
  //   "date": "22 Jan 2023",
  //   "expense": [
  //     {
  //       "type": "Travel",
  //       "cost": "₹ 1000",
  //     },
  //     {
  //       "type": "Medical",
  //       "cost": "₹ 1000",
  //     },
  //     {
  //       "type": "Food",
  //       "cost": "₹ 1000",
  //     },
  //     {
  //       "type": "Hotel",
  //       "cost": "₹ 2000",
  //     },
  //   ]
  // };
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
      backgroundColor: color1,
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
                'Expense',
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
      body: FutureBuilder(
        future: HttpApiCall().getSingleExpenseCard(
          {
            'voucher_id': widget.data['voucher_id'],
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            GetExpenseCard expenseCard = snapshot.data!;
            final details = expenseCard.resultArray![0];
            Map<String, dynamic> data = {
              'total': details.voucherArray![0].totalAmount.toString(),
              'project_name': details.voucherArray![0].projectName,
              'voucher_no': details.voucherArray![0].voucherNo,
              'date': details.voucherArray![0].voucherDate,
              'expense': details.voucherDetailsArray!.map((expenseDetail) {
                return {
                  'expense_name': expenseDetail.expenseName,
                  'amount': expenseDetail.amount.toString(),
                  'bill': expenseDetail.voucherBill,
                };
              }).toList(),
            };
            return data.isEmpty
                ? NoDataPage()
                : Stack(
                    children: [
                      SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 70,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 25, right: 25),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      "₹ ${data['total']}",
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data['project_name'],
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: data['expense'].length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return dataRow(data['expense'][index]);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    height: 130,
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 45,
                                        ),

                                        Text(
                                          data['voucher_no'],
                                          style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data['date'],
                                          style: GoogleFonts.inter(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        // const SizedBox(
                                        //   height: 30,
                                        // )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: color1,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 3,
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 20, 0),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: MediaQuery.of(context)
                                                    .size
                                                    .width ~/
                                                7,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                height: 3,
                                                width: 7,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: index % 2 == 0
                                                      ? const Color(0xff666666)
                                                          .withOpacity(0.2)
                                                      : Colors.white,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 49,
                                        decoration: BoxDecoration(
                                          color: color1,
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
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
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }

  Widget dataRow(Map<String, dynamic> d) {
    return Container(
      height: 35,
      padding: const EdgeInsets.only(
        left: 27,
        right: 27,
      ),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              d['expense_name'],
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              "₹ ${d['amount']}",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ViewBill(
                    billImg: d['bill'],
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color3,
              padding: const EdgeInsets.all(0),
              minimumSize: const Size(70, 23),
              maximumSize: const Size(70, 23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/view_bill.svg",
                  colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
                  width: 10,
                  height: 10,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  "View Bill",
                  style: GoogleFonts.inter(
                    color: color1,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
