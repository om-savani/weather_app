class WeatherModel {
  int? visibility;
  String? name, cod;
  List<WeatherListModel>? weathers = [];
  sysModel? sys;
  MainModel? mainModels;

  WeatherModel(
      {this.visibility,
      this.name,
      this.weathers,
      this.sys,
      this.mainModels,
      this.cod});

  factory WeatherModel.mapToModel(Map m1) {
    List weather = m1['weather'];
    return WeatherModel(
      visibility: m1['visibility'],
      name: m1['name'],
      sys: sysModel.mapToModel(m1['sys']),
      mainModels: MainModel.mapToModel(m1['main']),
      weathers: weather
          .map(
            (e) => WeatherListModel.mapToModel(e),
          )
          .toList(),
    );
  }
}

class WeatherListModel {
  String? main, description;

  WeatherListModel({this.main, this.description});

  factory WeatherListModel.mapToModel(Map m1) {
    return WeatherListModel(
      main: m1['main'],
      description: m1['description'],
    );
  }
}

class MainModel {
  double? temp, feelsLike, tempMin, tempMax;
  int? pressure, huminity, seaLevel, grndLevel;

  MainModel(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.huminity,
      this.seaLevel,
      this.grndLevel});

  factory MainModel.mapToModel(Map m1) {
    return MainModel(
      temp: m1['temp'],
      feelsLike: m1['feels_like'],
      tempMin: m1['temp_min'],
      tempMax: m1['temp_max'],
      pressure: m1['pressure'],
      huminity: m1['humidity'],
      seaLevel: m1['sea_level'],
      grndLevel: m1['grnd_level'],
    );
  }
}

class sysModel {
  String? country;

  sysModel({this.country});

  factory sysModel.mapToModel(Map m1) {
    return sysModel(country: m1['country']);
  }
}
