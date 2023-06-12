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
  List<List> dinnerbiglist = [[], [], [], [], []];
  List<List> lunchbiglist = [[], [], [], [], []];
  List<String> daybiglist = ["", "", "", "", ""];
  List<bool> todayMenuBool = [false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), forTimeInfoUpdate);
    getUserOrder();
    getFoodData();
  }

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
    final url = Uri.parse('https://www.jejunu.ac.kr/camp/stud/foodmenu.htm');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    var titles = html
        .querySelectorAll('body > script')
        .map((element) => element.innerHtml.trim())
        .toList();

    var dinnerlist = titles[8].split("dinner\":\"");

    for (int i = 0; i < 5; i++) {
      String beforedinnerbiglist = (dinnerlist[i + 1].split("\",\""))[0];
      dinnerbiglist[i] = beforedinnerbiglist.split("\\r\\n");
    }

    var lunchlist = titles[8].split("lunch\":\"");

    for (int i = 0; i < 5; i++) {
      String beforelunchbiglist = (lunchlist[i + 1].split("\",\""))[0];
      lunchbiglist[i] = beforelunchbiglist.split("\\r\\n");
    }

    var daylist = titles[8].split("date\":\"");

    for (int i = 0; i < 5; i++) {
      daybiglist[i] = (daylist[i + 1].split("\",\""))[0];
    }
    for (int i = 0; i < 5; i++) {
      var compareDay = (daybiglist[i].split("-"))[2];
      if (compareDay == nowTimeInfo[4]) {
        todayMenuBool[i] = true;
      }
    }

    setState(() {});
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
                        Row(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              height: 55.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Image.asset('assets/images/app_icon.png',
                                  fit: BoxFit.contain),
                            ),
                            Text(
                              " 귤 생 이 들 ",
                              style: GoogleFonts.lato(
                                  fontSize: 40.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Container(
                              clipBehavior: Clip.hardEdge,
                              height: 55.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Image.asset('assets/images/app_icon.png',
                                  fit: BoxFit.contain),
                            ),
                          ],
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
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    255, 117, 79, 1),
                                                width: 1.1),
                                          ),
                                        ),
                                        child: Text(
                                          "A코스",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
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
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    79, 146, 255, 1),
                                                width: 1.1),
                                          ),
                                        ),
                                        child: Text(
                                          "B코스",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
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
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    178,
                                                                    79,
                                                                    1),
                                                            width: 1.2),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "${daybiglist[i].substring(5)} 백두관 점심",
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3.h,
                                                  ),
                                                  Text(
                                                    "11:00 ~ 14:00",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  for (var name1
                                                      in lunchbiglist[i])
                                                    Text(
                                                      name1,
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
                                ),
                              ),
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
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromRGBO(
                                                  255, 178, 79, 1),
                                              width: 1.2),
                                        ),
                                      ),
                                      child: Text(
                                        "현재 날씨",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
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
                                            fontSize: 50.sp,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ), //온도text
                                        Text(
                                          '\u00B0',
                                          style: TextStyle(
                                            fontSize: 50.sp,
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
                                            fontSize: 20.sp,
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
                                        Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Color.fromRGBO(
                                                      255, 178, 79, 1),
                                                  width: 1.2),
                                            ),
                                          ),
                                          child: Text(
                                            '대기질 지수',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
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
                                            fontSize: 20.sp,
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
