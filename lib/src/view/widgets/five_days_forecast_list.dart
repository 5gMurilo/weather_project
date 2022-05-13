import 'package:flutter/material.dart';
import 'package:flutter_wheater/src/controller/client/dio_client.dart';
import 'package:flutter_wheater/src/controller/home_controller.dart';
import 'package:flutter_wheater/src/controller/services/five_days_forecast_service.dart';
import 'package:flutter_wheater/src/view/widgets/weather_card.dart';

class FiveDaysForecastList extends StatefulWidget {
  const FiveDaysForecastList({Key? key}) : super(key: key);

  @override
  State<FiveDaysForecastList> createState() => _FiveDaysForecastListState();
}

class _FiveDaysForecastListState extends State<FiveDaysForecastList> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller
        .fetchFiveDaysWeather(FiveDaysForecastService(client: DioClient()));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, index) {
        return ListView.builder(
          itemCount: controller.forecasts.length,
          itemBuilder: (context, index) {
            var forecasts = controller.forecasts;
            return WeatherCard(weather: forecasts.elementAt(index));
          },
        );
      },
    );
  }
}
