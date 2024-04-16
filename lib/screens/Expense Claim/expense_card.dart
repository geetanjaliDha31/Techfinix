import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/screens/Expense%20Claim/single_expense_card.dart';

class VoucherCard extends StatefulWidget {
  final Map<String, dynamic> data;

  const VoucherCard({super.key, required this.data});

  @override
  State<VoucherCard> createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  Color mainColor = yellow;
  void assignColor() {
    if (widget.data['status'] == "PENDING") {
      mainColor = yellow;
    }
    if (widget.data['status'] == "REJECTED") {
      mainColor = red1;
    }
    if (widget.data['status'] == "ACCEPTED") {
      mainColor = green1;
    }
  }

  @override
  Widget build(BuildContext context) {
    assignColor();
    return InkWell(
      onTap: () {
        print(widget.data['voucher_id']);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SingleExpenseCard(
              data: widget.data,
            ),
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              // height: 100,
              decoration: const BoxDecoration(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      constraints: const BoxConstraints(minHeight: 100),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: color3,
                            ),
                            child: SvgPicture.asset(
                              "assets/bill_icon.svg",
                              colorFilter:
                                  ColorFilter.mode(color1, BlendMode.srcIn),
                              width: 16,
                              height: 16,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        widget.data['project_name'],
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      widget.data['voucher_no'],
                                      style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.data['dept'],
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Container(
                                  height: 28,
                                  constraints:
                                      const BoxConstraints(minHeight: 28),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          widget.data['price'],
                                          style: GoogleFonts.inter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        widget.data['date'],
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: grey1,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 16,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
            width: 3,
            child: ListView.builder(
              itemCount: 100 ~/ 8.8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  bool isLastIndex = index == (100 ~/ 8.8) - 1;
                  return Container(
                    height: 8.8,
                    decoration: BoxDecoration(
                      color: index == 0 || isLastIndex
                          ? bg1
                          : mainColor == yellow
                              ? Colors.black
                              : bg1,
                    ),
                  );
                } else {
                  return Container(
                    height: 8.8,
                    // width: 3,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(5),
                      color: mainColor,
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            height: 100,
            width: 35,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: RotatedBox(
              quarterTurns: 9,
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.data["status"],
                  style: GoogleFonts.inter(
                    color: mainColor == yellow ? Colors.black : Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                  // maxLines: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
