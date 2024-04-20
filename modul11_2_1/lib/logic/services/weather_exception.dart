class WeatherExceptions implements Exception {
  final String message;

  WeatherExceptions(this.message);

  @override
  String toString() {
    return message;
  }
}
