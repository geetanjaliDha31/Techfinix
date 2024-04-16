// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_all_project_list.dart';
import 'package:techfinix/screens/Home/project_card.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/no_data.dart';

class AllProjectsPage extends StatefulWidget {
  const AllProjectsPage({super.key});

  @override
  State<AllProjectsPage> createState() => _AllProjectsPageState();
}

class _AllProjectsPageState extends State<AllProjectsPage> {
  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> projects = [
    //   {
    //     "project_name": "Bandra Worli Sea link",
    //     "time_left": "23 Hrs Left",
    //     "images": [
    //       'assets/employee.png',
    //       'assets/employee.png',
    //       'assets/employee.png',
    //       'assets/employee.png',
    //     ],
    //     "progress": "70",
    //     "progress_status": "In Progress",
    //   },
    //   {
    //     "project_name": "Linking Road",
    //     "time_left": "Completed",
    //     "images": [
    //       'assets/employee.png',
    //       'assets/employee.png',
    //     ],
    //     "progress": "100",
    //     "progress_status": "Completed",
    //   },
    //   {
    //     "project_name": "Coastal Road",
    //     "time_left": "10 Hrs Exceed",
    //     "images": [
    //       'assets/employee.png',
    //       'assets/employee.png',
    //       'assets/employee.png',
    //       'assets/employee.png',
    //       'assets/employee.png',
    //       'assets/employee.png',
    //     ],
    //     "progress": "100",
    //     "progress_status": "Overtime",
    //   },
    //   {
    //     "project_name": "Eastern Freeway",
    //     "time_left": "Completed",
    //     "images": [
    //       'assets/employee.png',
    //       'assets/employee.png',
    //       'assets/employee.png',
    //     ],
    //     "progress": "100",
    //     "progress_status": "Completed",
    //   },
    //   {
    //     "project_name": "Eastern Expressway",
    //     "time_left": "50 Hrs Left",
    //     "images": [
    //       'assets/employee.png',
    //       'assets/employee.png',
    //     ],
    //     "progress": "80",
    //     "progress_status": "In Progress",
    //   },
    // ];
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
            image: const DecorationImage(
              image: AssetImage('assets/app_bar.png'),
              fit: BoxFit.cover,
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
              Text(
                'All Projects',
                style: GoogleFonts.inter(
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
        future: HttpApiCall().getAllProjectList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            GetAllProjectList allProject = snapshot.data!;
            final projects = allProject.resultArray![0].projectArray!;
            List<Map<String, dynamic>> projectList = [];
            for (int i = 0; i < projects.length; i++) {
              List<String> profilePhotoList = [];
              for (int j = 0; j < projects[i].profilePhotoArray!.length; j++) {
                profilePhotoList
                    .add(projects[i].profilePhotoArray![j].profilePhoto ?? '');
              }
              projectList.add(
                {
                  'project_name': projects[i].projectName,
                  'time_left': projects[i].hoursRemaining,
                  'progress': projects[i].totalPrecentage.toString(),
                  'progress_status': projects[i].projectStatus,
                  'project_id': projects[i].projectId,
                  'images': profilePhotoList
                },
              );
            }
            return projects.isEmpty
                ? NoDataPage()
                : Stack(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),

                        shrinkWrap: true,
                        itemCount: projects.length,
                        // physics: ,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: ProjectCardHome(data: projectList[index]),
                          );
                        },
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
            return Center(
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
