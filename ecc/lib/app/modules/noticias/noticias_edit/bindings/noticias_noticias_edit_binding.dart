import 'package:get/get.dart';

import '../controllers/noticias_noticias_edit_controller.dart';

class NoticiasNoticiasEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticiasNoticiasEditController>(
      () => NoticiasNoticiasEditController(),
    );
  }
}
