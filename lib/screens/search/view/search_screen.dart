import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../home/provider/data_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<DataProvider>();
    final watch = context.watch<DataProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("Search"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SearchBar(
            leading: const Icon(Icons.search),
            hintText: 'Search City',
            onSubmitted: (value) {
              read.changeCity(value);
              read.WeatherData(value);
            },
          ),
        ),
      ),
      body: watch.weatherModel == null || watch.weatherModel!.cod == "404"
          ? const Center(child: Text("City Not Found"))
          : Column(
              children: [
                ListTile(
                  title: Text("${watch.weatherModel!.name}"),
                  subtitle: Text(
                      "${(watch.weatherModel!.mainModels!.temp! - 273.15).toStringAsFixed(1)}°C"),
                  trailing: IconButton(
                    icon: const Icon(Icons.bookmark_add_outlined),
                    onPressed: () async {
                      await read.bookmarkCity(watch.weatherModel!.name!);
                      read.saveCity(watch.cityName);
                      print("Bookmarked City: ${watch.bookmarkedCity}");
                      watch.changeBgImage();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
