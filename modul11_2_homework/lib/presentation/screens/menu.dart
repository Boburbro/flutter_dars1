import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B33),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF1C1B33),
        title: const Text(
          "Weather",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 20,
        itemBuilder: (ctx, index) => Container(
          height: 200,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  child: Image.asset(
                    'assets/widgets/rectangle.png',
                    height: 180,
                  )),
              const Positioned(
                top: 20,
                left: 30,
                child: Text(
                  "19*",
                  style: TextStyle(color: Colors.white, fontSize: 62),
                ),
              ),
              const Positioned(
                bottom: 30,
                left: 30,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "H:21* L:-19*",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    Text(
                      "Montreal, Canada",
                      style: TextStyle(
                          color: Colors.white, fontSize: 20, height: 0.9),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  "assets/icons/sun_cloud_angled_rain.png",
                  width: 150,
                  height: 150,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
