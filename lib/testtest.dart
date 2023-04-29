import 'dart:async';
import 'package:flutter/material.dart';

class Periodic extends StatefulWidget {
  const Periodic({super.key});
  @override
  State<Periodic> createState() => _PeriodicState();
}

class _PeriodicState extends State<Periodic> {
  DateTime nowTime = DateTime.now();
  void onTimer(Timer timer) {
    setState(() {
      nowTime = DateTime.now();
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), onTimer);
  }

  String format(DateTime nowTime) {
    var duration = nowTime.toString();
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          format(nowTime),
        ),
      ),
    );
  }
}
