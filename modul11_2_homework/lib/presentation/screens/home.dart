import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:modul11_2_homework/presentation/screens/menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void open_add_sheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1C1B33),
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(18),
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 50,
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
                    onPressed: () {},
                    child: const Text(
                      "G E T  W E A T H E R",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

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
                "assets/home_house.png",
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
                            style:
                                TextStyle(color: Colors.white70, fontSize: 20),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Container(
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white54),
                                borderRadius: BorderRadius.circular(30),
                                color: const Color.fromARGB(255, 37, 34, 85),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(5, 5),
                                    blurRadius: 10,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'M',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/icons/moon_cloud.png",
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                  ),
                                  const Text(
                                    "19°",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.location_on_outlined,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  open_add_sheet(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.white,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.add,
                                  size: 60,
                                  color: Colors.blue[900],
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (_) => const MenuScreen(),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.menu,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
