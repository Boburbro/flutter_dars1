class WeatherException implements Exception {
  final String message;

  WeatherException(this.message);

  @override
  String toString() {
    return message.toString();
  }
}
