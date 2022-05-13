import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wheater/src/controller/client/dio_client.dart';
import 'package:flutter_wheater/src/model/wheater_model.dart';
import 'package:flutter_wheater/src/view/widgets/five_days_forecast_list.dart';
import 'package:flutter_wheater/src/view/widgets/weather_card.dart';
import 'package:flutter_wheater/src/view/widgets/weather_informations.dart';

import '../controller/home_controller.dart';
import '../controller/services/five_days_forecast_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.weather,
    required this.oneDay,
  }) : super(key: key);

  final Weather weather;
  final Weather oneDay;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller
        .fetchFiveDaysWeather(FiveDaysForecastService(client: DioClient()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.zero,
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Color.fromARGB(255, 197, 240, 238),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              WeatherInformation(
                weather: widget.weather,
                max: widget.oneDay.maxTemp,
                min: widget.oneDay.minTemp,
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  'Previsão para os próximos dias',
                  style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500),
                ),
              ),
              AnimatedBuilder(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
