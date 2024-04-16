// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/widgets/textfield.dart';

class ManHoursForm extends StatefulWidget {
  // String date;
  TextEditingController projectController;
  TextEditingController projectIdController;
  // TextEditingController deptController;
  // TextEditingController deptIdController;
  // TextEditingController budgetController;
  // TextEditingController consumedController;
  TextEditingController workController;
  TextEditingController acitivityController;
  final Function(String) onWorkHoursChanged;
  final Function() onDelete;

  ManHoursForm({
    super.key,
    required this.projectController,
    required this.projectIdController,
    required this.acitivityController,
    // required this.deptController,
    // required this.deptIdController,
    // required this.budgetController,
    // required this.consumedController,
    required this.workController,
    required this.onWorkHoursChanged,
    required this.onDelete,
    // required this.date,
  });

  @override
  State<ManHoursForm> createState() => _ManHoursFormState();
}

class _ManHoursFormState extends State<ManHoursForm> {
  List<dynamic> projectList = [];
  List<dynamic> deptList = [];
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getDropdownData();
  }

  Future<void> getDropdownData() async {
    final response = await HttpApiCall().getDropdownData();
    if (response.isNotEmpty &&
        response['project_array'].isNotEmpty &&
        response["department_array"].isNotEmpty) {
      print(response['project_array']);
      print(response["department_array"]);
      projectList = response['project_array'];
      deptList = response["department_array"];
      setState(() {
        isDataLoaded = true;
        // dateController = TextEditingController(text: widget.date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isDataLoaded
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                height: 350,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 210),
                      child: InkWell(
                        onTap: () {
                          widget.onDelete();
                        },
                        child: Container(
                          height: 30,
                          width: 92,
                          decoration: BoxDecoration(
                            color: red3.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                CupertinoIcons.delete,
                                color: red2,
                                size: 16,
                              ),
                              Text(
                                "REMOVE",
                                style: GoogleFonts.inter(
                                  color: red2,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    DropdownMenu<dynamic>(
                      width: MediaQuery.of(context).size.width * 0.86,
                      initialSelection: projectList[0]['project_name'],
                      textStyle: GoogleFonts.inter(fontSize: 13),
                      menuHeight: 250,

                      label: Text(
                        "Project Name",
                        style: GoogleFonts.inter(color: grey1, fontSize: 13),
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
                          widget.projectIdController.text =
                              value!['project_id'].toString();
                          widget.projectController.text =
                              value!['project_name'];
                        });
                      },
                      controller: widget.projectController,
                      // underline: SizedBox.shrink(),
                      dropdownMenuEntries: projectList
                          .map<DropdownMenuEntry<dynamic>>((dynamic value) {
                        return DropdownMenuEntry<dynamic>(
                          value: value,
                          label: value['project_name'],
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextBox(
                      hinttext: "Work Hours",
                      controller: widget.workController,
                      labelFontsize: 13,
                      label: "",
                      obscureText: false,
                      isNumber: false,
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay time = TimeOfDay(hour: 1, minute: 00);
                        final TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: time,
                          initialEntryMode: TimePickerEntryMode.inputOnly,
                          useRootNavigator: false,
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child ?? Container(),
                            );
                          },
                        );
                        if (newTime != null) {
                          setState(() {
                            time = newTime;
                            widget.workController.text =
                                '${time.hour}:${time.minute}';
                          });
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          String totalWorkHours = widget.workController.text;
                          widget.onWorkHoursChanged(totalWorkHours);
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextBox(
                      controller: widget.acitivityController,
                      hinttext: "Activity",
                      // labelText: 'Activity',
                      label: "",
                      labelFontsize: 13,
                      isDense: true,
                      obscureText: false,
                      inputType: TextInputType.multiline,
                      height: 110,
                      isNumber: false,
                      maxLength: 50,
                      showCounter: true,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLines: 15,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          );
  }
}
  //  DropdownMenu<dynamic>(
  //                 width: MediaQuery.of(context).size.width * 0.86,
  //                 initialSelection: deptList[0]['department_name'],
  //                 textStyle: GoogleFonts.inter(fontSize: 13),
  //                 label: Text(
  //                   "Department",
  //                   style: GoogleFonts.inter(color: grey1, fontSize: 13),
  //                 ),
  //                 trailingIcon: Icon(
  //                   CupertinoIcons.chevron_down,
  //                   color: grey1,
  //                 ),
  //                 selectedTrailingIcon: Icon(
  //                   CupertinoIcons.chevron_up,
  //                   color: color1,
  //                 ),
  //                 menuStyle: const MenuStyle(
  //                   backgroundColor: MaterialStatePropertyAll(
  //                     Colors.white,
  //                   ),
  //                 ),
  //                 inputDecorationTheme: InputDecorationTheme(
  //                   constraints: const BoxConstraints(
  //                     maxHeight: 50,
  //                   ),
  //                   border: OutlineInputBorder(
  //                     borderSide: BorderSide(color: grey1),
  //                     borderRadius: BorderRadius.circular(
  //                       10,
  //                     ),
  //                   ),
  //                   enabledBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: grey1),
  //                     borderRadius: BorderRadius.circular(
  //                       10,
  //                     ),
  //                   ),
  //                   focusedBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: grey1),
  //                     borderRadius: BorderRadius.circular(
  //                       10,
  //                     ),
  //                   ),
  //                 ),
  //                 onSelected: (dynamic value) {
  //                   setState(() {
  //                     widget.deptIdController.text =
  //                         value!['department_id'].toString();
  //                     widget.deptController.text = value!['department_name'];
  //                   });
  //                 },
  //                 controller: widget.deptController,
  //                 // underline: SizedBox.shrink(),
  //                 dropdownMenuEntries:
  //                     deptList.map<DropdownMenuEntry<dynamic>>((dynamic value) {
  //                   return DropdownMenuEntry<dynamic>(
  //                     value: value,
  //                     label: value['department_name'],
  //                   );
  //                 }).toList(),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     TextBox(
                //       controller: widget.budgetController,
                //       hinttext: "Budgeted Hours",
                //       label: "",
                //       obscureText: false,
                //       isNumber: true,
                //       width: 150,
                //       labelFontsize: 13,
                //     ),
                //     SizedBox(
                //       width: 8,
                //     ),
                //     TextBox(
                //       controller: widget.consumedController,
                //       hinttext: "Consumed Hours",
                //       label: "",
                //       obscureText: false,
                //       isNumber: true,
                //       labelFontsize: 13,
                //       width: 150,
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 20,
                // ),