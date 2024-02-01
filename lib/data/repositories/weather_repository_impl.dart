import 'dart:io';

import 'package:clean_architecture_tdd_weather/core/error/exception.dart';
import 'package:clean_architecture_tdd_weather/core/error/failure.dart';
import 'package:clean_architecture_tdd_weather/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture_tdd_weather/domain/entities/weather.dart';
import 'package:clean_architecture_tdd_weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
