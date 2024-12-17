import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'package:weather_app/screens/home/view/home_screen.dart';
import 'package:weather_app/screens/home/provider/data_provider.dart';
import 'package:weather_app/screens/intro/view/intro_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        // home: FutureBuilder(
        //   future: context
        //       .read<DataProvider>()
        //       .checkFirstTime(), // Check if it's the first time
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //
        //     if (snapshot.data == true) {
        //       return const FirstScreen(); // Show first screen if no city is selected
        //     } else {
        //       return const HomeScreen(); // Show home screen if a city is selected
        //     }
        //   },
        // ),
      ),
    );
  }
}
