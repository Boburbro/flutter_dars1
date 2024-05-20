import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? locationImage;

  _getCurrentLocation() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position.toString());
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
                ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () => _getCurrentLocation(),
              icon: const Icon(Icons.location_on_rounded),
              label: const Text("Hozirgi manzil"),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.indigo,
              ),
              onPressed: () {},
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
