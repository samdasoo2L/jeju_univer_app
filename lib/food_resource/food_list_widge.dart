import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollegeFoodMenuList extends StatelessWidget {
  const CollegeFoodMenuList({
    super.key,
    required this.todayinfo,
    required this.todaylunchinfo,
    required this.todaydinnerinfo,
  });

  final String todayinfo;
  final List todaylunchinfo;
  final List todaydinnerinfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black26,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  todayinfo.isEmpty ? "로딩중입니다" : todayinfo,
                  // style: TextStyle(
                  //   // color: todayMenuBool ? Colors.amber[800] : Colors.black,
                  //   // fontSize: todayMenuBool ? 20.sp : 15.sp,
                  // ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            '점심',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          if (todaylunchinfo.isEmpty)
                            const Text("로딩중")
                          else
                            for (var lunchL in todaylunchinfo)
                              Text(
                                // name1.replaceAll('amp;', ''),
                                lunchL, style: TextStyle(fontSize: 15.sp),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            '저녁',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          if (todaydinnerinfo.isEmpty)
                            const Text("로딩중")
                          else
                            for (var dinnerL in todaydinnerinfo)
                              Text(
                                dinnerL,
                                style: TextStyle(fontSize: 15.sp),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
