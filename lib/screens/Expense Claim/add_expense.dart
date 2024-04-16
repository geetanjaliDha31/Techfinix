// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/screens/Expense%20Claim/add_expense_form.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/textfield.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  TextEditingController voucherNo = TextEditingController();
  TextEditingController voucherDate = TextEditingController();
  TextEditingController projectName = TextEditingController();

  List<TextEditingController> expenseControllers = [];
  List<TextEditingController> descrpControllers = [];
  List<TextEditingController> amountControllers = [];
  List<TextEditingController> expenseIdControllers = [];
  List<TextEditingController> imageControllers = [];

  List<dynamic> projectList = [];
  List<dynamic> expenseList = [];
  String selectedProject = '';
  bool isDataLoaded = false;
  bool isLoaded = false;
  // double totalAmount = 0.0;
  @override
  void initState() {
    super.initState();
    getProjectDropdown();
    getDropdownData();
    addExpense();
    calculateTotalAmount();
  }

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

  Future<void> getProjectDropdown() async {
    final response = await HttpApiCall().getDropdownData();
    if (response.isNotEmpty && response['project_array'].isNotEmpty) {
      print(response['project_array']);
      projectList = response['project_array'];
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  void getDropdownData() async {
    final response = await HttpApiCall().getDropdownData();
    if (response.isNotEmpty && response['expense_array'].isNotEmpty) {
      print(response['expense_array']);
      expenseList = response['expense_array'];
      setState(() {
        isLoaded = true;
      });
    }
  }

  void addExpense() {
    expenseControllers.add(TextEditingController());
    amountControllers.add(TextEditingController());
    descrpControllers.add(TextEditingController());
    expenseIdControllers.add(TextEditingController());
    imageControllers.add(TextEditingController());
    setState(() {
      // print(expenseDataList);
    });
  }

  void removeManHours(int index) {
    expenseControllers.removeAt(index);
    amountControllers.removeAt(index);
    descrpControllers.removeAt(index);
    expenseIdControllers.removeAt(index);
    imageControllers.removeAt(index);
    setState(() {});
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    for (int i = 0; i < amountControllers.length; i++) {
      if (amountControllers[i].text.isNotEmpty) {
        totalAmount += double.parse(amountControllers[i].text);
      }
    }
    return totalAmount;
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
                'Create Expense',
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Container(
              height: 65,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Total Amount',
                    style: GoogleFonts.inter(
                      color: color1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "₹${calculateTotalAmount().toStringAsFixed(2)}",
                    style: GoogleFonts.inter(
                      color: color1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ElevatedButton(
              onPressed: () {
                List<Map<String, dynamic>> expenseDataList = [];
                for (int i = 0; i < expenseControllers.length; i++) {
                  String amount = amountControllers[i].text;
                  String expenseId = expenseIdControllers[i].text;
                  String descrp = descrpControllers[i].text;
                  String image = imageControllers[i].text;

                  Map<String, dynamic> expenseData = {
                    'expenses_id': expenseId,
                    'amount': amount,
                    'description': descrp,
                    'voucher_bill': image,
                  };
                  expenseDataList.add(expenseData);
                  print('length');
                  print(expenseDataList.length);
                }
                String jsonData = jsonEncode(expenseDataList);
                print(jsonData);
                HttpApiCall().addExpense(context, {
                  'voucher_date': voucherDate.text,
                  'project_id': selectedProject,
                  'vouchers_details': jsonData,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color1,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 105,
                  vertical: 6,
                ),
                child: Text(
                  "Submit",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: !isDataLoaded && !isLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          // TextBox(
                          //   // controller: voucherNo,
                          //   hinttext: "Voucher Number",
                          //   value: "#151651",
                          //   label: "",
                          //   obscureText: false,
                          //   readOnly: true,
                          // ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          TextBox(
                            controller: voucherDate,
                            hinttext: "Voucher Date",
                            width: MediaQuery.of(context).size.width * 0.86,
                            label: "",
                            icon: Icons.calendar_month_outlined,
                            readOnly: true,
                            obscureText: false,
                            labelFontsize: 13,
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1999),
                                      lastDate: DateTime(2025))
                                  .then(
                                (value) {
                                  setState(
                                    () {
                                      voucherDate.text = value!
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0];
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DropdownMenu<dynamic>(
                            width: MediaQuery.of(context).size.width * 0.86,
                            initialSelection: projectList[0]['project_name'],
                            textStyle: GoogleFonts.inter(fontSize: 13),
                            menuHeight: 250,
                            label: Text(
                              "Project Name",
                              style:
                                  GoogleFonts.inter(color: grey1, fontSize: 13),
                            ),
                            trailingIcon: Icon(
                              CupertinoIcons.chevron_down,
                              color: grey1,
                              size: 20,
                            ),
                            selectedTrailingIcon: Icon(
                              CupertinoIcons.chevron_up,
                              color: color1,
                              size: 20,
                            ),
                            menuStyle: MenuStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.white,
                              ),
                              elevation: MaterialStatePropertyAll<double>(0.5),
                              side: MaterialStatePropertyAll(
                                BorderSide(
                                  color: grey3,
                                  width: 1,
                                ),
                              ),
                            ),
                            inputDecorationTheme: InputDecorationTheme(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              constraints: const BoxConstraints(maxHeight: 50),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: grey1),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: grey1),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                            onSelected: (dynamic value) {
                              setState(() {
                                selectedProject =
                                    value!['project_id'].toString();
                                projectName.text = value!['project_name'];
                              });
                            },
                            controller: projectName,
                            // underline: SizedBox.shrink(),
                            dropdownMenuEntries: projectList
                                .map<DropdownMenuEntry<dynamic>>(
                                    (dynamic value) {
                              return DropdownMenuEntry<dynamic>(
                                value: value,
                                label: value['project_name'],
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          for (int i = 0; i < expenseControllers.length; i++)
                            AddExpenseForm(
                              amountControllers: amountControllers[i],
                              descrpControllers: descrpControllers[i],
                              expenseControllers: expenseControllers[i],
                              expenseIdControllers: expenseIdControllers[i],
                              imageControllers: imageControllers[i],
                              expenseList: expenseList,
                              onTotalAmountChanged: (String amount) {
                                setState(() {
                                  // totalAmount = double.parse(amount);
                                });
                              },
                              onDelete: () {
                                removeManHours(i);
                              },
                            ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  addExpense();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: color1,
                                      size: 20,
                                    ),
                                    Text(
                                      "Expense",
                                      style: GoogleFonts.inter(
                                        color: color1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 175,
                          ),
                          // Padding(
                          // padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                          //   child: Container(
                          //     height: 65,
                          //     width: double.infinity,
                          //     decoration: BoxDecoration(
                          //       color: color3,
                          //       borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(15),
                          //         topRight: Radius.circular(15),
                          //       ),
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceAround,
                          //       children: [
                          //         Text(
                          //           'Total Amount',
                          //           style: GoogleFonts.inter(
                          //             color: color1,
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //         SizedBox(width: 12),
                          //         Text(
                          //           "₹${calculateTotalAmount().toStringAsFixed(2)}",
                          //           style: GoogleFonts.inter(
                          //             color: color1,
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // )
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
            ),
    );
  }
}
