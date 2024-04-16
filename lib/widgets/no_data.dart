// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';

class NoDataPage extends StatefulWidget {
  const NoDataPage({super.key});

  @override
  State<NoDataPage> createState() => _NoDataPageState();
}

class _NoDataPageState extends State<NoDataPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/no_data.png'),
        Text(
          'No results found!',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
