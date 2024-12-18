import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../home/provider/data_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late DataProvider read;
  late DataProvider watch;
  late String cityName;
  @override
  Widget build(BuildContext context) {
    read = context.read<DataProvider>();
    watch = context.watch<DataProvider>();

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
              cityName = value;
              read.getSearchData(value);
            },
          ),
        ),
      ),
      body: watch.searchWeatherModel == null ||
              watch.searchWeatherModel!.cod == "404"
          ? const Center(child: Text("City Not Found"))
          : Column(
              children: [
                ListTile(
                  title: Text("${watch.searchWeatherModel!.name}"),
                  subtitle: Text(
                      "${(watch.searchWeatherModel?.mainModels?.temp ?? 0 - 273.15).toStringAsFixed(1)}°C"),
                  trailing: IconButton(
                    icon: const Icon(Icons.bookmark_add_outlined),
                    onPressed: () async {
                      read.saveCity(cityName);
                      read.getWeatherData();
                      read.changeBgImage();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
