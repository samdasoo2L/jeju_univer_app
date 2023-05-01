import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({super.key});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  List<String> titles = [];
  List<String> result = [];
  List<List> collegeFoodMenu = [];
  List<String> daytime = [];
  List<String> daylist = [];

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
    result.removeWhere((item) => item.startsWith('없음'));

    for (int i = 0; i < result.length; i++) {
      collegeFoodMenu.add(result[i].split("<br>"));
    }
    //result.length <- 10 으로 일단 변경하고 앱 테스트

    var daytime = html
        .querySelectorAll('table > tbody > tr > td:nth-child(1)')
        .map((element) => element.innerHtml.trim())
        .toList();

    for (int i = 0; i < 18; i += 4) {
      daylist.add(daytime[i].split("<br>")[0]);
    }

    setState(() {
      this.titles = titles;
      this.result = result;
      collegeFoodMenu = collegeFoodMenu;
      daytime = daytime;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List> evenData = [];
    List<List> oddData = [];

    for (int i = 0; i < collegeFoodMenu.length; i++) {
      if (i % 2 == 0) {
        evenData.add(collegeFoodMenu[i]);
      } else {
        oddData.add(collegeFoodMenu[i]);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: daylist.length,
          itemBuilder: (context, index) {
            final lunchMenu = evenData[index];
            //final dinnerMenu = oddData[index];
            final days = daylist[index];
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      days,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    Column(
                      children: [
                        for (int i = 0; i < lunchMenu.length - 1; i++)
                          Text(
                            lunchMenu[i],
                            style: TextStyle(fontSize: 14.sp),
                          )
                      ],
                    ),
                    Column(
                      children: const [
                        // for (int i = 0; i < dinnerMenu.length; i++)
                        //   Text(
                        //     dinnerMenu[i],
                        //   )
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
        ),
      ),
    );
  }
}
