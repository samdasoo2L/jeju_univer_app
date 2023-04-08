import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({super.key});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  var tab = 0;
  List<String> titles = [];
  List<String> result = [];
  List<List> a = [];

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

    for (int i = 0; i < 10; i++) {
      a.add(result[i].split("<br>"));
    }

    setState(() {
      this.titles = titles;
      this.result = result;
      a = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List> evenData = [];
    List<List> oddData = [];

    for (int i = 0; i < a.length; i++) {
      if (i % 2 == 0) {
        evenData.add(a[i]);
      } else {
        oddData.add(a[i]);
      }
    }
    //print(evenData);

    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: a.length,
          itemBuilder: (context, index) {
            final b = evenData[index];
            return Row(
              children: [
                Container(child: const Text('a')),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < b.length; i++)
                        Text(
                          b[i],
                        )
                    ],
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
