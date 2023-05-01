import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../fivedays_weather.dart';
import 'loading.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<dynamic> preWeatherData = [];
  List<dynamic> fiveWeatherData = [];
  String duration = "";

  var date = DateTime.now();

  @override
  void initState() {
    super.initState();
    getUserOrder();
    getFiveWeather();
  }

  Future<void> getUserOrder() async {
    preWeatherData = await WeatherData().getLocation1();
    setState(() {});
  }

  Future<void> getFiveWeather() async {
    fiveWeatherData = await FiveWeatherData().getFiveWeatherData();
    setState(() {});
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/base.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 50.0.h,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30.w,
                                ),
                                Text(
                                  // '$cityName',
                                  '날씨',
                                  style: GoogleFonts.lato(
                                      fontSize: 40.0.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //   children: [
                            //     TimerBuilder.periodic(
                            //         const Duration(minutes: 1),
                            //         builder: (context) {
                            //       //print(getSystemTime());
                            //       return Text(
                            //         getSystemTime(),
                            //         style: GoogleFonts.lato(
                            //             fontSize: 16.0.sp,
                            //             fontWeight: FontWeight.bold,
                            //             color: const Color.fromRGBO(
                            //                 255, 178, 79, 1)),
                            //       );
                            //     }),
                            //     Text(
                            //       DateFormat('- EEEE,').format(date),
                            //       textAlign: TextAlign.left,
                            //       style: GoogleFonts.lato(
                            //           fontSize: 16.0,
                            //           fontWeight: FontWeight.bold,
                            //           color: const Color.fromRGBO(
                            //               255, 178, 79, 1)),
                            //     ),
                            //     Text(
                            //       DateFormat('d MMM, yyyy').format(date),
                            //       textAlign: TextAlign.left,
                            //       style: GoogleFonts.lato(
                            //           fontSize: 16.0.sp,
                            //           fontWeight: FontWeight.bold,
                            //           color: const Color.fromRGBO(
                            //               255, 178, 79, 1)),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 40.w,
                            ),
                            Column(
                              children: [
                                Text(
                                  "현재 제주대 날씨",
                                  style: TextStyle(
                                      color:
                                          const Color.fromRGBO(255, 178, 79, 1),
                                      fontSize: 20.sp),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      preWeatherData.isEmpty
                                          ? "로딩중입니다"
                                          : preWeatherData[0],
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              255, 178, 79, 1),
                                          fontSize: 50.sp),
                                    ), //온도text
                                    Text(
                                      '\u2103',
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              255, 178, 79, 1),
                                          fontSize: 50.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    //icon ??= const Text('새로고침을 해주세요'),
                                    //preWeatherData[6],
                                    Text(
                                      preWeatherData.isEmpty
                                          ? "로딩중입니다"
                                          : preWeatherData[5],
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              255, 178, 79, 1),
                                          fontSize: 30.sp),
                                    ), //날씨예보
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '대기질 지수',
                                      style: GoogleFonts.lato(
                                          fontSize: 20.0.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromRGBO(
                                              255, 178, 79, 1)),
                                    ),
                                    //pollution ??= const Text('null'),
                                    //preWeatherData[8],
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Column(
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.symmetric(vertical: 20.0.h),
                  //       decoration: BoxDecoration(
                  //           border: Border.all(
                  //               color: const Color.fromRGBO(255, 178, 79, 1))),
                  //     ),
                  //     Row(
                  //       children: [
                  //         Column(
                  //           children: [
                  //             Text(
                  //               'AQI(대기질 지수)',
                  //               style: GoogleFonts.lato(
                  //                   fontSize: 14.0.sp,
                  //                   fontWeight: FontWeight.bold,
                  //                   color:
                  //                       const Color.fromRGBO(255, 178, 79, 1)),
                  //             ),
                  //             //pollution ??= const Text('null'),
                  //             //preWeatherData[8],
                  //           ],
                  //         ),
                  //         SizedBox(width: 45.w),
                  //         Column(
                  //           children: [
                  //             Text(
                  //               '미세먼지',
                  //               style: GoogleFonts.lato(
                  //                   fontSize: 14.0.sp,
                  //                   fontWeight: FontWeight.bold,
                  //                   color:
                  //                       const Color.fromRGBO(255, 178, 79, 1)),
                  //             ),
                  //             const SizedBox(
                  //               height: 10.0,
                  //             ),
                  //             Text(
                  //               preWeatherData.isEmpty
                  //                   ? "로딩중입니다"
                  //                   : preWeatherData[10],
                  //               style: GoogleFonts.lato(
                  //                   fontSize: 14.0.sp,
                  //                   fontWeight: FontWeight.bold,
                  //                   color:
                  //                       const Color.fromRGBO(255, 178, 79, 1)),
                  //             ),
                  //             Text(
                  //               '㎍/m3',
                  //               style: GoogleFonts.lato(
                  //                   fontSize: 14.0.sp,
                  //                   fontWeight: FontWeight.bold,
                  //                   color:
                  //                       const Color.fromRGBO(255, 178, 79, 1)),
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(width: 50.w),
                  //         Column(
                  //           children: [
                  //             Text(
                  //               '초미세먼지',
                  //               style: GoogleFonts.lato(
                  //                   fontSize: 14.0.sp,
                  //                   fontWeight: FontWeight.bold,
                  //                   color:
                  //                       const Color.fromRGBO(255, 178, 79, 1)),
                  //             ),
                  //             SizedBox(
                  //               height: 10.h,
                  //             ),
                  //             Text(
                  //               preWeatherData.isEmpty
                  //                   ? "로딩중입니다"
                  //                   : preWeatherData[9],
                  //               style: GoogleFonts.lato(
                  //                   fontSize: 14.0.sp,
                  //                   fontWeight: FontWeight.bold,
                  //                   color:
                  //                       const Color.fromRGBO(255, 178, 79, 1)),
                  //             ),
                  //             Text(
                  //               '㎍/m3',
                  //               style: GoogleFonts.lato(
                  //                   fontSize: 14.0.sp,
                  //                   fontWeight: FontWeight.bold,
                  //                   color:
                  //                       const Color.fromRGBO(255, 178, 79, 1)),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
