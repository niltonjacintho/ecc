import 'package:ecc/app/modules/config/controllers/config_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/noticias_view_controller.dart';

class NoticiasView extends GetView<NoticiasViewController> {
  const NoticiasView({Key? key}) : super(key: key);

  static NoticiasViewController noticiasViewController =
      Get.put(NoticiasViewController());

  @override
  Widget build(BuildContext context) {
    ConfigController configController = Get.put(ConfigController());
    noticiasViewController.fetchDocument();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar:
          configController.padraoBar(titulo: 'Notícias Edit', allowEdit: true),
      body: SizedBox.expand(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: configController.appBarBackGroundImage,
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: Text(
              "NoticiasView rrris working ",
              style: TextStyle(fontSize: 20, color: Colors.black38),
            ),
          ),
        ),
      ),
    );
  }
}
