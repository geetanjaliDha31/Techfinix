// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/drawer.dart';
import 'package:techfinix/widgets/textfield.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController deptController = TextEditingController();
  TextEditingController projectController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController leadController = TextEditingController();
  TextEditingController scopeController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedProject = '';
  List<dynamic> projectList = [];
  String selectedDept = '';
  List<dynamic> deptList = [];
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getDropdownData();
    _loadData();
  }

  _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      leadController.text = prefs.getString("name") ?? '';
      emailController.text = prefs.getString("email") ?? '';
    });
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
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      drawer: const DrawerWidget(),
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
                'Feedback',
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
      body: !isDataLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
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
                                projectController.text = value!['project_name'];
                              });
                            },
                            controller: projectController,
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
                          DropdownMenu<dynamic>(
                            width: MediaQuery.of(context).size.width * 0.86,
                            initialSelection: deptList[0]['department_name'],
                            textStyle: GoogleFonts.inter(fontSize: 13),
                            menuHeight: 200,
                            label: Text(
                              "Department",
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
                                selectedDept =
                                    value!['department_id'].toString();
                                deptController.text = value!['department_name'];
                              });
                            },
                            controller: deptController,
                            // underline: SizedBox.shrink(),
                            dropdownMenuEntries: deptList
                                .map<DropdownMenuEntry<dynamic>>(
                                    (dynamic value) {
                              return DropdownMenuEntry<dynamic>(
                                value: value,
                                label: value['department_name'],
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextBox(
                            controller: emailController,
                            hinttext: "Customer Email Id",
                            label: "",
                            style: TextStyle(color: grey1, fontSize: 13),
                            readOnly: true,
                            obscureText: false,
                            isNumber: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextBox(
                            controller: leadController,
                            hinttext: "Lead Engineer",
                            label: "",
                            obscureText: false,
                            style: TextStyle(color: grey1, fontSize: 13),
                            readOnly: true,
                            isNumber: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextBox(
                            controller: scopeController,
                            hinttext: "Scope",
                            label: "",
                            obscureText: false,
                            labelFontsize: 13,
                            isNumber: false,
                            height: 140,
                            maxLength: 300,
                            showCounter: true,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLines: 100,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              HttpApiCall().addProjectFeedback(
                                context,
                                {
                                  'project_id': selectedProject,
                                  'department_id': selectedDept,
                                  'scope': scopeController.text,
                                },
                              );
                            },
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
