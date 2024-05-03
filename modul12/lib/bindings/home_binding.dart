import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../services/api_service.dart';

class HomeBindning extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put(HomeController());
  }
}
