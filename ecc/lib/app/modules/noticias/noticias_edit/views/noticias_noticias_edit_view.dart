import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/noticias_noticias_edit_controller.dart';

class NoticiasEditView extends GetView<NoticiasEditController> {
  const NoticiasEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoticiasEditView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NoticiasEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
