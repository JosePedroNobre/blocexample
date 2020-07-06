import 'package:blocpatternlib/bloc/weather_repository.dart';
import 'package:blocpatternlib/weather.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// events
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final String cityName;

  GetWeather({this.cityName});

  @override
  List<Object> get props => [cityName];
}

class GetDetailedWeather extends WeatherEvent {
  final String cityName;

  GetDetailedWeather({this.cityName});

  @override
  List<Object> get props => [cityName];
}

// states
abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
  @override
  List<Object> get props => [];
}

// this could have several returns types using the Either or by creating several methods with it
class WeatherLoaded extends WeatherState {
  final Weather weather;
  WeatherLoaded({this.weather});
  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError({this.message});
  @override
  List<Object> get props => [message];
}

// BLOC
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    yield WeatherLoading();
    if (event is GetWeather) {
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather: weather);
      } catch (e) {
        yield WeatherError(message: "Error");
      }
    } else if (event is GetDetailedWeather) {
      final weather =
          await weatherRepository.fetchDetailedWeather(event.cityName);
      yield WeatherLoaded(weather: weather);
    }
  }
}
