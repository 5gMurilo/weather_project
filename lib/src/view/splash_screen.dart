import 'package:flutter/material.dart';
import 'package:flutter_wheater/src/controller/client/dio_client.dart';
import 'package:flutter_wheater/src/controller/home_controller.dart';
import 'package:flutter_wheater/src/controller/services/current_weather_service.dart';
import 'package:flutter_wheater/src/controller/services/weather_service.dart';
import 'package:flutter_wheater/src/view/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = HomeController();

  _navigateToHome() async {
    var weather = await controller.fetchCurrentWeather(CurrentWeatherService(client: DioClient()));
    var oneDay = await controller.fetchOneDayWeather(WeatherService(client: DioClient()));

    await Future.delayed(Duration(milliseconds: 1500), () {});

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(weather: weather,oneDay: oneDay,),
        ));
  }

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/weatherApp.png'),
          const Text('Carregando informações'),
        ],
      ),
    );
  }
}
