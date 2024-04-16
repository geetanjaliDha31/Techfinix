import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/img_helper.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/drawer.dart';
import 'package:techfinix/widgets/textfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImageHelper _imageHelper = ImageHelper();
  File? _image;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController empIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString("name") ?? '';
      emailController.text = prefs.getString("email") ?? '';
      empIdController.text = prefs.getString("emp_id")??'';
      mobileController.text = prefs.getString("mobile") ?? '';
      designationController.text = prefs.getString("designation") ?? '';
      bloodGroupController.text = prefs.getString("blood_group") ?? '';
    });
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
      backgroundColor: Colors.white,
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
              Builder(builder: (context) {
                return IconButton(
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
                );
              }),
              const SizedBox(width: 5),
              const Text(
                'Profile',
                style: TextStyle(
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      constraints: const BoxConstraints(
                        minHeight: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final file = await _imageHelper.getImage();
                        if (file != null) {
                          final cropped = await _imageHelper.crop(
                              file, CropStyle.rectangle);
                          if (cropped != null) {
                            setState(() {
                              _image = cropped;
                            });
                          }
                        }
                      },
                      child: Stack(
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: CircleAvatar(
                                backgroundColor: color1,
                                radius: 43,
                                foregroundImage:
                                    _image != null ? FileImage(_image!) : null,
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 60,
                                )),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 28,
                              width: 28,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: black2,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      constraints: const BoxConstraints(
                        minHeight: 20,
                      ),
                    ),
                    TextBox(
                      controller: empIdController,
                      obscureText: false,
                      label: "",
                      hinttext: "Employee ID",
                      readOnly: true,
                    ),
                    Container(
                      height: 15,
                      constraints: const BoxConstraints(
                        minHeight: 15,
                      ),
                    ),
                    TextBox(
                      obscureText: false,
                      label: "",
                      hinttext: "Full Name",
                      readOnly: true,
                      controller: nameController,
                    ),
                    Container(
                      height: 15,
                      constraints: const BoxConstraints(
                        minHeight: 15,
                      ),
                    ),
                    TextBox(
                      obscureText: false,
                      label: "",
                      hinttext: "Phone Number",
                      readOnly: true,
                      controller: mobileController,
                    ),
                    Container(
                      height: 15,
                      constraints: const BoxConstraints(
                        minHeight: 15,
                      ),
                    ),
                    TextBox(
                      obscureText: false,
                      label: "",
                      hinttext: "Designation",
                      readOnly: true,
                      controller: designationController,
                    ),
                    Container(
                      height: 15,
                      constraints: const BoxConstraints(
                        minHeight: 15,
                      ),
                    ),
                    TextBox(
                      obscureText: false,
                      label: "",
                      hinttext: "Blood Group",
                      readOnly: true,
                      controller: bloodGroupController,
                    ),
                    Container(
                      height: 15,
                      constraints: const BoxConstraints(
                        minHeight: 15,
                      ),
                    ),
                    // Container(
                    //   height: 45,
                    //   width: double.infinity,
                    //   constraints: const BoxConstraints(minHeight: 45),
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor: color1,
                    //         fixedSize: const Size(double.infinity, 45)),
                    //     child: Text(
                    //       "Update",
                    //       style: GoogleFonts.inter(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w700,
                    //         color: Colors.white,
                    //       ),
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
