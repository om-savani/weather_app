import 'package:flutter/material.dart';

import '../screens/home/view/home_screen.dart';
import '../screens/intro/view/intro_screen.dart';
import '../screens/search/view/search_screen.dart';
import '../splash/view/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String initialRoute = '/home';
  static const String introPage = '/intro';
  static const String searchPage = '/search';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    initialRoute: (context) => const HomeScreen(),
    introPage: (context) => const IntroScreen(),
    searchPage: (context) => const SearchScreen(),
  };
}
