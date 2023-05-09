import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../food_resource/college_food.dart';
import '../food_resource/professor_food.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  Future<void> _launchURL(String url) async {
    // final Uri uri = Uri(scheme: "https", host: url);
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/page.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        "식당",
                        style: GoogleFonts.lato(
                            fontSize: 40.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 90.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 90.h,
                        width: 245.w,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(19)),
                          border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(255, 178, 79, 1),
                          ),
                        ),
                        child: TextButton(
                          style: const ButtonStyle(),
                          onPressed: () {
                            collegeFoodMenu(context);
                            //collegeFoodMenu(context);
                          },
                          child: Text(
                            "백두관 식당",
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 90.h,
                        width: 245.w,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(19)),
                          border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(255, 178, 79, 1),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const CustomDialog());
                          },
                          child: Text(
                            "교수회관",
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 90.h,
                        width: 245.w,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(19)),
                          border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(255, 178, 79, 1),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _launchURL(
                                'https://ibfoodjeju.modoo.at/?link=70y98aj7');
                          },
                          child: Text(
                            "기숙사 식당",
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
