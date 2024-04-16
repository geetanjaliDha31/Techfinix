import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_policy_details.dart';
import 'package:techfinix/widgets/announcement.dart';

class PolicyDetailsPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const PolicyDetailsPage({super.key, required this.data});

  @override
  State<PolicyDetailsPage> createState() => _PolicyDetailsPageState();
}

class _PolicyDetailsPageState extends State<PolicyDetailsPage> {
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
                'Policies',
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
      body: FutureBuilder(
        future: HttpApiCall().getPolicyDetails(
          {
            'policies_tbl_id': widget.data['policies_tbl_id'],
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            GetPolicyDetails policyDetails = snapshot.data!;
            final policies = policyDetails.resultArray![0];
            return Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Policy Number:${policies.policiesId}",
                            style: GoogleFonts.inter(
                              color: grey1,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            policies.policyName ?? '',
                            style: GoogleFonts.inter(
                              color: color1,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            policies.policyDescription ?? '',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          )
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
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
