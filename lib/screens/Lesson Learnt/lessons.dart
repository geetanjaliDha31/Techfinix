// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_lesson_list.dart';
import 'package:techfinix/models/get_lesson_search.dart';
import 'package:techfinix/screens/Lesson%20Learnt/add_lesson.dart';
import 'package:techfinix/screens/Lesson%20Learnt/lesson_card.dart';
import 'package:techfinix/widgets/announcement.dart';
import 'package:techfinix/widgets/drawer.dart';
import 'package:techfinix/widgets/no_data.dart';

class LessonsListPage extends StatefulWidget {
  const LessonsListPage({super.key});

  @override
  State<LessonsListPage> createState() => _LessonsListPageState();
}

class _LessonsListPageState extends State<LessonsListPage> {
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
                'Lessons',
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
              future: HttpApiCall().getLessonList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  GetLessonList? data = snapshot.data!;
                  final list = data.resultArray!;
                  List<Map<String, dynamic>> lessonList = [];

                  for (int i = 0; i < list.length; i++) {
                    lessonList.add(
                      {
                        'project_name': list[i].projectName,
                        'dept_name': list[i].departmentName,
                        'subject': list[i].subject,
                        'lesson_id': list[i].lessonId.toString(),
                      },
                    );
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Container(
                                  width: 250,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (value) {
                                      setState(
                                          () {}); // Trigger rebuild when text changes
                                    },
                                    onTap: () {
                                      print(lessonList);
                                    },
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                      hintText: "Search...",
                                      hintStyle:
                                          GoogleFonts.inter(color: grey1),

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
                                width: 15,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddLessonPage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: color1,
                                  padding: const EdgeInsets.all(0),
                                  minimumSize: const Size(75, 40),
                                  maximumSize: const Size(75, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_rounded,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "Add",
                                      style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _searchController.text.isEmpty
                              ? list.isEmpty
                                  ? NoDataPage()
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: lessonList.length,
                                      itemBuilder: (context, i) {
                                        final lesson = lessonList[i];
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 13),
                                          child: LessonsCard(data: lesson),
                                        );
                                      },
                                    )
                              : FutureBuilder(
                                  future: HttpApiCall().getLessonSearch(
                                    {
                                      'keyword':
                                          _searchController.text.toLowerCase(),
                                    },
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      SearchLesson lesson = snapshot.data!;
                                      final searchData = lesson.resultArray!;
                                      if (searchData.isNotEmpty) {
                                        List<Map<String, dynamic>> searchList =
                                            [];
                                        for (int i = 0;
                                            i < searchData.length;
                                            i++) {
                                          searchList.add(
                                            {
                                              'project_name':
                                                  searchData[i].projectName,
                                              'dept_name':
                                                  searchData[i].departmentName,
                                              'subject': searchData[i].subject,
                                              'lesson_id': searchData[i]
                                                  .lessonId
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
                                            final lesson = searchList[i];
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 13),
                                              child: LessonsCard(data: lesson),
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
