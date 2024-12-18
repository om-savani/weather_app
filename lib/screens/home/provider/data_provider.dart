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
        return "https://amindi.ge/media/uploads/2023/12-12/20592275-web1-langley-weather-sun-clear-sky-skies-1702376614.jpg";
      case "clouds":
        return "https://static.mk.ru/upload/entities/2022/05/06/08/articles/facebookPicture/21/74/b8/44/af2c5c49cf63773758bd62c4749365cd.jpg";
      case "rain":
        return "https://astanatv.kz/cache/imagine/1200/uploads/article/2024/4/13/1712980351304.jpeg";
      case "snow":
        return "https://img.tsargrad.tv/cache/c/9/20161220_gaf_rk34_066.jpg/w1056h594fill.jpg";
      case "thunderstorm":
        return "https://cdn.futura-sciences.com/buildsv6/images/wide1920/9/2/6/9263c8d2b0_50154694_eclair-puissant-mer.jpg";
      case "drizzle":
        return "https://stihi.ru/pics/2019/06/11/1189.jpg";
      case "fog":
      case "mist":
      case "haze":
        return "https://egemen.kz/media/2023/03/29/1649128256_50-vsegda-pomnim-com-p-priroda-tuman-foto-62.jpg";
      default:
        return "https://thumbs.dreamstime.com/b/tree-alone-green-meadow-sunset-110209913.jpg";
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
