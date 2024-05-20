import 'dart:io';

import 'package:flutter/material.dart';

import '../database/place_db.dart';
import '../models/place_models.dart';

class PlaceProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<PlaceModel> _places = [];

  List<PlaceModel> get places => [..._places];

  void addPlace(String title, File image) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _place = PlaceModel(
      id: UniqueKey().toString(),
      title: title,
      location: PlaceLocation(
        latitude: '1',
        longitude: '1',
        address: 'address',
      ),
      image: image,
    );

    _places.add(_place);

    await PlaceDB.insert({
      'id': _place.id,
      'title': _place.title,
      'location': 'a',
      'image': _places.last.image.path,
    });

    notifyListeners();
  }

  Future<void> getPlace() async {
    final placeList = await PlaceDB.getData();

    _places = placeList
        .map(
          (place) => PlaceModel(
            id: place['id'],
            title: place['title'],
            location: PlaceLocation(
              latitude: '1',
              longitude: '1',
              address: 'address',
            ),
            image: File(place['image']),
          ),
        )
        .toList();

    notifyListeners();
  }
}
