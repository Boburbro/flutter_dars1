import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/home.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: [
              const SizedBox(height: 80),
              const SizedBox(
                height: 185,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Montreal",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Text(
                        "19°",
                        style: TextStyle(
                            fontSize: 70, color: Colors.white, height: 0.8),
                      ),
                      Column(
                        children: [
                          Text(
                            "Mostly clear",
                            style: TextStyle(
                                fontSize: 18, color: Colors.white, height: 0.8),
                          ),
                          Text(
                            "H:24° L:18°",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Image.asset(
                "assets/1.png",
                fit: BoxFit.cover,
                width: 350,
                height: 350,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                    height: 325,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF2E335A).withAlpha(190),
                          const Color(0xFF1C1B33).withAlpha(190),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 49,
                          child: Center(
                            child: Text(
                              "Weekly forecast",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 20),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 100,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Container(
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color.fromARGB(255, 37, 34, 85),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(5, 5), blurRadius: 5),
                                  ],
                                ),
                                child: const Text("s"),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 70),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
