import 'package:flutter/material.dart';

class SearchCity extends StatelessWidget {
  SearchCity({super.key});

  static const routeName = "/search-city";

  final _formKey = GlobalKey<FormState>();

  String? _city = "";

  _submit(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(ctx).pop(_city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search a city"),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter a city",
                    hintText: "Enter a city",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a city";
                    } else if (value.length < 3) {
                      return "Please enter a city with at least 3 characters";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _city = newValue;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _submit(context),
                  child: const Text("GET WEATHER"),
                )
              ],
            ),
          )),
    );
  }
}
