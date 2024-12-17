import 'package:flutter/material.dart';
import 'package:weather_app/preferences/shr_helper.dart';
import '../../../helper/api_helper.dart';
import '../../../model/weather_model.dart';

class DataProvider with ChangeNotifier {
  List<WeatherListModel> weatherList = [];
  String cityName = "Surat";
  WeatherModel? weatherModel = WeatherModel();
  String? bookmarkedCity;
  ShrHelper helper = ShrHelper();

  DataProvider() {
    loadBookmarkedCity();
  }

  bool get isFirstTime {
    return bookmarkedCity == null;
    notifyListeners();
  }

  Future<void> WeatherData(String city) async {
    ApiHelper apiHelper = ApiHelper();
    weatherModel = await apiHelper.getWeatherData(cityName);

    if (weatherModel != null && weatherModel!.cod == "200") {
      weatherList = weatherModel!.weathers!;
    } else {
      weatherList = [];
    }
    notifyListeners();
  }

  void changeCity(String city) {
    cityName = city;
    notifyListeners();
  }

  Future<void> bookmarkCity(String city) async {
    cityName = city;
    bookmarkedCity = city;
    await helper.saveBookmarkedCity(city);

    await WeatherData(city);
    notifyListeners();
  }

  Future<void> loadBookmarkedCity() async {
    bookmarkedCity = await helper.getBookmarkedCity();
    if (bookmarkedCity != null) {
      cityName = bookmarkedCity!;
    }
    await WeatherData(cityName);
    notifyListeners();
  }

  String getWeatherIcon(String? weather) {
    switch (weather?.toLowerCase()) {
      case "clear":
        return "clear";
      case "clouds":
        return "clouds";
      case "rain":
        return "rain";
      case "snow":
        return "snow";
      case "thunderstorm":
        return "thunderstorm";
      case "drizzle":
        return "drizzle";
      case "fog":
      case "mist":
      case "haze":
        return "fog";
      default:
        return "unknown";
    }
  }
}
