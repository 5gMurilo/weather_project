import 'package:flutter_wheater/src/controller/client/my_http_client.dart';
import 'package:flutter_wheater/src/model/wheater_model.dart';
import 'location_provider.dart';

const _apiKey = 'ayum0pDSRW2cpJMcpfL11FBgT1EWZAgE';

class CurrentWeatherService {
  final MyHttpClient client;

  CurrentWeatherService({required this.client});

  Future<Weather> getCurrentForecast() async {
    final location = await LocationProvider().getLocation();
    final urlLocation =
        'http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=$_apiKey&q=${location.elementAt(0)},${location.elementAt(1)}&language=pt-br';

    final locationResponse = await client.get(urlLocation);

    final weatherUrl =
        'http://dataservice.accuweather.com/currentconditions/v1/${locationResponse["Key"]}?apikey=$_apiKey';

    final weatherResponse = await client.get(weatherUrl) ;

    return Weather(
      cityName: locationResponse['LocalizedName'],
      parentCity: locationResponse['AdministrativeArea']['LocalizedName'],
      minTemp: 0,
      maxTemp: 0,
      date: DateTime.now(),
      phrase: weatherResponse.elementAt(0)['WeatherText'],
      hasPrecipitation: weatherResponse.elementAt(0)['HasPrecipitation'],
      precipitationType: weatherResponse.elementAt(0)['PrecipitationType'],
      precipitationIntensity: null,
      currentForecast: weatherResponse.elementAt(0)['Temperature']['Metric']['Value'],
    );
  }
}
