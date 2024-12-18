import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/preferences/shr_helper.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'package:weather_app/screens/home/provider/data_provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  DataProvider read = DataProvider();
  DataProvider watch = DataProvider();
  ShrHelper helper = ShrHelper();
  @override
  Widget build(BuildContext context) {
    read = context.read<DataProvider>();
    watch = context.watch<DataProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text("Select City"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://cdn.suwalls.com/wallpapers/abstract/blurry-circles-26566-1920x1080.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Weather App!\nPlease select a city.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter City Name',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (city) async {
                  read.saveCity(city);
                  await read.getWeatherData();
                  helper.isFirstTime();
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.initialRoute);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
