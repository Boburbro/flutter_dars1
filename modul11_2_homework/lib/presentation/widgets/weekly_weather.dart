import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/menu.dart';
import 'open_modal_bottom_sheet.dart';

class WeeklyWeather extends StatelessWidget {
  const WeeklyWeather({super.key});

  // ignore: non_constant_identifier_names
  void open_add_sheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1C1B33),
      context: context,
      builder: (ctx) {
        return const OpenModalBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                      style: TextStyle(color: Colors.white70, fontSize: 20),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}
