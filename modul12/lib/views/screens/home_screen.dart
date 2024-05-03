import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../services/api_service.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  var api = Get.find<ApiService>();
  var controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    api.text = "Bobur";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            // ElevatedButton(
            //   onPressed: () => Get.toNamed("/details", arguments: "Salom"),
            //   child: const Text("Details screen"),
            // ),
            // ElevatedButton(
            //   onPressed: () => controller.increment(),
            //   child: Obx(
            //     () => Text("${controller.count}"),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () {
                // showDialog(
                //   context: context,
                //   builder: (ctx) => const AlertDialog(
                //     title: Text("Flutter"),
                //   ),
                // );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Flutter"),
                  ),
                );
              },
              child: const Text("Flutter"),
            ),
            ElevatedButton(
              onPressed: () {
                // Get.defaultDialog(title: "GetX");
                Get.snackbar("GetX", "Hello world");
              },
              child: const Text("GetX"),
            ),
          ],
        ),
      ),
    );
  }
}
