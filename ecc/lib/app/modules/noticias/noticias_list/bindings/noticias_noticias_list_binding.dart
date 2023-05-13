import 'package:get/get.dart';

import '../controllers/noticias_noticias_list_controller.dart';

class NoticiasNoticiasListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticiasNoticiasListController>(
      () => NoticiasNoticiasListController(),
    );
  }
}
