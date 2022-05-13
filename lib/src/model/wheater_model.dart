class Weather {
  final String cityName;
  final String parentCity;
  final double minTemp;
  final double maxTemp;
  final double? currentForecast;
  final DateTime date;
  final String phrase;
  final bool hasPrecipitation;
  final String? precipitationType;
  final String? precipitationIntensity;

  Weather({
    required this.cityName,
    required this.parentCity,
    required this.minTemp,
    required this.maxTemp,
    required this.currentForecast,
    required this.date,
    required this.phrase,
    required this.hasPrecipitation,
    required this.precipitationType,
    required this.precipitationIntensity,
  });
}
