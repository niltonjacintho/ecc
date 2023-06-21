import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting('pt_BR', null);
  runApp(
    GetMaterialApp(
      // debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.LOGINUSER,
      getPages: AppPages.routes,
    ),
  );
}
