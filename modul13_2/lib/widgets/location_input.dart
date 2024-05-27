import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../models/app_lat_long.dart';
import '../screens/yandex_map_screen.dart';
import '../helpers/map_helpers.dart';

class LocationInput extends StatefulWidget {
  final Function pickLocation;

  const LocationInput({
    required this.pickLocation,
    super.key,
  });

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? locationImage;

  void _getImage(double lat, double long) async {
    final staticImage = MapHelpers.getLocationImage(
      latitude: lat,
      longitude: long,
    );

    setState(() {
      locationImage = staticImage;
    });
    final address = await MapHelpers.getAddress(
      latitude: lat,
      longitude: long,
    );

    widget.pickLocation(
      latitude: lat,
      longitude: long,
      address: address,
    );
  }

  _getCurrentLocation() async {
    var serviceEnabled = await Location().serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Location().requestService();
    }
    var locationData = (await Location().getLocation());

    _getImage(locationData.latitude!, locationData.longitude!);

    return AppLatLong(
      lat: locationData.latitude!,
      long: locationData.longitude!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: locationImage == null
              ? const Text("Manzil tanlanmagan")
              : Image.network(
                  locationImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () => _getCurrentLocation(),
              icon: const Icon(Icons.location_on_rounded),
              label: const Text("Hozirgi manzil"),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.indigo,
              ),
              onPressed: () async {
                final selected = await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const YandexMapScreen(
                            onlyWatch: false,
                          )),
                ) as AppLatLong;

                _getImage(selected.lat, selected.long);
              },
              icon: const Icon(
                Icons.map_rounded,
                color: Colors.white,
              ),
              label: const Text(
                "Manzilni tanlash",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ],
    );
  }
}
