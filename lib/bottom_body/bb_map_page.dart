import 'package:flutter/material.dart';

void main() => runApp(const MapPage());

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<List<String>> _data = [
    ['apple', 'banana', 'orange'],
    ['dog', 'cat', 'bird'],
    ['car', 'bus', 'train']
  ];

  @override
  Widget build(BuildContext context) {
    List<List<String>> evenData = [];
    List<List<String>> oddData = [];

    for (int i = 0; i < _data.length; i++) {
      if (i % 2 == 0) {
        evenData.add(_data[i]);
      } else {
        oddData.add(_data[i]);
      }
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Even/Odd List Example'),
        ),
        body: Column(
          children: [
            const Text('Even List'),
            ListView.separated(
              shrinkWrap: true,
              itemCount: evenData.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: evenData[index].map((item) {
                      return ListTile(
                        title: Text(item),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            const Text('Odd List'),
            ListView.separated(
              shrinkWrap: true,
              itemCount: oddData.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: oddData[index].map((item) {
                      return ListTile(
                        title: Text(item),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
