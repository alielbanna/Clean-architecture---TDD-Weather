import 'package:clean_architecture_tdd_weather/core/error/failure.dart';
import 'package:clean_architecture_tdd_weather/domain/entities/weather.dart';
import 'package:clean_architecture_tdd_weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUseCase {

  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository); 
  
  Future<Either<Failure,WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}