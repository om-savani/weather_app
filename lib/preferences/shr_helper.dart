import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  static const String bookmarkedCity = "bookmarkedCity";

  Future<void> saveBookmarkedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(bookmarkedCity, city);
  }

  Future<String?> getBookmarkedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(bookmarkedCity);
  }

  Future<void> clearBookmarkedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(bookmarkedCity);
  }

  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime') ?? true;
  }
}
