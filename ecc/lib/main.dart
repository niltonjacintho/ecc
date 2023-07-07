import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:ecc/app/modules/home/views/home_view.dart';
import 'package:ecc/app/modules/login/views/login_view.dart';
import 'package:ecc/app/modules/loginuser/views/loginuser_view.dart';
import 'package:ecc/app/modules/usuarios/controllers/usuarios_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyC3LFuRwgjhHzBH_bFG7B5dGS5NO_dPXz0',
    appId: '1:1035136043525:web:bbfd4b463d8beda3b52a6c',
    messagingSenderId: '1035136043525',
    projectId: 'ecc-apk',
    authDomain: 'ecc-apk.firebaseapp.com',
    databaseURL: 'https://ecc-apk.firebaseio.com',
    storageBucket: 'ecc-apk.appspot.com',
  ));
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
      home: ((isTokenOk > configController.diasToken) ||
              (configController.isWebEnvironment()))
          ? LoginuserView()
          : const HomeView(),
      getPages: AppPages.routes,
    ),
  );
}
