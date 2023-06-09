import 'package:get/get.dart';

import '../controllers/paroquias_controller.dart';

class ParoquiasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParoquiasController>(
      () => ParoquiasController(),
    );
  }
}
