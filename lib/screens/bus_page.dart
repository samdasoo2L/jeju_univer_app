import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bus_resource/bus_dialog.dart';
import '../bus_resource/bus_info.dart';
import '../bus_resource/bus_location.dart';
import '../bus_resource/bus_notification.dart';
import '../resources/time_resources.dart';

class BusPage extends StatefulWidget {
  const BusPage({super.key});
  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  List<String> nowTimeInfo = ["", "", "", "", "", "", ""];
  int mainTime = 800;
  String daysData = "";
  String aState = "";
  String bState = "";
  Map<String, bool> aNowLocationBool = BusStopLocation().aLocationBool;
  Map<String, bool> bNowLocationBool = BusStopLocation().bLocationBool;
  final List<int> aBusTimeLine = BusTimeLine().aTimeLine;
  final List<int> bBusTimeLine = BusTimeLine().bTimeLine;
  final List<String> aBusStopLocation = BusStopLocation().aBusStopLocation;
  final List<String> bBusStopLocation = BusStopLocation().bBusStopLocation;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), forTimeInfoUpdate);
  }

  void forTimeInfoUpdate(Timer timer) {
    setState(() {
      nowTimeInfo = NowTime().timeCutting();
      mainTime = int.parse(nowTimeInfo[6]);
      daysData = nowTimeInfo[5];
      nowState();
    });
  }

  void nowState() {
    if (daysData == "토요일" || daysData == "일요일") {
      aState = "주말은 운행하지 않습니다.";
      bState = "주말은 운행하지 않습니다.";
      return;
    }
    if (440 > mainTime || mainTime > 1200) {
      aState = "운영시간이 아닙니다.";
      bState = "운영시간이 아닙니다.";
      return;
    }

    int aNowDep = 0;
    int aNextDep = 485;
    int bNowDep = 0;
    int bNextDep = 490;
    for (var i = 0; i < aBusTimeLine.length - 1; i++) {
      if (mainTime >= aBusTimeLine[i]) {
        aNowDep = aBusTimeLine[i];
        aNextDep = aBusTimeLine[i + 1];
      }
      if (mainTime >= bBusTimeLine[i]) {
        bNowDep = bBusTimeLine[i];
        bNextDep = bBusTimeLine[i + 1];
      }
      // 여기 크게 if문이랑 break써서 줄 줄일수 있을듯 무조건 i끝까지 돌아가는거 막기
    }
    if (aNowDep == 0) {
      int waitingTime = aNextDep - mainTime;
      aState = "첫차까지 $waitingTime분 남았습니다.";
    } else if (aBusTimeLine[22] + 12 <= mainTime) {
      aState = "금일 운영 종료되었습니다.";
    } else if (mainTime - aNowDep < 12) {
      String aNowLocation = aBusStopLocation[mainTime - aNowDep];
      aState = "현재 $aNowLocation을 지나고 있습니다.";
      aNowLocationBool.forEach((key, value) {
        aNowLocationBool[key] = false;
      });
      aNowLocationBool[aNowLocation] = true;
    } else {
      int nextWaitTime = aNextDep - mainTime;
      aNowLocationBool["교양동"] = false;
      aState = "$nextWaitTime분후 출발합니다.";
    }
    if (bNowDep == 0) {
      var waitingTime = bNextDep - mainTime;
      bState = "첫차까지 $waitingTime분 남았습니다.";
    } else if (bBusTimeLine[22] + 12 <= mainTime) {
      bState = "금일 운영 종료되었습니다.";
    } else if (mainTime - bNowDep < 12) {
      String bNowLocation = bBusStopLocation[mainTime - bNowDep];
      bState = "현재 $bNowLocation을 지나고 있습니다.";
      bNowLocationBool.forEach((key, value) {
        bNowLocationBool[key] = false;
      });
      bNowLocationBool[bNowLocation] = true;
    } else {
      int nextWaitTime = bNextDep - mainTime;
      bNowLocationBool["본관"] = false;
      bState = "$nextWaitTime분후 출발합니다.";
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
                        '버스',
                        style: GoogleFonts.lato(
                            fontSize: 40.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const BusNotificationDialog());
                        },
                        icon: Icon(
                          FontAwesomeIcons.circleQuestion,
                          color: Colors.white,
                          size: 20.h,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.5,
                        color: const Color.fromARGB(255, 255, 165, 47),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 5,
                      ),
                      child: Text(
                        "${nowTimeInfo[0]}:${nowTimeInfo[1]}:${nowTimeInfo[2]}",
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 320.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2.5,
                                    color:
                                        const Color.fromARGB(255, 255, 165, 47),
                                  ),
                                ),
                                width: 160.w,
                                height: 70.h,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        Text(
                                          "A코스",
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            aState,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                        width: 2.5,
                                        color: const Color.fromRGBO(
                                            255, 178, 79, 1),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                BusDialog(
                                                  busStopLocation:
                                                      aBusStopLocation,
                                                  timeLine: aBusTimeLine,
                                                  busType: 'A코스',
                                                ));
                                      },
                                      child: Text(
                                        "A코스 시간표",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2.5,
                                    color:
                                        const Color.fromARGB(255, 255, 174, 68),
                                  ),
                                ),
                                width: 160.w,
                                height: 180.h,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        for (var i = 0; i <= 11; i++)
                                          BusNowLocationShow(
                                              busStopName: aBusStopLocation[i],
                                              stopBool: aNowLocationBool[
                                                      aBusStopLocation[i]] ??=
                                                  false),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: 1.5,
                            height: 295.h,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 165, 47)),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2.5,
                                    color:
                                        const Color.fromARGB(255, 255, 165, 47),
                                  ),
                                ),
                                width: 160.w,
                                height: 70.h,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        Text(
                                          "B코스",
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            bState,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                        width: 2.5,
                                        color: const Color.fromRGBO(
                                            255, 178, 79, 1),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                BusDialog(
                                                  busStopLocation:
                                                      bBusStopLocation,
                                                  timeLine: bBusTimeLine,
                                                  busType: 'B코스',
                                                ));
                                      },
                                      child: Text(
                                        "B코스 시간표",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2.5,
                                    color:
                                        const Color.fromARGB(255, 255, 174, 68),
                                  ),
                                ),
                                width: 160.w,
                                height: 180.h,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        for (var i = 0; i <= 11; i++)
                                          BusNowLocationShow(
                                              busStopName: bBusStopLocation[i],
                                              stopBool: bNowLocationBool[
                                                      bBusStopLocation[i]] ??=
                                                  false),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
