import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Model {
  Widget? getWeatherIcon(int condition) {
    if (condition < 300) {
      return SvgPicture.asset(
        'assets/svg/climaconCloudLightning.svg',
        fit: BoxFit.fill,
      );
    } else if (condition < 500) {
      return SvgPicture.asset(
        'assets/svg/climaconCloudMoon.svg',
        fit: BoxFit.fill,
      );
    } else if (condition < 600) {
      return SvgPicture.asset(
        'assets/svg/climaconCloudRain.svg',
        fit: BoxFit.fill,
      );
    } else if (condition == 800) {
      return SvgPicture.asset(
        'assets/svg/climaconCloudSnowAlt.svg',
        fit: BoxFit.fill,
      );
    } else if (condition <= 804) {
      return SvgPicture.asset(
        'assets/svg/climaconCloudSun.svg',
        fit: BoxFit.fill,
      );
    }
    return null;
  }

  Widget? getAirIcon(int? grade) {
    if (grade == 1) {
      return Image.asset(
        'assets/images/fair.png',
        width: 35.w,
        height: 35.h,
      );
    } else if (grade == 2) {
      return Image.asset(
        'assets/images/fair.png',
        width: 35.w,
        height: 35.h,
      );
    } else if (grade == 3) {
      return Image.asset(
        'assets/images/moderate.png',
        width: 35.w,
        height: 35.h,
      );
    } else if (grade == 4) {
      return Image.asset(
        'assets/images/poor.png',
        width: 35.w,
        height: 35.h,
      );
    } else if (grade == 5) {
      return Image.asset(
        'assets/images/bad.png',
        width: 35.w,
        height: 35.h,
      );
    }
    return null;
  }

  Widget? airIndex(int? index) {
    if (index == 1) {
      return const Text(
        '"매우좋음"',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      );
    } else if (index == 2) {
      return const Text(
        '"좋음"',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      );
    } else if (index == 3) {
      return const Text(
        '"보통"',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      );
    } else if (index == 4) {
      return const Text(
        '"나쁨"',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      );
    } else if (index == 5) {
      return const Text(
        '"매우나쁨"',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return null;
  }
}
