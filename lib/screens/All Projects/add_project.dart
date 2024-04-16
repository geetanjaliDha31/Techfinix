// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/screens/Home/home.dart';
import 'package:techfinix/widgets/textfield.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  TextEditingController deptController = TextEditingController();
  TextEditingController projectController = TextEditingController();
  TextEditingController hoursController = TextEditingController();

  String selectedDept = '';
  List<dynamic> deptList = [];
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getDeptDropdown();
  }

  Future<void> getDeptDropdown() async {
    final response = await HttpApiCall().getDropdownData();
    if (response.isNotEmpty && response["department_array"].isNotEmpty) {
      print(response["department_array"]);
      deptList = response["department_array"];
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (route) => false,
                  );
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
                'Add Project',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
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
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextBox(
                        controller: projectController,
                        hinttext: "Project",
                        label: "",
                        obscureText: false,
                        isNumber: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownMenu<dynamic>(
                        width: MediaQuery.of(context).size.width * 0.86,
                        menuHeight: 200,
                        initialSelection: deptList[0]['department_name'],
                        textStyle: GoogleFonts.inter(fontSize: 14),
                        label: Text(
                          "Department",
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
                            selectedDept = value!['department_id'].toString();
                            deptController.text = value!['department_name'];
                          });
                        },
                        controller: deptController,
                        // underline: SizedBox.shrink(),
                        dropdownMenuEntries: deptList
                            .map<DropdownMenuEntry<dynamic>>((dynamic value) {
                          return DropdownMenuEntry<dynamic>(
                            value: value,
                            label: value['department_name'],
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextBox(
                        controller: hoursController,
                        hinttext: "Budgeted Hours",
                        label: "",
                        obscureText: false,
                        isNumber: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color1,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
