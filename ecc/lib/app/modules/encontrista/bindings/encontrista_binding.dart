import 'package:get/get.dart';

import '../controllers/encontrista_controller.dart';

class EncontristaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EncontristaController>(
      () => EncontristaController(),
    );
  }
}
