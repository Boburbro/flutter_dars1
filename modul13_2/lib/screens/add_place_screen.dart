import 'dart:io';

import 'package:flutter/material.dart';
import '../models/place_models.dart';
import 'package:provider/provider.dart';

import '../providers/place_provider.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

// ignore: must_be_immutable
class AddPlaceScreen extends StatelessWidget {
  static const routeName = "/add-place";

  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  File? _image;
  PlaceLocation? _placeLocation;
  String _title = "";

  AddPlaceScreen({super.key});

  void takeImage(File image) {
    _image = image;
  }

  void pickPlace({
    required double latitude,
    required double longitude,
    required String address,
  }) {

    _placeLocation = PlaceLocation(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Rasimni kiriting!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              )
            ],
          ),
        );
        return;
      } else if (_placeLocation == null) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Manzilni kiriting!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              )
            ],
          ),
        );
        return;
      }
      _formKey.currentState!.save();
      Provider.of<PlaceProvider>(context, listen: false)
          .addPlace(_title, _image!, _placeLocation!);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Sayohat joyi"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Joy nomi',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Joy nomini kiriting";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _title = newValue!;
                        },
                      ),
                      const SizedBox(height: 10),
                      ImageInput(
                        takeImage: takeImage,
                      ),
                      const SizedBox(height: 10),
                      LocationInput(
                        pickLocation: pickPlace,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(vertical: 18),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              backgroundColor: Colors.indigo,
            ),
            onPressed: () => submit(context),
            child: const Text(
              "Saqlash",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
