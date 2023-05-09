import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../weather_resource/data/network.dart';
import '../weather_resource/weather_api.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherPage> {
  List<dynamic> preWeatherData = [];
  List<dynamic> fiveWeatherData = [];
  String? temp5;
  String? weatherIcon5;
  String? dtTxt5;
  List<String> listTemp5 = ["", "", "", "", "", "", "", "", "", ""];
  List<String> listweatherIcon5 = ["", "", "", "", "", "", "", "", "", ""];
  List<String> listdtTxt5 = ["", "", "", "", "", "", "", "", "", ""];
  List<String> weekListTemp5 = ["", "", "", "", ""];
  List<String> weekListweatherIcon5 = ["", "", "", "", ""];
  List<String> weekListdtTxt5 = ["", "", "", "", ""];

  @override
  void initState() {
    super.initState();
    getUserOrder();
    getFiveWeather();
  }

  Future<void> getUserOrder() async {
    preWeatherData = await WeatherData().getPreWeatherData();
    setState(() {});
  }

  Future<void> getFiveWeather() async {
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/forecast?lat=33.45604335551202&lon=126.56181488432678&appid=c663574adf4b2a0bb08b4f39cc021292&units=metric',
        '');

    var fiveweatherData = await network.getJsonData();

    for (int i = 0; i <= 9; i++) {
      temp5 = fiveweatherData['list'][i + 3]['main']['temp']
          .toDouble()
          .toInt()
          .toString();
      weatherIcon5 =
          fiveweatherData['list'][i + 3]['weather'][0]['icon'].toString();
      dtTxt5 = fiveweatherData['list'][i + 3]['dt_txt'];
      listTemp5[i] = temp5!;
      listweatherIcon5[i] = weatherIcon5!;
      listdtTxt5[i] = dtTxt5!;
    }

    for (int i = 0; i < 5; i++) {
      temp5 = fiveweatherData['list'][i * 8]['main']['temp']
          .toDouble()
          .toInt()
          .toString();
      weatherIcon5 =
          fiveweatherData['list'][i * 8]['weather'][0]['icon'].toString();
      dtTxt5 = fiveweatherData['list'][i * 8]['dt_txt'];
      weekListTemp5[i] = temp5!;
      weekListweatherIcon5[i] = weatherIcon5!;
      weekListdtTxt5[i] = dtTxt5!;
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
              'assets/images/page.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            WeatherContaninerColumn(),
          ],
        ),
      ),
    );
  }

  Container WeatherContaninerColumn() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                '날씨',
                style: GoogleFonts.lato(
                    fontSize: 40.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 80.h,
          ),
          const SizedBox(),
          SizedBox(
            height: 370.h,
            width: 400.w,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  NowWeather(),
                  SizedBox(
                    height: 20.h,
                  ),
                  HourlyWeather(),
                  SizedBox(
                    height: 10.h,
                  ),
                  WeekWeather(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
        ],
      ),
    );
  }

  Container WeekWeather() {
    return Container(
      width: 330.w,
      height: 200.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(255, 178, 79, 1),
        ),
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(255, 178, 79, 0.8),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(1),
        itemCount: 5,
        itemBuilder: (context, int i) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 100.w,
              height: 50.h,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(255, 178, 79, 1),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (weekListdtTxt5[0] == "")
                    const Text("날짜 로딩중")
                  else
                    Text(
                      weekListdtTxt5[i].substring(0, 10),
                      style: GoogleFonts.lato(
                        fontSize: 17.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (weekListweatherIcon5[0] == "")
                        const Text("이미지 로딩중")
                      else
                        SizedBox(
                          width: 50.w,
                          height: 40.h,
                          child: Image.network(
                              'https://openweathermap.org/img/wn/${weekListweatherIcon5[i]}@2x.png',
                              fit: BoxFit.scaleDown),
                        )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        weekListTemp5[i],
                        style: GoogleFonts.lato(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\u00B0',
                        style: GoogleFonts.lato(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container HourlyWeather() {
    return Container(
      width: 330.w,
      height: 100.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(255, 178, 79, 1),
        ),
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(255, 178, 79, 0.8),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, int i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 100.w,
              height: 90.h,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(255, 178, 79, 1),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    listdtTxt5[i]
                        .replaceAll('2023-', '')
                        .replaceAll("-", "/")
                        .replaceAll(":00:00", "시"),
                    style: GoogleFonts.lato(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        listTemp5[i],
                        style: GoogleFonts.lato(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\u00B0',
                        style: GoogleFonts.lato(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      if (listweatherIcon5[0] == "")
                        const Text("이미지 로딩중")
                      else
                        SizedBox(
                          width: 35.w,
                          height: 30.h,
                          child: Image.network(
                              'https://openweathermap.org/img/wn/${listweatherIcon5[i]}@2x.png',
                              fit: BoxFit.scaleDown),
                        )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container NowWeather() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 40.w,
              ),
              Column(
                children: [
                  Text(
                    "현재 제주대 날씨",
                    style: GoogleFonts.lato(
                      fontSize: 19.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        preWeatherData.isEmpty ? "로딩중입니다" : preWeatherData[0],
                        style: GoogleFonts.lato(
                          fontSize: 40.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ), //온도text
                      Text(
                        '\u00B0',
                        style: GoogleFonts.lato(
                          fontSize: 40.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        preWeatherData.isEmpty ? "로딩중입니다" : preWeatherData[1],
                        style: GoogleFonts.lato(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        preWeatherData.isEmpty ? "로딩중입니다" : preWeatherData[2],
                        style: GoogleFonts.lato(
                          fontSize: 35.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  if (preWeatherData.isEmpty)
                    const Text("이미지 로딩중")
                  else
                    Image.network(
                        'https://openweathermap.org/img/wn/${preWeatherData[3]}@2x.png')
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
