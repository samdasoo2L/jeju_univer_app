import 'data/network.dart';

class WeatherData {
  String? temp;
  String? des;
  String? weatherNameKor;
  String? pollutionkor;
  String? weatherIcon;
  String? weatherIconPng;

  Future<List<dynamic>> getPreWeatherData() async {
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=33.45604335551202&lon=126.56181488432678&appid=c663574adf4b2a0bb08b4f39cc021292&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=3.45604335551202&lon=126.56181488432678&appid=c663574adf4b2a0bb08b4f39cc021292');

    var weatherData = await network.getJsonData();
    var airData = await network.getAirData();

    temp = weatherData['main']['temp'].toDouble().toInt().toString();
    var index = airData['list'][0]['main']['aqi'];
    des = weatherData['weather'][0]['description'].toString();
    weatherIcon = weatherData['weather'][0]['icon'].toString();
    weatherIconPng = 'https://openweathermap.org/img/wn/$weatherIcon@2x.png';

    String? weatherKorean() {
      if (des == 'clear sky') {
        return "맑음";
      } else if (des == 'few clouds') {
        return "약간 구름";
      } else if (des == 'broken cloud') {
        return "구름";
      } else if (des == 'shower rain') {
        return "소나기";
      } else if (des == 'rain') {
        return "비";
      } else if (des == 'light rain') {
        return "비";
      } else if (des == 'heavy intensity rain') {
        return "강우";
      } else if (des == 'moderate rain') {
        return "비";
      } else if (des == 'thunderstorm') {
        return "뇌우";
      } else if (des == 'snow') {
        return "눈";
      } else if (des == 'mist') {
        return "안개";
      } else if (des == 'broken clouds') {
        return "흐림";
      } else if (des == 'scattered clouds') {
        return "대체로 흐림";
      } else if (des == 'overcast clouds') {
        return "흐림";
      } else if (des == 'light intensity drizzle') {
        return "실안개";
      }
      return des;
    }

    weatherNameKor = weatherKorean();

    String? pollutionKorean() {
      if (index == 1) {
        return "매우 좋음";
      } else if (index == 2) {
        return "좋음";
      } else if (index == 3) {
        return "보통";
      } else if (index == 4) {
        return "나쁨";
      } else if (index == 5) {
        return "매우나쁨";
      }
      return null;
    }

    pollutionkor = pollutionKorean();

    return [
      temp,
      weatherNameKor,
      pollutionkor,
      weatherIcon,
    ];
  }
}
