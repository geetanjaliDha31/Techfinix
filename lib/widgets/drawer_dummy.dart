// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:techfinix/constants.dart';
// import 'package:techfinix/screens/Daily%20Timeline/daily_timeline.dart';
// import 'package:techfinix/screens/Holidays/holidays.dart';
// import 'package:techfinix/screens/Home/home.dart';
// import 'package:techfinix/screens/Leaves/leaves.dart';
// import 'package:techfinix/screens/Lesson%20Learnt/lessons.dart';
// import 'package:techfinix/screens/Monthly%20Attendance/monthly_attendace.dart';
// import 'package:techfinix/screens/Polices/policy.dart';
// import 'package:techfinix/screens/Salary/salary.dart';
// import 'package:techfinix/screens/Settings/settings.dart';
// import 'package:techfinix/screens/Vouchers/vouchers.dart';

// class DrawerWidget extends StatelessWidget {
//   const DrawerWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       width: MediaQuery.of(context).size.width * 0.75,
//       // shape: RoundedRectangleBorder(
//       //   borderRadius: BorderRadius.only(
//       //       topRight: Radius.circular(0.r),
//       //       bottomRight: Radius.circular(0.r)),
//       // ),
//       child: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.all(20),
//         child: Builder(builder: (context) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(height: 30),
//               // Container(
//               //   width: double.infinity,
//               //   alignment: Alignment.centerRight,
//               //   child: IconButton(
//               //     style: ElevatedButton.styleFrom(
//               //         // backgroundColor: color3,
//               //         shape: const CircleBorder(),
//               //         padding: const EdgeInsets.all(0)),
//               //     icon: Icon(
//               //       Icons.close_rounded,
//               //       color: color1,
//               //     ),
//               //     onPressed: () {
//               //       Scaffold.of(context).closeDrawer();
//               //     },
//               //   ),
//               // ),
//               Container(
//                 height: 10,
//               ),
//               Text(
//                 'Techfinix EMS',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: color1,
//                 ),
//               ),
//               Container(
//                 height: 10,
//                 constraints: const BoxConstraints(minHeight: 10),
//               ),
//               Divider(
//                 color: grey1,
//                 height: 1,
//                 thickness: 0.5,
//               ),
//               Container(
//                 height: 20,
//                 constraints: const BoxConstraints(minHeight: 20),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 80,
//                 constraints: const BoxConstraints(minHeight: 80),
//                 padding: const EdgeInsets.all(13),
//                 decoration: BoxDecoration(
//                     color: color3, borderRadius: BorderRadius.circular(15)),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 60,
//                       width: 60,
//                       decoration: const BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage("assets/employee.png"),
//                               fit: BoxFit.cover),
//                           shape: BoxShape.circle),
//                     ),
//                     Container(
//                       width: 7,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Vijay Sharma',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text(
//                           'Inspection Manager',
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                             color: color1,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 15,
//                 constraints: const BoxConstraints(minHeight: 20),
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 40),
//                 padding: const EdgeInsets.only(left: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const HomePage(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/home.svg",
//                         colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
//                         width: 20,
//                         height: 20,
//                       ),
//                       Container(
//                         width: 22,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Home",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                       // const Spacer(),
//                       // Icon(
//                       //   Icons.arrow_forward_ios_rounded,
//                       //   size: 13,
//                       //   color: color1,
//                       // ),
//                       // const SizedBox(
//                       //   width: 8,
//                       // )
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 30),
//                 padding: const EdgeInsets.only(left: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const MonthlyAttendance(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/calendar.svg",
//                         colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
//                         width: 22,
//                         height: 22,
//                       ),
//                       Container(
//                         width: 20,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Attendance",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 30),
//                 padding: const EdgeInsets.only(left: 15),
//                 child: InkWell(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const SalaryPage(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/rupee.svg",
//                         colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
//                         width: 18,
//                         height: 18,
//                       ),
//                       Container(
//                         width: 30,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Salary",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 30),
//                 padding: const EdgeInsets.only(left: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const LeavesPage(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/leave.svg",
//                         colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
//                         width: 20,
//                         height: 20,
//                       ),
//                       Container(
//                         width: 25,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Leaves",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 14,
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 30),
//                 padding: const EdgeInsets.only(left: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const HolidayPage(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/holiday.svg",
//                         colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
//                         width: 20,
//                         height: 20,
//                       ),
//                       Container(
//                         width: 25,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Holidays",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(
//                 height: 14,
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 30),
//                 padding: const EdgeInsets.only(left: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const DailyTimelinePage(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.timeline_rounded,
//                         color: color1,
//                         size: 22,
//                       ),
//                       Container(
//                         width: 22,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Man-hours",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 14,
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 30),
//                 padding: const EdgeInsets.only(left: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const LessonsListPage(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/lesson_learnt.svg",
//                         colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
//                         width: 22,
//                         height: 22,
//                       ),
//                       Container(
//                         width: 22,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Lesson Learnt",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 14,
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 30),
//                 padding: const EdgeInsets.only(left: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const PolicyPage(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.policy_outlined,
//                         color: color1,
//                         size: 22,
//                       ),
//                       Container(
//                         width: 20,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Policies",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 14,
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 30),
//                 padding: const EdgeInsets.only(left: 10),
//                 child: InkWell(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const VoucherListPage(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/voucher.svg",
//                         colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
//                         width: 20,
//                         height: 20,
//                       ),
//                       Container(
//                         width: 20,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Expense Claim",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 14,
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 30),
//                 padding: const EdgeInsets.only(left: 12),
//                 child: InkWell(
//                   onTap: () {
//                     // Scaffold.of(context).closeDrawer();
//                     // Navigator.of(context).push(
//                     //   MaterialPageRoute(
//                     //     builder: (context) => const LessonsListPage(),
//                     //   ),
//                     // );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/feedback.svg",
//                         colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
//                         width: 18,
//                         height: 18,
//                       ),
//                       Container(
//                         width: 20,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Feedback",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 14,
//               ),
//               Container(
//                 height: 30,
//                 constraints: const BoxConstraints(minHeight: 30),
//                 padding: const EdgeInsets.only(left: 10),
//                 child: InkWell(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const SettingsPage(),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.settings_outlined,
//                         color: color1,
//                         size: 22,
//                       ),
//                       Container(
//                         width: 20,
//                         constraints: const BoxConstraints(minWidth: 12),
//                       ),
//                       Text(
//                         "Settings",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: black2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 10,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "TechFinix",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: color1,
//                     ),
//                   ),
//                   Text(
//                     "V1.0",
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                       color: grey1,
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
