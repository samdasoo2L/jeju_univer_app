import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/bottom_body/bb_food_page.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodSelected extends StatelessWidget {
  const FoodSelected({super.key});

  Future<void> _launchURL(String url) async {
    // final Uri uri = Uri(scheme: "https", host: url);
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
      // _launchURL('https://ibfoodjeju.modoo.at/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: const Color.fromRGBO(255, 178, 79, 1),
        title: const Text("세상에서 가장 힘든 시간"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 178, 79, 1),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(19)),
                    border: Border.all(
                      color: Colors.white70,
                    ),
                  ),
                  child: TextButton(
                    style: const ButtonStyle(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodDetailPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "학식의 민족",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(19)),
                    border: Border.all(
                      color: Colors.white70,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "정문은 여기어때",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(19)),
                    border: Border.all(
                      color: Colors.white70,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "후문은 요기요",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
