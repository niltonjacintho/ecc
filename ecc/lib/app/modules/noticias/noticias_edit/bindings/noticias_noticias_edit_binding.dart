import 'package:get/get.dart';

import '../controllers/noticias_noticias_edit_controller.dart';

class NoticiasEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticiasEditController>(
      () => NoticiasEditController(),
    );
  }
}
