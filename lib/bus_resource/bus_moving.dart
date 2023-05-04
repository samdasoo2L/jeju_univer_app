import 'package:flutter/material.dart';

class BusMoving extends StatelessWidget {
  String busStop;
  bool stopOrNot;

  BusMoving({super.key, required this.busStop, required this.stopOrNot});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            stopOrNot ? "0" : "X",
          ),
          Text(
            busStop,
          )
        ],
      ),
    );
  }
}
