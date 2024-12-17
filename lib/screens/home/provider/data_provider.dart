import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/preferences/shr_helper.dart'; // Import ShrHelper
import '../../../helper/api_helper.dart';
import '../../../model/weather_model.dart';

class DataProvider with ChangeNotifier {
  List<WeatherListModel> weatherList = [];
  String cityName = "Surat";
  WeatherModel? weatherModel = WeatherModel();
  String? bookmarkedCity;
  ShrHelper helper = ShrHelper(); // ShrHelper instance for SharedPreferences

  DataProvider() {
    loadBookmarkedCity(); // Load bookmarked city when the provider is created
  }

  // Check if it's the first time the user opens the app
  Future<bool> checkFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedCity') ==
        null; // No city saved means it's the first time
  }

  // Save the selected city
  Future<void> saveCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCity', city);
    cityName = city;
    notifyListeners();
  }

  // Fetch weather data for the current city
  Future<void> WeatherData() async {
    ApiHelper apiHelper = ApiHelper();
    weatherModel = await apiHelper.getWeatherData(cityName);

    if (weatherModel != null && weatherModel!.cod == "200") {
      weatherList =
          weatherModel!.weathers!; // Update the weatherList if data is valid
    } else {
      weatherList = []; // If no valid data, reset the list
    }
    notifyListeners();
  }

  // Change the city for weather data
  void changeCity(String city) {
    cityName = city;
    notifyListeners(); // Notify listeners about the change
  }

  // Bookmark the city and store it in SharedPreferences
  Future<void> bookmarkCity(String city) async {
    cityName = city;
    bookmarkedCity = city;
    await helper.saveBookmarkedCity(city); // Save the city using ShrHelper
    notifyListeners(); // Notify listeners that the city has been bookmarked
  }

  // Load the bookmarked city from SharedPreferences
  Future<void> loadBookmarkedCity() async {
    bookmarkedCity = await helper
        .getBookmarkedCity(); // Get the bookmarked city from ShrHelper
    if (bookmarkedCity != null) {
      cityName =
          bookmarkedCity!; // Set the cityName to the bookmarked city if available
    }
    await WeatherData(); // Fetch weather data for the bookmarked city
  }

  // Get the appropriate weather icon based on the weather description
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
