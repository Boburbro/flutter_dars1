import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class PlaceModel {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  PlaceModel({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
