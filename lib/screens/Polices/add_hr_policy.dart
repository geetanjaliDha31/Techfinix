import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/widgets/textfield.dart';

class AddHRPolicy extends StatefulWidget {
  const AddHRPolicy({super.key});

  @override
  State<AddHRPolicy> createState() => _AddHRPolicyState();
}

class _AddHRPolicyState extends State<AddHRPolicy> {
  final TextEditingController pnumberController = TextEditingController();
  final TextEditingController pnameController = TextEditingController();
  HtmlEditorController policyController = HtmlEditorController();

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
                'Add HR Policy',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBox(
                  controller: pnumberController,
                  hinttext: "Policy Number",
                  label: "",
                  obscureText: false,
                  isNumber: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextBox(
                  controller: pnameController,
                  hinttext: "Policy Name",
                  label: "",
                  obscureText: false,
                  isNumber: false,
                ),
                const SizedBox(
                  height: 30,
                ),
                HtmlEditor(
                  controller: policyController,
                  htmlEditorOptions: const HtmlEditorOptions(
                    hint: "Write here...",
                  ),
                  htmlToolbarOptions: const HtmlToolbarOptions(
                    toolbarType: ToolbarType.nativeGrid,
                    gridViewHorizontalSpacing: 2,
                    gridViewVerticalSpacing: 1,
                    toolbarItemHeight: 29,
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
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: grey1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                  onPressed: () {},
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
