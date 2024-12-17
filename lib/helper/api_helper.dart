import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class ApiHelper {
  Future<WeatherModel?> getWeatherData(String cityName) async {
    String link =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=daba61e8fd187b878a38deabbf3c7dbd";

    var response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      WeatherModel model = WeatherModel.mapToModel(data);
      return model;
    }
    return null;
  }
}

class SearchApiHelper {
  Future<WeatherModel?> getWeatherData(String cityName) async {
    String link =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=daba61e8fd187b878a38deabbf3c7dbd";

    var response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      WeatherModel model = WeatherModel.mapToModel(data);
      return model;
    }
    return null;
  }
}
