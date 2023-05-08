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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            const SizedBox(
              width: 25,
            ),
            Text(
              stopBool ? "⚫" : "⚪",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              width: 20,
            ),
            const Text(
              "|",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              busStopName,
              style: const TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// manual
//  for (var i = 0; i < 11; i++)
//               BusNowLocationShow(
//                   busStopName: bBusStopLocation[i],
//                   stopBool: bNowLocationBool[bBusStopLocation[i]] ??= false)
