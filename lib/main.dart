// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/provider/email_provider.dart';
import 'package:techfinix/provider/login_sliding_up.dart';
import 'package:techfinix/provider/panel_provider.dart';
import 'package:techfinix/screens/All%20Projects/add_project.dart';
import 'package:techfinix/screens/Home/home.dart';
import 'package:techfinix/screens/Lesson%20Learnt/add_lesson.dart';
import 'package:techfinix/screens/Login/login.dart';
import 'package:provider/provider.dart';
import 'package:techfinix/screens/Man%20Hours/add_man_hours.dart';
import 'package:techfinix/screens/Man%20Hours/man_hour_report.dart';
import 'package:techfinix/screens/Man%20Hours/man_hours_calendar.dart';
import 'package:techfinix/screens/Polices/add_hr_policy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
  }

  bool? login;

  void getPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    login = prefs.getBool("loginInned");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SlidingUpPanelProvider()),
        ChangeNotifierProvider(create: (context) => PanelProvider()),
        ChangeNotifierProvider(create: (_) => EmailAddress()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Techfinix',
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSeed(seedColor: color1),
          useMaterial3: true,
        ),
        home: login != null ? const HomePage() : LoginPage(),
        // home: LoginPage(),
      ),
    );
  }
}
