import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/img_helper.dart';
import 'package:techfinix/widgets/textfield.dart';

class AddLessonPage extends StatefulWidget {
  const AddLessonPage({super.key});

  @override
  State<AddLessonPage> createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  final TextEditingController projectController = TextEditingController();
  final TextEditingController projectIdController = TextEditingController();
  final TextEditingController deptController = TextEditingController();
  final TextEditingController deptIdController = TextEditingController();
  final TextEditingController preparedController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  HtmlEditorController problemController = HtmlEditorController();
  HtmlEditorController solutionController = HtmlEditorController();
  HtmlEditorController lessonController = HtmlEditorController();
  bool isDataLoaded = false;
  List<dynamic> projectList = [];
  List<dynamic> deptList = [];

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
      });
    }
  }

  final ImageHelper _imageHelper = ImageHelper();
  File? _image;
  String? imageBase64;

  void convertImage() {
    List<int> imageBytes = File(_image!.path).readAsBytesSync();
    imageBase64 = base64Encode(imageBytes);
  }

  String extractTextFromHtml(String htmlString) {
    RegExp htmlTagsRegex = RegExp(r'<[^>]+>'); // Pattern to match HTML tags
    String textWithoutHtmlTags =
        htmlString.replaceAll(htmlTagsRegex, ''); // Remove HTML tags
    return textWithoutHtmlTags.replaceAll(
        '&nbsp;', ' '); // Replace &nbsp; with space
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                'Add Lessons Learnt',
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownMenu<dynamic>(
                        width: MediaQuery.of(context).size.width * 0.88,
                        initialSelection: projectList[0]['project_name'],
                        textStyle: GoogleFonts.inter(fontSize: 13),
                        label: Text(
                          "Project Name",
                          style: GoogleFonts.inter(color: grey1, fontSize: 13),
                        ),
                        trailingIcon: Icon(
                          CupertinoIcons.chevron_down,
                          color: grey1,
                        ),
                        selectedTrailingIcon: Icon(
                          CupertinoIcons.chevron_up,
                          color: color1,
                        ),
                        menuStyle: const MenuStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        inputDecorationTheme: InputDecorationTheme(
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
                            projectIdController.text =
                                value!['project_id'].toString();
                            projectController.text = value!['project_name'];
                          });
                        },
                        controller: projectController,
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
                      DropdownMenu<dynamic>(
                        width: MediaQuery.of(context).size.width * 0.88,
                        initialSelection: deptList[0]['department_name'],
                        textStyle: GoogleFonts.inter(fontSize: 13),
                        label: Text(
                          "Department",
                          style: GoogleFonts.inter(color: grey1, fontSize: 13),
                        ),
                        trailingIcon: Icon(
                          CupertinoIcons.chevron_down,
                          color: grey1,
                        ),
                        selectedTrailingIcon: Icon(
                          CupertinoIcons.chevron_up,
                          color: color1,
                        ),
                        menuStyle: const MenuStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Colors.white,
                          ),
                        ),
                        inputDecorationTheme: InputDecorationTheme(
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
                            deptIdController.text =
                                value!['department_id'].toString();
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
                        controller: preparedController,
                        hinttext: "Prepared By",
                        label: "",
                        obscureText: false,
                        labelFontsize: 13,
                        isNumber: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextBox(
                        controller: subjectController,
                        hinttext: "Subject",
                        label: "",
                        obscureText: false,
                        labelFontsize: 13,
                        inputType: TextInputType.multiline,
                        isNumber: false,
                        height: 130,
                        maxLength: 100,
                        showCounter: true,
                        maxLines: 130,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(
                          "Problem",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      HtmlEditor(
                        controller: problemController,
                        htmlEditorOptions: const HtmlEditorOptions(
                          hint: "Write here...",
                          characterLimit: 5,
                        ),
                        htmlToolbarOptions: const HtmlToolbarOptions(
                          toolbarType: ToolbarType.nativeExpandable,
                          gridViewHorizontalSpacing: 0,
                          gridViewVerticalSpacing: 0,
                          toolbarItemHeight: 25,
                          defaultToolbarButtons: [
                            FontButtons(clearAll: false),
                            ColorButtons(highlightColor: false),
                            ListButtons(listStyles: false),
                            ParagraphButtons(
                              alignRight: false,
                              caseConverter: false,
                              lineHeight: false,
                              textDirection: false,
                              increaseIndent: false,
                              decreaseIndent: false,
                            ),
                            InsertButtons(
                                link: true,
                                picture: true,
                                video: true,
                                otherFile: true,
                                hr: false,
                                table: false),
                          ],
                        ),
                        otherOptions: OtherOptions(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: grey1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(
                          "Solution",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      HtmlEditor(
                        controller: solutionController,
                        htmlEditorOptions: const HtmlEditorOptions(
                          hint: "Write here...",
                        ),
                        htmlToolbarOptions: const HtmlToolbarOptions(
                          toolbarType: ToolbarType.nativeExpandable,
                          gridViewHorizontalSpacing: 0,
                          gridViewVerticalSpacing: 0,
                          toolbarItemHeight: 25,
                          defaultToolbarButtons: [
                            FontButtons(clearAll: false),
                            ColorButtons(highlightColor: false),
                            ListButtons(listStyles: false),
                            ParagraphButtons(
                              alignRight: false,
                              caseConverter: false,
                              lineHeight: false,
                              textDirection: false,
                              increaseIndent: false,
                              decreaseIndent: false,
                            ),
                            InsertButtons(
                                link: true,
                                picture: true,
                                video: true,
                                otherFile: true,
                                hr: false,
                                table: false),
                          ],
                        ),
                        otherOptions: OtherOptions(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: grey1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: Text(
                          "Lesson",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      HtmlEditor(
                        controller: lessonController,
                        htmlEditorOptions: const HtmlEditorOptions(
                          hint: "Write here...",
                        ),
                        htmlToolbarOptions: const HtmlToolbarOptions(
                          toolbarType: ToolbarType.nativeExpandable,
                          gridViewHorizontalSpacing: 0,
                          gridViewVerticalSpacing: 0,
                          toolbarItemHeight: 25,
                          defaultToolbarButtons: [
                            FontButtons(clearAll: false),
                            ColorButtons(highlightColor: false),
                            ListButtons(listStyles: false),
                            ParagraphButtons(
                              alignRight: false,
                              caseConverter: false,
                              lineHeight: false,
                              textDirection: false,
                              increaseIndent: false,
                              decreaseIndent: false,
                            ),
                            InsertButtons(
                                link: true,
                                picture: true,
                                video: true,
                                otherFile: true,
                                hr: false,
                                table: false),
                          ],
                        ),
                        otherOptions: OtherOptions(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: grey1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                              convertImage();
                            }
                          }
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(8),
                          strokeWidth: 0.8,
                          dashPattern: const [7, 7],
                          color: grey1,
                          child: Container(
                            height: 65,
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(3),
                            child: _image == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        color: grey1,
                                        size: 24,
                                      ),
                                      Text(
                                        "Tap to Upload Image",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: grey1,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(_image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String problemHtml = await problemController
                              .getText(); // Wait for the future to resolve
                          String problemText = extractTextFromHtml(problemHtml);
                          String solutionHtml = await solutionController
                              .getText(); // Wait for the future to resolve
                          String solutionText =
                              extractTextFromHtml(solutionHtml);
                          String lessonHtml = await lessonController
                              .getText(); // Wait for the future to resolve
                          String lessonText = extractTextFromHtml(lessonHtml);
                          print(problemText);
                          print(solutionText);
                          print(lessonText);
                          HttpApiCall().addLesson(
                            context,
                            {
                              'project_id': projectIdController.text,
                              'department_id': deptIdController.text,
                              'prepared_by': preparedController.text,
                              'subject': subjectController.text,
                              'problem': problemText,
                              'solution': solutionText,
                              'lesson': lessonText,
                              'lesson_img': imageBase64,
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color1,
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          "Submit",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
