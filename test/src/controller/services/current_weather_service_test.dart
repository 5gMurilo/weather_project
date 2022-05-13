import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wheater/src/controller/services/current_weather_service.dart';
import 'package:flutter_wheater/src/controller/client/my_http_client.dart';
import 'package:mocktail/mocktail.dart';


const mockResponse = r'''
[
    {
        "LocalObservationDateTime": "2022-04-23T23:35:00-03:00",
        "EpochTime": 1650767700,
        "WeatherText": "Clear",
        "WeatherIcon": 33,
        "HasPrecipitation": false,
        "PrecipitationType": null,
        "IsDayTime": false,
        "Temperature": {
            "Metric": {
                "Value": 21.1,
                "Unit": "C",
                "UnitType": 17
            },
            "Imperial": {
                "Value": 70.0,
                "Unit": "F",
                "UnitType": 18
            }
        },
        "MobileLink": "http://www.accuweather.com/en/br/guarulhos/36369/current-weather/36369?lang=en-us",
        "Link": "http://www.accuweather.com/en/br/guarulhos/36369/current-weather/36369?lang=en-us"
    }
]''';

const url =
    'http://dataservice.accuweather.com/currentconditions/v1/36369?apikey=ayum0pDSRW2cpJMcpfL11FBgT1EWZAgE';

class MyHttpClientMock extends Mock implements MyHttpClient {}

void main() {
  testWidgets('testing current weather', (tester) async {
    final client = MyHttpClientMock();

    when(() => client.get(url))
        .thenAnswer((_) async => jsonDecode(mockResponse));

    final service = CurrentWeatherService(client: client);
    final weather = await service.getCurrentForecast();

    expect(weather.currentForecast, 21.1);
  });
}
