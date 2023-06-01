import 'package:get/get.dart';

import '../controllers/lixo_controller.dart';

class LixoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LixoController>(
      () => LixoController(),
    );
  }
}
