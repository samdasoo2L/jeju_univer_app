import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            SizedBox(
              width: 25.w,
            ),
            Text(
              stopBool ? "⚫" : "⚪",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              "|",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 255, 165, 47),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              busStopName,
              style: TextStyle(
                fontSize: 14.sp,
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
