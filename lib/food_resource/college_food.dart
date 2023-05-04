import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

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
  List<String> daylist = [];

  @override
  void initState() {
    super.initState();
    getWebsiteData();
    setState(() {});
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

    var daytime = html
        .querySelectorAll('table > tbody > tr > td:nth-child(1)')
        .map((element) => element.innerHtml.trim())
        .toList();

    for (int i = 0; i < 18; i += 4) {
      daylist.add(daytime[i].split("<br>")[0]);
    }

    setState(
      () {
        this.titles = titles;
        result = result;
        collegeFoodMenu = collegeFoodMenu;
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
            margin: const EdgeInsets.only(top: 13.0, right: 8.0),
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
                  collegeFoodMenuList(
                      daylist: daylist,
                      collegeFoodMenu: collegeFoodMenu,
                      daysNumber: 0,
                      lunchMenuNumber: 2,
                      dinnerMenuNumber: 3),
                  collegeFoodMenuList(
                    daylist: daylist,
                    collegeFoodMenu: collegeFoodMenu,
                    daysNumber: 1,
                    lunchMenuNumber: 8,
                    dinnerMenuNumber: 9,
                  ),
                  collegeFoodMenuList(
                    daylist: daylist,
                    collegeFoodMenu: collegeFoodMenu,
                    daysNumber: 2,
                    lunchMenuNumber: 16,
                    dinnerMenuNumber: 17,
                  ),
                  collegeFoodMenuList(
                    daylist: daylist,
                    collegeFoodMenu: collegeFoodMenu,
                    daysNumber: 3,
                    lunchMenuNumber: 24,
                    dinnerMenuNumber: 25,
                  ),
                  collegeFoodMenuList(
                    daylist: daylist,
                    collegeFoodMenu: collegeFoodMenu,
                    daysNumber: 4,
                    lunchMenuNumber: 32,
                    dinnerMenuNumber: 33,
                  ),
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

class collegeFoodMenuList extends StatelessWidget {
  const collegeFoodMenuList(
      {super.key,
      required this.daylist,
      required this.collegeFoodMenu,
      required this.daysNumber,
      required this.lunchMenuNumber,
      required this.dinnerMenuNumber});

  final List<String> daylist;
  final List<List> collegeFoodMenu;
  final int daysNumber;
  final int lunchMenuNumber;
  final int dinnerMenuNumber;

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
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: const [
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
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: const [
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
