import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../weather_resource/fivedays_weather.dart';
import '../weather_resource/weather_api.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherPage> {
  List<dynamic> preWeatherData = [];
  List<dynamic> fiveWeatherData = [];

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
    fiveWeatherData = await FiveWeatherData().getFiveWeatherData();
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
            height: 465.h,
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
          )
        ],
      ),
    );
  }

  Container WeekWeather() {
    return Container(
      width: 330.w,
      height: 300.h,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(255, 178, 79, 1),
          ),
          borderRadius: BorderRadius.circular(10)),
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
          borderRadius: BorderRadius.circular(10)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
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
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  const Text("오늘 시간대"),
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
          SizedBox(
            height: 80.h,
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
                    style: GoogleFonts.lato(
                      fontSize: 19.0.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(255, 178, 79, 1),
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
                          color: const Color.fromRGBO(255, 178, 79, 1),
                        ),
                      ), //온도text
                      Text(
                        '\u00B0',
                        style: GoogleFonts.lato(
                          fontSize: 40.0.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(255, 178, 79, 1),
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
                          color: const Color.fromRGBO(255, 178, 79, 1),
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
                          color: const Color.fromRGBO(255, 178, 79, 1),
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
                          color: const Color.fromRGBO(255, 178, 79, 1),
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
