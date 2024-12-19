import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'package:weather_app/utils/extentions/sizedbox_extention.dart';

import '../provider/data_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataProvider read = DataProvider();
  DataProvider watch = DataProvider();

  @override
  void initState() {
    super.initState();
    context.read<DataProvider>().getWeatherData();
    context.read<DataProvider>().changeBgImage();
  }

  @override
  Widget build(BuildContext context) {
    read = context.read<DataProvider>();
    watch = context.watch<DataProvider>();

    if (watch.weatherModel == null && watch.getWeatherList.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Weather App"),
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.searchPage),
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.searchPage),
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              watch.weatherImage ?? "lib/assets/images/default.webp",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    watch.weatherModel?.name ?? "Unknown Location",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  5.h,
                  const Icon(Icons.cloud, size: 50, color: Colors.white),
                  5.h,
                  Text(
                    watch.getWeatherList.firstOrNull?.description ??
                        "Cloudy Weather",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  20.h,
                  Text(
                    "${(watch.weatherModel?.mainModels?.temp ?? 0 - 273.15).toStringAsFixed(0)}°",
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "High ${(watch.weatherModel?.mainModels?.tempMax ?? 0 - 273.15).toStringAsFixed(0)}°",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Low ${(watch.weatherModel?.mainModels?.tempMin ?? 0 - 273.15).toStringAsFixed(0)}°",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
