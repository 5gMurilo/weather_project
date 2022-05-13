import 'package:flutter/cupertino.dart';
import 'package:flutter_wheater/src/controller/services/current_weather_service.dart';
import 'package:flutter_wheater/src/controller/services/five_days_forecast_service.dart';
import 'package:flutter_wheater/src/controller/services/weather_service.dart';
import 'package:flutter_wheater/src/model/wheater_model.dart';

class HomeController extends ChangeNotifier {

  var forecasts = <Weather>[];
  Future<Weather> fetchCurrentWeather(CurrentWeatherService _service) async {
    var weather = await _service.getCurrentForecast();
    notifyListeners();
    return weather;
  }

  Future<Weather> fetchOneDayWeather(WeatherService _oneDayService) async {
    var weather = await _oneDayService.getWeather();
    notifyListeners();
    return weather;
  }

  Future<void> fetchFiveDaysWeather (FiveDaysForecastService _fiveDaysService) async {
    forecasts = await _fiveDaysService.fiveDaysForecast();
    notifyListeners();
  }
}
