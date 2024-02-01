import 'package:clean_architecture_tdd_weather/core/di.dart';
import 'package:clean_architecture_tdd_weather/presentation/bloc/weather_bloc.dart';
import 'package:clean_architecture_tdd_weather/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => instance<WeatherBloc>(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeatherPage(),
      ),
    );
  }
}
