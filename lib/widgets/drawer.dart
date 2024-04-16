// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/screens/Feedback/feedback.dart';
import 'package:techfinix/screens/Man%20Hours/man_hours.dart';
import 'package:techfinix/screens/Holidays/holidays.dart';
import 'package:techfinix/screens/Home/home.dart';
import 'package:techfinix/screens/Leaves/leaves.dart';
import 'package:techfinix/screens/Lesson%20Learnt/lessons.dart';
import 'package:techfinix/screens/Monthly%20Attendance/monthly_attendace.dart';
import 'package:techfinix/screens/Polices/policy.dart';
import 'package:techfinix/screens/Profile/profile.dart';
import 'package:techfinix/screens/Salary/salary.dart';
import 'package:techfinix/screens/Settings/settings.dart';
import 'package:techfinix/screens/Expense%20Claim/expense_claim_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String name = '';
  String image = '';
  String designation = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? '';
      designation = prefs.getString("designation") ?? '';
      image = prefs.getString("emp_photos") ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(height: 25),
            Center(
              child: Text(
                'Techfinix EMS',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: color1,
                ),
              ),
            ),
            Container(
              height: 10,
              constraints: const BoxConstraints(minHeight: 10),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: grey1,
                height: 1,
                thickness: 0.5,
              ),
            ),
            Container(
              height: 20,
              constraints: const BoxConstraints(minHeight: 20),
            ),
            InkWell(
              onTap: () {
                Scaffold.of(context).closeDrawer();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  constraints: const BoxConstraints(minHeight: 80),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  decoration: BoxDecoration(
                      color: color3, borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              image,
                            ),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            designation,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: color1,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 15,
              constraints: const BoxConstraints(minHeight: 20),
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 40),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/home.svg",
                      colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      width: 22,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Home",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                    // const Spacer(),
                    // Icon(
                    //   Icons.arrow_forward_ios_rounded,
                    //   size: 13,
                    //   color: color1,
                    // ),
                    // const SizedBox(
                    //   width: 8,
                    // )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MonthlyAttendance(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/calendar.svg",
                      colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
                      width: 22,
                      height: 22,
                    ),
                    Container(
                      width: 20,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Attendance",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SalaryPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/rupee.svg",
                      colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
                      width: 18,
                      height: 18,
                    ),
                    Container(
                      width: 30,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Salary",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LeavesPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/leave.svg",
                      colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      width: 25,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Leaves",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HolidayPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/holiday.svg",
                      colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      width: 25,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Holidays",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManHoursPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timeline_rounded,
                      color: color1,
                      size: 22,
                    ),
                    Container(
                      width: 22,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Man-hours",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LessonsListPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/lesson_learnt.svg",
                      colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
                      width: 22,
                      height: 22,
                    ),
                    Container(
                      width: 22,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Lesson Learnt",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PolicyPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.policy_outlined,
                      color: color1,
                      size: 22,
                    ),
                    Container(
                      width: 20,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Policies",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ExpenseClaimPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/voucher.svg",
                      colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      width: 20,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Expense Claim",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FeedbackPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/feedback.svg",
                      colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
                      width: 18,
                      height: 18,
                    ),
                    Container(
                      width: 20,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Feedback",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 30,
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings_outlined,
                      color: color1,
                      size: 22,
                    ),
                    Container(
                      width: 20,
                      constraints: const BoxConstraints(minWidth: 12),
                    ),
                    Text(
                      "Settings",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 10,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TechFinix",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: color1,
                    ),
                  ),
                  Text(
                    "V1.0",
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: grey1,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
