import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

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
  List<List> dinnerbiglist = [[], [], [], [], []];
  List<List> lunchbiglist = [[], [], [], [], []];
  List<String> daybiglist = ["", "", "", "", ""];

  @override
  void initState() {
    super.initState();
    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://www.jejunu.ac.kr/camp/stud/foodmenu.htm');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    var titles = html
        .querySelectorAll('body > script')
        .map((element) => element.innerHtml.trim())
        .toList();

    var dinnerlist = titles[8].split("dinner\":\"");

    for (int i = 0; i < 5; i++) {
      String beforedinnerbiglist = (dinnerlist[i + 1].split("\",\""))[0];
      dinnerbiglist[i] = beforedinnerbiglist.split("\\r\\n");
    }

    var lunchlist = titles[8].split("lunch\":\"");

    for (int i = 0; i < 5; i++) {
      String beforelunchbiglist = (lunchlist[i + 1].split("\",\""))[0];
      lunchbiglist[i] = beforelunchbiglist.split("\\r\\n");
    }

    var daylist = titles[8].split("date\":\"");

    for (int i = 0; i < 5; i++) {
      daybiglist[i] = (daylist[i + 1].split("\",\""))[0];
    }

    setState(() {
      result = result;
    });
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
                      todayinfo: daybiglist[i],
                      todaylunchinfo: lunchbiglist[i],
                      todaydinnerinfo: dinnerbiglist[i],
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
