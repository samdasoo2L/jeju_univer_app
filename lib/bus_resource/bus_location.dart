import 'package:flutter/material.dart';

class BusNowLocationShow extends StatelessWidget {
  String busStopName = "";
  bool stopBool = false;
  BusNowLocationShow({
    super.key,
    required this.busStopName,
    required this.stopBool,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            stopBool ? "여기!" : "놉..",
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            busStopName,
          ),
        ],
      ),
    );
  }
}

// manual
//  for (var i = 0; i < 11; i++)
//               BusNowLocationShow(
//                   busStopName: bBusStopLocation[i],
//                   stopBool: bNowLocationBool[bBusStopLocation[i]] ??= false)
