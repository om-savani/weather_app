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
    context.read<DataProvider>().WeatherData();
  }

  @override
  Widget build(BuildContext context) {
    read = context.read<DataProvider>();
    watch = context.watch<DataProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.searchPage),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: watch.weatherModel == null
          ? const Center(child: CircularProgressIndicator())
          : watch.weatherList.isEmpty
              ? const Center(child: Text("No weather data available"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${watch.weatherModel!.Name}, ${watch.weatherModel!.sys?.country}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      10.h,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${(watch.weatherModel!.mainModels!.temp! - 273.15).toStringAsFixed(1)}°C",
                            style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      10.h,
                      Text(
                        watch.weatherList.first.description ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      10.h,
                      Expanded(
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Feels Like:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${(watch.weatherModel!.mainModels!.feelsLike! - 273.15).toStringAsFixed(1)}°C",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Min Temp:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${(watch.weatherModel!.mainModels!.tempMin! - 273.15).toStringAsFixed(1)}°C",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Max Temp:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${(watch.weatherModel!.mainModels!.tempMax! - 273.15).toStringAsFixed(1)}°C",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Humidity:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${watch.weatherModel!.mainModels!.huminity}%",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Pressure:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${watch.weatherModel!.mainModels!.pressure} hPa",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Visibility:",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${(watch.weatherModel!.visibility ?? 0) / 1000} km",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
