import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bus_resource/bus_info.dart';
import '../resources/time_resources.dart';
import '../weather_resource/weather_api.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> nowTimeInfo = NowTime().timeCutting();
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
  List<String> titles = [];
  List<String> result = [];
  List<List> collegeFoodMenu = [];
  List<String> daytime = [];
  List<String> daylist = ["로딩중", "로딩중", "로딩중", "로딩중", "로딩중"];
  List<int> lunchMenuNumber = [0, 0, 0, 0, 0];
  List<int> dinnerMenuNumber = [0, 0, 0, 0, 0];
  List<bool> todayMenuBool = [false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), forTimeInfoUpdate);
    getUserOrder();
    getFoodData();
  }

  // void updateUI() {
  //   setState(() {
  //     print("이게 맞는 걸까");
  //   });
  // }

  bool isAllFalse(List<bool> list) {
    for (var element in list) {
      if (element != false) {
        return false;
      }
    }
    return true;
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

  Future getFoodData() async {
    final url = Uri.parse('https://www.jejunu.ac.kr/camp/stud/foodmenu');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    var titles = html
        .querySelectorAll('td.border_right.border_bottom.txt_center > p')
        .map((element) => element.innerHtml.trim())
        .toList();

    List<String> result = titles.toList();

    for (int i = 0; i < result.length; i++) {
      collegeFoodMenu.add(result[i].split("<br>"));
    }

    int daysNum = 0;
    for (int i = 0; i < collegeFoodMenu.length; i++) {
      if (collegeFoodMenu[i][0] != "없음") {
        lunchMenuNumber[daysNum] = i;
        dinnerMenuNumber[daysNum] = i + 1;
        i += 1;
        daysNum += 1;
      }
    }

    var daytime = html
        .querySelectorAll('table > tbody > tr > td:nth-child(1)')
        .map((element) => element.innerHtml.trim())
        .toList();

    List<int> foodDayList = [0, 4, 8, 12, 16];
    for (int i = 0; i <= 4; i++) {
      daylist[i] = (daytime[foodDayList[i]].split("<br>")[0]);
    }

    String todayInfo = "${nowTimeInfo[3]}/${nowTimeInfo[4]}";
    // String todayInfo = "05/02";

    for (int i = 0; i <= 4; i++) {
      if (daylist[i] == todayInfo) todayMenuBool[i] = true;
    }

    setState(
      () {
        this.titles = titles;
        result = result;
        collegeFoodMenu = collegeFoodMenu;
        todayMenuBool = todayMenuBool;
      },
    );
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Text(
                          "귤 생 이 들",
                          style: GoogleFonts.lato(
                              fontSize: 40.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              "제주대 관련 정보",
                              style: GoogleFonts.lato(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            // IconButton(
                            //   onPressed: () {
                            //     return updateUI();
                            //   },
                            //   icon: const Icon(
                            //     Icons.restore,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  height: 390.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 90.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 3,
                                    color:
                                        const Color.fromARGB(255, 255, 174, 68),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${nowTimeInfo[3]}월 ${nowTimeInfo[4]}일",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "${nowTimeInfo[0]}:${nowTimeInfo[1]}:${nowTimeInfo[2]}",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 90.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 3,
                                    color:
                                        const Color.fromARGB(255, 255, 174, 68),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "A코스",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          aState,
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 90.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 3,
                                    color:
                                        const Color.fromARGB(255, 255, 174, 68),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "B코스",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
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
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 240.h,
                                  width: 165.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      width: 3,
                                      color:
                                          const Color.fromRGBO(255, 178, 79, 1),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      if (isAllFalse(todayMenuBool))
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Icon(
                                            Icons
                                                .sentiment_satisfied_alt_outlined,
                                            size: 100.w,
                                          ),
                                        )
                                      else
                                        for (var i = 0; i <= 4; i++)
                                          if (todayMenuBool[i])
                                            SizedBox(
                                              height: 230.h,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      "${daylist[i]} 백두관 점심",
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    for (var name1
                                                        in collegeFoodMenu[
                                                            lunchMenuNumber[i]])
                                                      Text(
                                                        name1.replaceAll(
                                                            'amp;', ''),
                                                        style: TextStyle(
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    ],
                                  )),
                              Container(
                                height: 240.h,
                                width: 165.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 3,
                                    color:
                                        const Color.fromRGBO(255, 178, 79, 1),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "현재 날씨",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          preWeatherData.isEmpty
                                              ? "로딩"
                                              : preWeatherData[0],
                                          style: TextStyle(
                                            fontSize: 60.sp,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ), //온도text
                                        Text(
                                          '\u00B0',
                                          style: TextStyle(
                                            fontSize: 60.sp,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          preWeatherData.isEmpty
                                              ? "로딩"
                                              : preWeatherData[1],
                                          style: TextStyle(
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '대기질 지수',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          preWeatherData.isEmpty
                                              ? "로딩"
                                              : preWeatherData[2],
                                          style: TextStyle(
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
