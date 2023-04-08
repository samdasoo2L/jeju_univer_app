import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class DormitoryMenu extends StatefulWidget {
  const DormitoryMenu({super.key});

  @override
  State<DormitoryMenu> createState() => _DormitoryMenuState();
}

class _DormitoryMenuState extends State<DormitoryMenu> {
  List<String> urlImages2 = [];

  @override
  void initState() {
    super.initState();

    getWebsiteData2();
  }

  Future getWebsiteData2() async {
    final url = Uri.parse('https://ibfoodjeju.modoo.at');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final urlImages2 = html
        .querySelectorAll('div.area_info > div > a')
        .map((element) =>
            'https://ibfoodjeju.modoo.at/${element.attributes['src']!}')
        .toList();

    print(urlImages2.length);
    print(urlImages2);

    setState(() {
      this.urlImages2 = urlImages2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final urlImage = urlImages2[index];
              return Column(
                children: [
                  const Text('aaa'),
                  Container(
                    child: Image.network(
                      urlImage,
                      height: 373,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              );
            },
            itemCount: urlImages2.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ],
      )),
    );
  }
}
