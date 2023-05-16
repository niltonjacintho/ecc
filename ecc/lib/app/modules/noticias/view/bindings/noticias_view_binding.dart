import 'package:get/get.dart';

import '../controllers/noticias_view_controller.dart';

class NoticiasViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticiasViewController>(
      () => NoticiasViewController(),
    );
  }
}
