import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'loading.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<dynamic> preWeatherData = [];
  String duration = "";

  var date = DateTime.now();

  @override
  void initState() {
    super.initState();
    getUserOrder();
  }

  Future<void> getUserOrder() async {
    preWeatherData = await WeatherData().getLocation1();
    setState(() {});
  }

  // List<String> format1(List<dynamic> infoData) {
  //   var temp = infoData[0].toString();
  //   var cityName = infoData[1].toString();
  //   var condition = infoData[2].toString();
  //   var grade = infoData[3].toString();
  //   var index = infoData[4].toString();
  //   var des = infoData[5].toString();
  //   var icon = infoData[6].toString();
  //   var pollution = infoData[7].toString();
  //   var quality = infoData[8].toString();
  //   var air = infoData[9].toString();
  //   var air2 = infoData[10].toString();
  //   return [
  //     temp,
  //     cityName,
  //     condition,
  //     grade,
  //     index,
  //     des,
  //     icon,
  //     pollution,
  //     quality,
  //     air,
  //     air2
  //   ];
  // }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.near_me,
        //     size: 30.0,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {},
        // ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.location_searching,
        //       size: 30.0,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {},s
        //   )
        // ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            preWeatherData.isEmpty ? "로딩중입니다" : preWeatherData[1],
            style: const TextStyle(color: Colors.black),
          ),
          //preWeatherData[6] ??= const Text('새로고침을 해주세요'),
        ],
      ),
      //   body: Container(
      //       child: Stack(
      //     children: [
      //       Container(
      //         decoration: const BoxDecoration(
      //           color: Colors.white,
      //         ),
      //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Expanded(
      //               child: Column(
      //                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       SizedBox(
      //                         height: 50.0.h,
      //                       ),
      //                       Text(
      //                         // '$cityName',
      //                         '제주대 날씨',
      //                         style: GoogleFonts.lato(
      //                             fontSize: 35.0.sp,
      //                             fontWeight: FontWeight.bold,
      //                             color: const Color.fromRGBO(152, 243, 7, 50)),
      //                       ),
      //                       const SizedBox(
      //                         height: 10,
      //                       ),
      //                       Row(
      //                         children: [
      //                           TimerBuilder.periodic(const Duration(minutes: 1),
      //                               builder: (context) {
      //                             //print(getSystemTime());
      //                             return Text(
      //                               getSystemTime(),
      //                               style: GoogleFonts.lato(
      //                                   fontSize: 16.0.sp,
      //                                   fontWeight: FontWeight.bold,
      //                                   color: const Color.fromRGBO(
      //                                       152, 243, 7, 50)),
      //                             );
      //                           }),
      //                           Text(
      //                             DateFormat('- EEEE,').format(date),
      //                             textAlign: TextAlign.left,
      //                             style: GoogleFonts.lato(
      //                                 fontSize: 16.0,
      //                                 fontWeight: FontWeight.bold,
      //                                 color:
      //                                     const Color.fromRGBO(152, 243, 7, 50)),
      //                           ),
      //                           Text(
      //                             DateFormat('d MMM, yyyy').format(date),
      //                             textAlign: TextAlign.left,
      //                             style: GoogleFonts.lato(
      //                                 fontSize: 16.0.sp,
      //                                 fontWeight: FontWeight.bold,
      //                                 color:
      //                                     const Color.fromRGBO(152, 243, 7, 50)),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBox(
      //                     height: 90.h,
      //                   ),
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         '$temp\u2103',
      //                         style: GoogleFonts.lato(
      //                             fontSize: 85.0.sp,
      //                             fontWeight: FontWeight.w300,
      //                             color: const Color.fromRGBO(152, 243, 7, 50)),
      //                       ),
      //                       Row(
      //                         children: [
      //                           // SvgPicture.asset(
      //                           //     'assets/svg/climaconCloudLightning.svg'),
      //                           icon ??= const Text('새로고침을 해주세요'),
      //                           SizedBox(
      //                             width: 10.w,
      //                           ),
      //                           Text(
      //                             '$des',
      //                             style: GoogleFonts.lato(
      //                                 fontSize: 15.0.sp,
      //                                 //fontWeight: FontWeight.bold,
      //                                 color:
      //                                     const Color.fromRGBO(152, 243, 7, 50)),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   )
      //                 ],
      //               ),
      //             ),
      //             Column(
      //               children: [
      //                 Container(
      //                   margin: EdgeInsets.symmetric(vertical: 20.0.h),
      //                   decoration: BoxDecoration(
      //                       border: Border.all(color: Colors.white30)),
      //                 ),
      //                 Row(
      //                   children: [
      //                     Column(
      //                       children: [
      //                         Text(
      //                           'AQI(대기질 지수)',
      //                           style: GoogleFonts.lato(
      //                               fontSize: 14.0.sp,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.white),
      //                         ),
      //                         pollution ??= const Text('null'),
      //                         quality ??= const Text('새로고침을 해주세요'),
      //                       ],
      //                     ),
      //                     SizedBox(width: 45.w),
      //                     Column(
      //                       children: [
      //                         Text(
      //                           '미세먼지',
      //                           style: GoogleFonts.lato(
      //                               fontSize: 14.0.sp,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.white),
      //                         ),
      //                         const SizedBox(
      //                           height: 10.0,
      //                         ),
      //                         Text(
      //                           '$air2',
      //                           style: GoogleFonts.lato(
      //                               fontSize: 24.0.sp,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.white),
      //                         ),
      //                         Text(
      //                           '㎍/m3',
      //                           style: GoogleFonts.lato(
      //                               fontSize: 14.0.sp,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.white),
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(width: 50.w),
      //                     Column(
      //                       children: [
      //                         Text(
      //                           '초미세먼지',
      //                           style: GoogleFonts.lato(
      //                               fontSize: 14.0.sp,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.white),
      //                         ),
      //                         SizedBox(
      //                           height: 10.h,
      //                         ),
      //                         Text(
      //                           '$air',
      //                           style: GoogleFonts.lato(
      //                               fontSize: 24.0.sp,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.white),
      //                         ),
      //                         Text(
      //                           '㎍/m3',
      //                           style: GoogleFonts.lato(
      //                               fontSize: 14.0.sp,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.white),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 )
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ],
      //   )),
      // );
    );
  }
}
