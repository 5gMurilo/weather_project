import 'package:flutter_wheater/src/controller/client/my_http_client.dart';
import 'package:flutter_wheater/src/model/fahrenheit_to_celsius.dart';
import 'package:flutter_wheater/src/model/wheater_model.dart';

import 'location_provider.dart';

const _apiKey = 'ayum0pDSRW2cpJMcpfL11FBgT1EWZAgE';

class FiveDaysForecastService {

  final MyHttpClient client;

  FiveDaysForecastService({required this.client});

  Future<List<Weather>> fiveDaysForecast() async {
    List<Weather> fiveDays = [];

    final location = await LocationProvider().getLocation();
    final urlLocation =
        'http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=$_apiKey&q=${location
        .elementAt(0)},${location.elementAt(1)}&language=pt-br';

    final locationResponse = await client.get(urlLocation);
    final requestUrl = 'http://dataservice.accuweather.com/forecasts/v1/daily/5day/${locationResponse["Key"]}?apikey=$_apiKey';

    var response = await client.get(requestUrl);

    var forecasts = response['DailyForecasts'];

    for (var i = 0; i < forecasts.length; i++) {
      fiveDays.add(Weather(cityName: locationResponse['LocalizedName'],
          parentCity: locationResponse['AdministrativeArea']['LocalizedName'],
          minTemp: FahrenheitToCelsius().convertion(
              response['DailyForecasts'].elementAt(
                  i)['Temperature']['Minimum']['Value']),
          maxTemp: FahrenheitToCelsius().convertion(
              response['DailyForecasts'].elementAt(
                  i)['Temperature']['Maximum']['Value']),
          currentForecast: null,
          date: DateTime.parse(response['DailyForecasts'].elementAt(i)['Date']),
          phrase: response['DailyForecasts'].elementAt(i)['Day']['IconPhrase'],
          hasPrecipitation: response['DailyForecasts'].elementAt(
              i)['Day']['HasPrecipitation'],
          precipitationType: response['DailyForecasts'].elementAt(
              i)['Day']['HasPrecipitation'] ? response['DailyForecasts']
              .elementAt(i)['Day']['PrecipitationType'] : null,
          precipitationIntensity: response['DailyForecasts'].elementAt(
              i)['Day']['HasPrecipitation'] ? response['DailyForecasts']
              .elementAt(i)['Day']['PrecipitationIntensity'] : null));
    }

    print(fiveDays.length);

    return fiveDays;
  }
}