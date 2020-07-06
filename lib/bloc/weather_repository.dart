import 'dart:math';

import 'package:blocpatternlib/weather.dart';

class WeatherRepository {
  double cachedTempCelsius;

  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();
        cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();

        return Weather(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius,
        );
      },
    );
  }

  Future<Weather> fetchDetailedWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Weather(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius,
          temperatureFarenheit: cachedTempCelsius * 1.8 + 32,
        );
      },
    );
  }
}

class NetworkError extends Error {}
