import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/usuarios/controllers/usuarios_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting('pt_BR', null);

  ConfigController configController = Get.put(ConfigController());
  UsuariosController usuariosController = Get.put(UsuariosController());
  var isTokenOk = -1;
  await configController.isTokenOk().then((value) => isTokenOk = value);
  if (isTokenOk == -100) {
    await usuariosController.refresh();
    await configController.isTokenOk().then((value) => isTokenOk = value);
    isTokenOk = 100;
  }
  runApp(
    GetMaterialApp(
      title: "E.C.C.",
      initialRoute: isTokenOk <= 0 ? AppPages.LOGINUSER : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
