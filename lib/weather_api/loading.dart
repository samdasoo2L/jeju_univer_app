import 'package:flutter/material.dart';

import 'data/network.dart';
import 'model/model.dart';

const apiKey = 'c663574adf4b2a0bb08b4f39cc021292';

class WeatherData {
  Model model = Model();
  String? cityName;
  String? temp;
  String? des;
  Widget? icon;
  Widget? pollution;
  Widget? quality;
  String? air;
  String? air2;
  var date = DateTime.now();

  Future<List<dynamic>> getLocation1() async {
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=33.45604335551202&lon=126.56181488432678&appid=c663574adf4b2a0bb08b4f39cc021292&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=3.45604335551202&lon=126.56181488432678&appid=c663574adf4b2a0bb08b4f39cc021292');

    var weatherData = await network.getJsonData();
    var airData = await network.getAirData();

    temp = weatherData['main']['temp'].toDouble().toInt().toString();
    cityName = weatherData['name'].toString();
    var condition = weatherData['weather'][0]['id'];
    var grade = airData['list'][0]['main']['aqi'];
    var index = airData['list'][0]['main']['aqi'];
    des = weatherData['weather'][0]['description'].toString();
    icon = model.getWeatherIcon(condition);
    pollution = model.getAirIcon(grade);
    quality = model.airIndex(index);
    air = airData['list'][0]['components']['pm2_5'].toInt().toString();
    air2 = airData['list'][0]['components']['pm10'].toInt().toString();

    return [
      temp,
      cityName,
      condition,
      grade,
      index,
      des,
      icon,
      pollution,
      quality,
      air,
      air2
    ];
  }
}

//  void updateData() {

  //   var weatherData = preWeatherData[0];
  //   var airData = preWeatherData[1];

  //   double temp2 = weatherData['main']['temp'].toDouble();
  //   temp = temp2.toInt();
  //   cityName = weatherData['name'];
  //   var condition = weatherData['weather'][0]['id'];
  //   var grade = airData['list'][0]['main']['aqi'];
  //   var index = airData['list'][0]['main']['aqi'];
  //   des = weatherData['weather'][0]['description'];
  //   icon = model.getWeatherIcon(condition);
  //   pollution = model.getAirIcon(grade);
  //   quality = model.airIndex(index);
  //   air = airData['list'][0]['components']['pm2_5'];
  //   air2 = airData['list'][0]['components']['pm10'];
  // }