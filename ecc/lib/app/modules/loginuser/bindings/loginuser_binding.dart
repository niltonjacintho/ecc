import 'package:get/get.dart';

import '../controllers/loginuser_controller.dart';

class LoginuserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginuserController>(
      () => LoginuserController(),
    );
  }
}
