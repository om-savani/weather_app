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
  @override
  void initState() {
    super.initState();
    // Fetch the weather data for a specific city (e.g., "London")
    context
        .read<DataProvider>()
        .WeatherData(context.read<DataProvider>().cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.searchPage);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<DataProvider>(builder: (context, value, child) {
          return Column(
            children: [
              Text(
                "Weather in ${value.cityName}",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (value.weatherList.isEmpty)
                const CircularProgressIndicator()
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: value.weatherList.length,
                    itemBuilder: (context, index) {
                      final weather = value.weatherList[index];
                      return ListTile(
                        leading: Image.network(
                          "http://openweathermap.org/img/wn/${weather.main}@2x.png",
                          width: 40,
                          height: 40,
                        ),
                        title: Text(
                          "${weather.main} - ${weather.description}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Temperature: ${weather.description}°C",
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
