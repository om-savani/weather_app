import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  static const String bookmarkedCityKey = "bookmarkedCity";

  Future<void> saveBookmarkedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(bookmarkedCityKey, city);
  }

  Future<String?> getBookmarkedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(bookmarkedCityKey);
  }

  Future<void> clearBookmarkedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(bookmarkedCityKey);
  }
}
