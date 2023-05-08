import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../resources/time_resources.dart';
import 'food_list_widge.dart';

Future<dynamic> collegeFoodMenu(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (_) {
      return const MyStatefulDialog();
    },
  );
}

class MyStatefulDialog extends StatefulWidget {
  const MyStatefulDialog({super.key});

  @override
  State<MyStatefulDialog> createState() => _MyStatefulDialogState();
}

class _MyStatefulDialogState extends State<MyStatefulDialog> {
  List<String> titles = [];
  List<String> result = [];
  List<List> collegeFoodMenu = [];
  List<String> daytime = [];
  List<String> daylist = ["로딩중", "로딩중", "로딩중", "로딩중", "로딩중"];
  List<int> lunchMenuNumber = [0, 0, 0, 0, 0];
  List<int> dinnerMenuNumber = [0, 0, 0, 0, 0];
  List<bool> todayMenuBool = [false, false, false, false, false];
  List<String> todayNumSource = NowTime().timeCutting();

  @override
  void initState() {
    super.initState();
    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://www.jejunu.ac.kr/camp/stud/foodmenu');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    var titles = html
        .querySelectorAll('td.border_right.border_bottom.txt_center > p')
        .map((element) => element.innerHtml.trim())
        .toList();

    List<String> result = titles.toList();

    for (int i = 0; i < result.length; i++) {
      collegeFoodMenu.add(result[i].split("<br>"));
    }

    int daysNum = 0;
    for (int i = 0; i < collegeFoodMenu.length; i++) {
      if (collegeFoodMenu[i][0] != "없음") {
        lunchMenuNumber[daysNum] = i;
        dinnerMenuNumber[daysNum] = i + 1;
        i += 1;
        daysNum += 1;
      }
    }

    var daytime = html
        .querySelectorAll('table > tbody > tr > td:nth-child(1)')
        .map((element) => element.innerHtml.trim())
        .toList();

    List<int> foodDayList = [0, 4, 8, 12, 16];
    for (int i = 0; i <= 4; i++) {
      daylist[i] = (daytime[foodDayList[i]].split("<br>")[0]);
    }

    String todayInfo = "${todayNumSource[3]}/${todayNumSource[4]}";
    // String todayInfo = "05/01";

    for (int i = 0; i <= 4; i++) {
      if (daylist[i] == todayInfo) todayMenuBool[i] = true;
    }

    setState(
      () {
        this.titles = titles;
        result = result;
        collegeFoodMenu = collegeFoodMenu;
        todayMenuBool = todayMenuBool;
        print(todayInfo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            width: 400.w,
            height: 500.h,
            margin: const EdgeInsets.only(top: 0.0, right: 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 0.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "백두관 메뉴표",
                    style: TextStyle(fontSize: 30.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  for (var i = 0; i <= 4; i++)
                    CollegeFoodMenuList(
                        daylist: daylist,
                        collegeFoodMenu: collegeFoodMenu,
                        daysNumber: i,
                        lunchMenuNumber: lunchMenuNumber[i],
                        dinnerMenuNumber: dinnerMenuNumber[i],
                        todayMenuBool: todayMenuBool[i]),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
