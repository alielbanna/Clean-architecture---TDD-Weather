import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_architecture_tdd_weather/domain/entities/weather.dart';
import 'package:clean_architecture_tdd_weather/presentation/bloc/weather_bloc.dart';
import 'package:clean_architecture_tdd_weather/presentation/bloc/weather_event.dart';
import 'package:clean_architecture_tdd_weather/presentation/bloc/weather_state.dart';
import 'package:clean_architecture_tdd_weather/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeather = WeatherEntity(
    cityName: 'Cairo',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 284.57,
    pressure: 1021,
    humidity: 62,
  );

  testWidgets(
    'text field should trigger state to change from empty to loading',
    (widgetTester) async {
      //arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'Cairo');
      await widgetTester.pump();
      expect(find.text('Cairo'), findsOneWidget);
    },
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      //arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

      //assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  // testWidgets(
  //   'should show widget contain weather data when state is weather loaded',
  //   (widgetTester) async {
  //     //arrange
  //     when(() => mockWeatherBloc.state)
  //         .thenReturn(const WeatherLoaded(testWeather));

  //     //act
  //     await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

  //     //assert
  //     expect(find.byKey(const Key('weather_data')), findsOneWidget);
  //   },
  // );

  testWidgets(
    'should show widget contain weather data when state is weather loaded',
    (WidgetTester widgetTester) async {
      // Arrange
      when(() => mockWeatherBloc.state)
          .thenReturn(const WeatherLoaded(testWeather));

      // Act
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

      // Assert
      await widgetTester.runAsync(() async {
        expect(find.byKey(const Key('weather_data')), findsOneWidget);
      });

      // Dispose the widget
      await widgetTester.pumpAndSettle();
    },
  );
}
