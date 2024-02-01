import 'dart:convert';

import 'package:clean_architecture_tdd_weather/data/models/weather_model.dart';
import 'package:clean_architecture_tdd_weather/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/json_reader.dart';


void main() {

  const testWeatherModel = WeatherModel(
    cityName: 'Cairo',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 284.57,
    pressure: 1021,
    humidity: 62,
  );

  test(
    'should be a subclass of weather entity',
    () async {

      //assert
      expect(testWeatherModel, isA < WeatherEntity > ());
    }
  );


  test(
    'should return a valid model from json',
    () async {

      //arrange
      final Map < String, dynamic > jsonMap = json.decode(
        readJson('helpers/dummy_data/dummy_weather_response.json'),
      );

      //act
      final result = WeatherModel.fromJson(jsonMap);

      //assert
      expect(result, equals(testWeatherModel));

    }
  );


  test(
    'should return a json map containing proper data',
    () async {

      // act
      final result = testWeatherModel.toJson();

      // assert
      final expectedJsonMap = {
        'weather': [{
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01n',
        }],
        'main': {
          'temp': 284.57,
          'pressure': 1021,
          'humidity': 62,
        },
        'name': 'Cairo',
      };

      expect(result, equals(expectedJsonMap));

    },
  );

}