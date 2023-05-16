import 'package:ecc/app/modules/noticias/noticias_list/controllers/noticias_noticias_list_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/noticias_view_controller.dart';

class NoticiasView extends GetView<NoticiasViewController> {
  const NoticiasView({Key? key}) : super(key: key);
  static final NoticiasListController noticiasListController =
      Get.put(NoticiasListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoticiasView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "NoticiasView is working ${noticiasListController.currentId.value}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
