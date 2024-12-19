import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/extentions/sizedbox_extention.dart';
import '../../home/provider/data_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late DataProvider read;
  late DataProvider watch;
  String cityName = "";

  @override
  void initState() {
    super.initState();
    context.read<DataProvider>().getSearchData(cityName);
  }

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
        title: const Text("Search City"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search City',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(12.0),
              ),
              onSubmitted: (value) {
                cityName = value;
                read.getSearchData(value);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: watch.searchWeatherModel == null ||
                watch.searchWeatherModel!.cod == "404"
            ? Center(
                child: Text(
                  watch.searchWeatherModel == null
                      ? "Search for a city"
                      : "City Not Found",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              )
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                watch.searchWeatherModel!.name ?? "Not Found",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              8.h,
                              Text(
                                "${(watch.searchWeatherModel?.mainModels?.temp ?? 0 - 273.15).toStringAsFixed(1)}°C",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.bookmark_add_outlined,
                                size: 30),
                            onPressed: () async {
                              read.saveCity(cityName);
                              read.getWeatherData();
                              read.changeBgImage();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
