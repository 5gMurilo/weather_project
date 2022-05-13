class FahrenheitToCelsius {

  double convertion(double value){
    var result = (value - 32) * 0.5556;
    return double.parse(result.toStringAsFixed(1));
  }
}