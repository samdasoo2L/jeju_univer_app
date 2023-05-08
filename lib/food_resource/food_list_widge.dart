import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollegeFoodMenuList extends StatelessWidget {
  const CollegeFoodMenuList(
      {super.key,
      required this.daylist,
      required this.collegeFoodMenu,
      required this.daysNumber,
      required this.lunchMenuNumber,
      required this.dinnerMenuNumber,
      required this.todayMenuBool});

  final List<String> daylist;
  final List<List> collegeFoodMenu;
  final int daysNumber;
  final int lunchMenuNumber;
  final int dinnerMenuNumber;
  final bool todayMenuBool;

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
                  daylist.isEmpty ? "로딩중입니다" : daylist[daysNumber],
                  style: TextStyle(
                    color: todayMenuBool ? Colors.amber[800] : Colors.black,
                    fontSize: 15.sp,
                  ),
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
                    const Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('점심'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          if (collegeFoodMenu.isEmpty)
                            const Text("로딩중")
                          else
                            for (var name1 in collegeFoodMenu[lunchMenuNumber])
                              Text(
                                name1.replaceAll('amp;', ''),
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
                    const Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('저녁'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          if (collegeFoodMenu.isEmpty)
                            const Text("로딩중")
                          else
                            for (var name1 in collegeFoodMenu[dinnerMenuNumber])
                              Text(name1),
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
