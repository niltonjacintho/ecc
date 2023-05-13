import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/noticias_noticias_edit_controller.dart';

class NoticiasNoticiasEditView extends GetView<NoticiasNoticiasEditController> {
  const NoticiasNoticiasEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoticiasNoticiasEditView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NoticiasNoticiasEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
