import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:modul13_2/models/app_lat_long.dart';
import 'package:modul13_2/screens/yandex_map_screen.dart';
import '../providers/place_provider.dart';
import 'package:provider/provider.dart';

class PlaceDetailes extends StatelessWidget {
  static const routeName = "/place-detail";

  const PlaceDetailes({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;

    final place = Provider.of<PlaceProvider>(context).getPlaceById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              place.location.address,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => YandexMapScreen(
                    onlyWatch: true,
                    initialLocation: AppLatLong(
                      lat: place.location.latitude,
                      long: place.location.longitude,
                    ),
                  ),
                ),
              ),
              label: const Text(
                'Manzilni ko\'rish',
                style: TextStyle(
                  color: Colors.indigo,
                ),
              ),
              icon: const Icon(
                Icons.map_rounded,
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final availableMaps = await MapLauncher.installedMaps;
                availableMaps.first.showMarker(
                  coords: Coords(
                    place.location.latitude,
                    place.location.longitude,
                  ),
                  title: place.location.address,
                );
              },
              label: const Text(
                'Manzilga borish',
                style: TextStyle(
                  color: Colors.indigo,
                ),
              ),
              icon: const Icon(
                Icons.place_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
