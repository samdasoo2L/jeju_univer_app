import 'data/network.dart';
import 'model/model.dart';

class FiveWeatherData {
  Model model = Model();
  String? temp5;
  String? des5;
  String? weatherIcon5;
  String? dtTxt;

  Future<List<dynamic>> getFiveWeatherData() async {
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/forecast?lat=33.45604335551202&lon=126.56181488432678&appid=c663574adf4b2a0bb08b4f39cc021292&units=metric',
        '');

    var fiveweatherData = await network.getJsonData();
    //print(fiveweatherData['list']);

    temp5 = fiveweatherData['list'][0]['main']['temp']
        .toDouble()
        .toInt()
        .toString();
    des5 = fiveweatherData['list'][0]['weather'][0]['description'].toString();
    weatherIcon5 = fiveweatherData['list'][0]['weather'][0]['icon'].toString();
    dtTxt = fiveweatherData['list'][0]['dt_txt'];
    // print(temp5);
    // print(des5);
    // print(weatherIcon5);
    // print(dtTxt);

    return [
      temp5,
      des5,
      weatherIcon5,
    ];
  }
}
