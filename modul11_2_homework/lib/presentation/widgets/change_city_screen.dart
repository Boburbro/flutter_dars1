import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/weather/weather_bloc.dart';

// ignore: must_be_immutable
class ChangeCityScreen extends StatelessWidget {
  ChangeCityScreen({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();

  _submit(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B33),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 50),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hoverColor: Colors.amber,
                  labelText: "Enter a name of city",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please enter a city name";
                  } else if (value.isEmpty) {
                    return "Please enter a city name";
                  } else if (value.length < 2) {
                    return "Please enter a city with at least 2 characters";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  print(newValue);
                  Navigator.of(context).pop();
                  context.read<WeatherBloc>().add(
                        WeatherLoadingEvent(city: newValue!),
                      );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      "E X I T",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: const Text(
                      "G E T  W E A T H E R",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
