import 'package:flutter/material.dart';
import 'package:weather_app/preferences/shr_helper.dart';
import '../../../helper/api_helper.dart';
import '../../../model/weather_model.dart';

class DataProvider with ChangeNotifier {
  List<WeatherListModel> weatherList = [];
  List<WeatherListModel> getWeatherList = [];
  String? weatherImage;
  String cityName = "Surat";
  WeatherModel? weatherModel = WeatherModel();
  String? bookmarkedCity;
  ShrHelper helper = ShrHelper();

  DataProvider() {
    getCity();
  }

  bool get isFirstTime {
    return bookmarkedCity == null;
  }

  Future<void> WeatherData(String city) async {
    SearchApiHelper helper = SearchApiHelper();
    weatherModel = await helper.getWeatherData(city);

    if (weatherModel != null && weatherModel!.cod == "200") {
      weatherList = weatherModel!.weathers!;
    } else {
      weatherList = [];
    }
    notifyListeners();
  }

  Future<void> loadBookmarkedCity() async {
    bookmarkedCity = await helper.getBookmarkedCity();
    if (bookmarkedCity != null) {
      cityName = bookmarkedCity!;
    }
    await getWeatherData();
    notifyListeners();
  }

  Future<void> getWeatherData() async {
    try {
      var apiHelper = ApiHelper();
      weatherModel = await apiHelper.getWeatherData(bookmarkedCity ?? "Surat");

      if (weatherModel != null) {
        getWeatherList = weatherModel!.weathers ?? [];
        changeBgImage(); // Update the background image after fetching weather data
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

  String getWeatherImage(String? weather) {
    switch (weather?.toLowerCase()) {
      case "clear":
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

  void changeCity(String cityName) {
    this.cityName = cityName;
    notifyListeners();
  }

  Future<void> bookmarkCity(String city) async {
    bookmarkedCity = city;
    await helper.setBookmarkedCity(city);
    getWeatherData();
    notifyListeners();
  }

  bool isCityBookmarked() {
    return bookmarkedCity!.isNotEmpty;
  }

  Future<void> fetchBookmarkedCityWeather() async {
    if (bookmarkedCity!.isNotEmpty) {
      weatherModel = await ApiHelper().getWeatherData(bookmarkedCity!);
    }
    notifyListeners();
  }

  void saveCity(String city) {
    helper.setBookmarkedCity(city);
    notifyListeners();
  }

  Future<void> getCity() async {
    bookmarkedCity = await helper.getBookmarkedCity();
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
