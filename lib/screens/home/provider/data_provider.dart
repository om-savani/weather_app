import 'package:flutter/material.dart';
import 'package:weather_app/preferences/shr_helper.dart';
import '../../../helper/api_helper.dart';
import '../../../model/weather_model.dart';

class DataProvider with ChangeNotifier {
  List<WeatherListModel> getWeatherList = [];
  List<WeatherListModel> searchWeatherList = [];
  String? weatherImage;
  String cityName = "Surat";
  WeatherModel? weatherModel = WeatherModel();
  WeatherModel? searchWeatherModel = WeatherModel();
  String? bookmarkedCity;
  ShrHelper helper = ShrHelper();
  bool firstTime = true;

  DataProvider() {
    initMethod();
  }

  void initMethod() {
    getCity();
  }

  Future<void> getWeatherData() async {
    getCity();
    try {
      var apiHelper = ApiHelper();
      weatherModel = await apiHelper.getWeatherData(bookmarkedCity!);

      if (weatherModel != null) {
        getWeatherList = weatherModel!.weathers ?? [];
        changeBgImage();
      } else {
        getWeatherList = [];
        weatherImage = getWeatherImage("default");
      }

      notifyListeners();
    } catch (e) {
      getWeatherList = [];
      weatherImage = getWeatherImage("default");
      notifyListeners();
    }
  }

  Future<void> getSearchData(String? city) async {
    getCity();
    try {
      var apiHelper = ApiHelper();
      searchWeatherModel = await apiHelper.getWeatherData(city!);

      if (searchWeatherModel != null) {
        searchWeatherList = searchWeatherModel!.weathers ?? [];
        changeBgImage();
      } else {
        searchWeatherList = [];
      }
      notifyListeners();
    } catch (e) {
      searchWeatherList = [];
      notifyListeners();
    }
  }

  String getWeatherImage(String? weather) {
    switch (weather?.toLowerCase()) {
      case "clear sky":
      case "clear":
      case "sun":
        return "lib/assets/images/clear_sky.jpg";
      case "clouds":
      case "overcast clouds":
      case "few clouds":
      case "scattered clouds":
      case "broken clouds":
        return "lib/assets/images/clouds.jpg";
      case "rain":
        return "lib/assets/images/rain.jpeg";
      case "snow":
        return "lib/assets/images/snow.jpg";
      case "thunderstorm":
        return "lib/assets/images/thunderstorm.jpg";
      case "drizzle":
        return "lib/assets/images/drizzle.jpg";
      case "fog":
      case "mist":
      case "haze":
      case "smoke":
        return "lib/assets/images/fog.jpg";
      default:
        return "lib/assets/images/default.webp";
    }
  }

  void saveCity(String city) {
    helper.setBookmarkedCity(city);
    cityName = city;
    notifyListeners();
  }

  Future<void> getCity() async {
    bookmarkedCity = await helper.getBookmarkedCity();
    if (bookmarkedCity != null) {
      cityName = bookmarkedCity!;
      firstTime = false;
    }
    notifyListeners();
  }

  void changeBgImage() {
    if (getWeatherList.isNotEmpty && getWeatherList.first.description != null) {
      weatherImage = getWeatherImage(getWeatherList.first.description);
    } else {
      weatherImage = getWeatherImage("default");
    }
    notifyListeners();
  }
}
