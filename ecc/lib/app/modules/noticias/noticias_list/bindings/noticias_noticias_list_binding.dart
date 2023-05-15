import 'package:get/get.dart';

import '../controllers/noticias_noticias_list_controller.dart';

class NoticiasListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticiasListController>(
      () => NoticiasListController(),
    );
  }
}
