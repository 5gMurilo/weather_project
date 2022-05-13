import 'package:flutter_wheater/src/controller/services/location_provider.dart';
import 'package:flutter_wheater/src/controller/client/my_http_client.dart';
import 'package:flutter_wheater/src/model/wheater_model.dart';

const _apiKey = 'ayum0pDSRW2cpJMcpfL11FBgT1EWZAgE';

class WeatherService {
  final MyHttpClient client;

  WeatherService({
    required this.client,
  });

  Future<Weather> getWeather() async {
    final location = await LocationProvider().getLocation();
    final urlLocation =
        'http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=$_apiKey&q=${location.elementAt(0)},${location.elementAt(1)}&language=pt-br';

    final locationResponse = await client.get(urlLocation);

    var urlWeather =
        'http://dataservice.accuweather.com/forecasts/v1/daily/1day/${locationResponse["Key"]}?apikey=$_apiKey&language=pt-br';
    print(locationResponse["Key"]);
    final response = await client.get(urlWeather);

    final weather = (response as Map);

    var daily = weather['DailyForecasts'].elementAt(0);

    var min = (daily['Temperature']['Minimum']['Value'] - 32) * 0.5556;
    var max = (daily['Temperature']['Maximum']['Value'] - 32) * 0.5556;

    return Weather(
      cityName: locationResponse['LocalizedName'],
      parentCity: locationResponse['AdministrativeArea']['LocalizedName'],
      minTemp: double.parse(min.toStringAsFixed(1)),
      maxTemp: double.parse(max.toStringAsFixed(1)),
      date: DateTime.parse(daily['Date']),
      phrase: response['Headline']['Text'],
      hasPrecipitation: daily['Day']['HasPrecipitation'],
      precipitationType: daily['Day']['HasPrecipitation']
          ? daily['Day']['PrecipitationType']
          : '',
      precipitationIntensity: daily['Day']['HasPrecipitation']
          ? daily['Day']['PrecipitationIntensity']
          : '',
      currentForecast: null,
    );
  }
}
