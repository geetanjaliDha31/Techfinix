// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:techfinix/Http/http.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/models/get_announcement.dart';

// ignore: must_be_immutable
class Announcement extends StatefulWidget {
  PanelController controller;
  Announcement({super.key, required this.controller});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: HttpApiCall().getAnnouncement(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            GetAnnouncement announcement = snapshot.data!;
            final data = announcement.resultArray![0].announcement??'';
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 4,
                      width: 80,
                      decoration: BoxDecoration(
                        color: grey1.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Announcement',
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            widget.controller.close();
                          },
                          icon: Icon(
                            Icons.clear_rounded,
                            color: grey1,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.7,
                      color: grey1.withOpacity(0.6),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      data,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                      ),
                    )
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
    );
  }
}
