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
  String aaaa = "";

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
    //result.removeWhere((item) => item.startsWith('없음'));

    for (int i = 0; i < result.length; i++) {
      collegeFoodMenu.add(result[i].split("<br>"));
    }
    String aaaa = collegeFoodMenu[2].toString();
    print(Text(aaaa));
    //result.length <- 10 으로 일단 변경하고 앱 테스트

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
        daytime = daytime;
        aaaa = aaaa;
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
                ]),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "백두관 메뉴표",
                  style: TextStyle(fontSize: 30.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Text(
                      daylist.isEmpty ? "로딩중입니다" : daylist[0],
                    ),
                    Text(aaaa.isEmpty ? "로딩" : aaaa,
                        style: const TextStyle(color: Colors.black)),
                  ],
                )
              ],
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
