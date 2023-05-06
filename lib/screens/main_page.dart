import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bus_resource/bus_info.dart';
import '../resources/time_resources.dart';
import '../weather_resource/weather_api.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
  List<dynamic> preWeatherData = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), forTimeInfoUpdate);
    getUserOrder();
  }

  Future<void> getUserOrder() async {
    preWeatherData = await WeatherData().getPreWeatherData();
    setState(() {});
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
              'assets/images/homebase.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 70.h,
                        ),
                        Text(
                          "귤 생 이 들",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.sp,
                          ),
                        ),
                        Text(
                          "제주대 관련 정보",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 110.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 40.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 178, 79, 1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 174, 68),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${nowTimeInfo[0]}:${nowTimeInfo[1]}:${nowTimeInfo[2]}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 90.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 178, 79, 1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 174, 68),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "A코스",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  aState,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 90.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 178, 79, 1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 174, 68),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              const Text(
                                "B코스",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  bState,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    Container(
                      height: 240.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(255, 178, 79, 1),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "날씨",
                            style: GoogleFonts.lato(
                              fontSize: 30.0.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(255, 178, 79, 1),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                preWeatherData.isEmpty
                                    ? "로딩"
                                    : preWeatherData[0],
                                style: GoogleFonts.lato(
                                  fontSize: 56.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromRGBO(255, 178, 79, 1),
                                ),
                              ), //온도text
                              Text(
                                '\u00B0',
                                style: GoogleFonts.lato(
                                  fontSize: 56.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromRGBO(255, 178, 79, 1),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                preWeatherData.isEmpty
                                    ? "로딩"
                                    : preWeatherData[1],
                                style: GoogleFonts.lato(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromRGBO(255, 178, 79, 1),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '대기질 지수',
                                style: GoogleFonts.lato(
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromRGBO(255, 178, 79, 1),
                                ),
                              ),
                              Text(
                                preWeatherData.isEmpty
                                    ? "로딩"
                                    : preWeatherData[2],
                                style: GoogleFonts.lato(
                                  fontSize: 25.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromRGBO(255, 178, 79, 1),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
