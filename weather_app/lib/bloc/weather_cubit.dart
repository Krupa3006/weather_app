import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/weather.dart';
import '../services/weather_repository.dart';

class WeatherState {
  final Weather? weather;
  final bool isLoading;
  final String? error;

  WeatherState({this.weather, this.isLoading = false, this.error});

  WeatherState copyWith({Weather? weather, bool? isLoading, String? error}) {
    return WeatherState(
      weather: weather ?? this.weather,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository repository;
  WeatherCubit(this.repository) : super(WeatherState());

  Future<void> getWeather(String city) async {
    emit(state.copyWith(isLoading: true));
    try {
      final weather = await repository.fetchWeather(city);
      emit(WeatherState(weather: weather));
    } catch (e) {
      emit(WeatherState(error: e.toString()));
    }
  }
}
