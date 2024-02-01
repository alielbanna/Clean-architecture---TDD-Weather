import 'package:clean_architecture_tdd_weather/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture_tdd_weather/data/repositories/weather_repository_impl.dart';
import 'package:clean_architecture_tdd_weather/domain/repositories/weather_repository.dart';
import 'package:clean_architecture_tdd_weather/domain/usecases/get_current_weather.dart';
import 'package:clean_architecture_tdd_weather/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final instance = GetIt.instance;

void setupInstance() {
  // bloc
  instance.registerFactory(() => WeatherBloc(instance()));

  // usecase
  instance.registerLazySingleton(() => GetCurrentWeatherUseCase(instance()));

  // repository
  instance.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: instance()),
  );

  // data source
  instance.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: instance(),
    ),
  );

  // external
  instance.registerLazySingleton(() => http.Client());
}
