// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/widgets/textfield.dart';
import 'package:techfinix/Http/http.dart';

class AddLeaveSlidingPanel extends StatefulWidget {
  final PanelController controller;
  const AddLeaveSlidingPanel({super.key, required this.controller});

  @override
  State<AddLeaveSlidingPanel> createState() => _AddLeaveSlidingPanelState();
}

class _AddLeaveSlidingPanelState extends State<AddLeaveSlidingPanel> {
  final TextEditingController leaveType = TextEditingController();

  final TextEditingController startDate = TextEditingController();

  final TextEditingController endDate = TextEditingController();

  final TextEditingController reason = TextEditingController();

  List<dynamic> leavesList = [];
  String selectedLeave = '';
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getDropdownData();
  }

  Future<void> getDropdownData() async {
    final response = await HttpApiCall().getDropdownData();
    if (response.isNotEmpty && response["leaves_array"].isNotEmpty) {
      print(response["leaves_array"]);
      leavesList = response["leaves_array"];
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isDataLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 4,
                  width: 80,
                  decoration: BoxDecoration(
                    color: grey1.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                DropdownMenu<dynamic>(
                  width: MediaQuery.of(context).size.width * 0.89,
                  menuHeight: 200,
                  initialSelection: leavesList[0]['leave_name'],
                  textStyle: GoogleFonts.inter(fontSize: 14),
                  label: Text(
                    "Leave Type",
                    style: GoogleFonts.inter(color: grey1),
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
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                    ),
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
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: grey1),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  onSelected: (dynamic value) {
                    setState(() {
                      selectedLeave = value!['leaves_id'].toString();
                      leaveType.text = value!['leave_name'];
                    });
                  },
                  controller: leaveType,
                  // underline: SizedBox.shrink(),
                  dropdownMenuEntries: leavesList
                      .map<DropdownMenuEntry<dynamic>>((dynamic value) {
                    return DropdownMenuEntry<dynamic>(
                      value: value,
                      label: value['leave_name'],
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextBox(
                  controller: startDate,
                  hinttext: "Start Date",
                  readOnly: true,
                  icon: Icons.calendar_month_outlined,
                  label: "",
                  obscureText: false,
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1999),
                            lastDate: DateTime(2025))
                        .then((value) {
                      setState(() {
                        startDate.text =
                            value!.toLocal().toString().split(' ')[0];
                      });
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextBox(
                  controller: endDate,
                  hinttext: "End Date",
                  readOnly: true,
                  icon: Icons.calendar_month_outlined,
                  label: "",
                  obscureText: false,
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1999),
                            lastDate: DateTime(2025))
                        .then((value) {
                      setState(() {
                        endDate.text =
                            value!.toLocal().toString().split(' ')[0];
                      });
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextBox(
                  controller: reason,
                  height: 120,
                  maxLines: 3,
                  inputType: TextInputType.multiline,
                  hinttext: "Reason for Leave",
                  label: "",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    print(selectedLeave);
                    HttpApiCall().applyLeave(
                      context,
                      {
                        'start_date': startDate.text,
                        'end_date': endDate.text,
                        'leave_type': selectedLeave.toString(),
                        'reason': reason.text,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
