import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../models/app_lat_long.dart';
import '../servies/app_location.dart';
import '../widgets/coustom_floating_action_button.dart';

class YandexMapScreen extends StatefulWidget {
  final AppLatLong? initialLocation;
  final bool onlyWatch;

  const YandexMapScreen({
    required this.onlyWatch,
    this.initialLocation,
    super.key,
  });

  static const routeName = '/map';

  @override
  State<YandexMapScreen> createState() => _YandexMapScreenState();
}

class _YandexMapScreenState extends State<YandexMapScreen> {
  AppLatLong? _location;
  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
    if (widget.initialLocation == null) {
      _moveToCurrentLocation();
    } else {
      _moveToLocation(widget.initialLocation!);
    }
  }

  final mapControllerCompleter = Completer<YandexMapController>();

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _moveToLocation(_location!);
  }

  void _moveToCurrentLocation() {
    Location().getLocation().then(
      (LocationData location) {
        _location = AppLatLong(
          lat: location.latitude!,
          long: location.longitude!,
        );
        _moveToLocation(_location!);
      },
    );
  }

  Future<void> _moveToLocation(
    AppLatLong appLatLong,
  ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 16,
        ),
      ),
    );
    setState(() {
      _location = appLatLong;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manzilni belgilang"),
        actions: widget.onlyWatch
            ? null
            : [
                IconButton(
                  onPressed: _location == null
                      ? null
                      : () => Navigator.of(context).pop(_location!),
                  icon: const Icon(Icons.check),
                ),
              ],
      ),
      floatingActionButton: CoustomFloatingActionButton(
        onPressed: () {
          _moveToCurrentLocation();
        },
        icon: Icons.my_location_rounded,
      ),
      body: Stack(
        children: [
          YandexMap(
            
            onMapCreated: (controller) =>
                mapControllerCompleter.complete(controller),
            onCameraPositionChanged: (cameraPosition, reason, finished) {
              if (finished) {
                _location = AppLatLong(
                  lat: cameraPosition.target.latitude,
                  long: cameraPosition.target.longitude,
                );
              }
            },
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Icon(
              Icons.location_on_rounded,
              color: Colors.red,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
