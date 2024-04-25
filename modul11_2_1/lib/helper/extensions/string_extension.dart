extension StringExtension on String {
  // ignore: unnecessary_this
  String capitalizeString() => "${this[0].toUpperCase()}${this.substring(1)}";
}
