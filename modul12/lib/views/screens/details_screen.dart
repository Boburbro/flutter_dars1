import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../services/api_service.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});

  var api = Get.find<ApiService>();
  var controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;
    print(arg);
    print(api.getHttpRequest());
    print(api.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("Back"),
            ),
            ElevatedButton(
              onPressed: () => controller.increment(),
              child: Obx(() => Text("${controller.count}")),
            ),
          ],
        ),
      ),
    );
  }
}
