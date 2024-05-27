import 'package:flutter/material.dart';
import 'place_detailes.dart';
import '../providers/place_provider.dart';
import 'add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sayohat"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(
              context,
              AddPlaceScreen.routeName,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context, listen: false).getPlace(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<PlaceProvider>(
            builder: (context, placeProvider, child) {
              if (placeProvider.places.isNotEmpty) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  itemCount: placeProvider.places.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () => Navigator.of(context).pushNamed(
                          PlaceDetailes.routeName,
                          arguments: placeProvider.places[index].id,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                            placeProvider.places[index].image,
                          ),
                        ),
                        title: Text(placeProvider.places[index].title),
                        subtitle: Text(
                          placeProvider.places[index].location.address,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return child!;
              }
            },
            child: const Center(
              child: Text("Iltimos biron narsa kiriting!"),
            ),
          );
        },
      ),
    );
  }
}
