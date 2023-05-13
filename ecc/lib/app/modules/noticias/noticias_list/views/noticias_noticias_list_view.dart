import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/noticias_noticias_list_controller.dart';

class NoticiasNoticiasListView extends GetView<NoticiasNoticiasListController> {
  const NoticiasNoticiasListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoticiasNoticiasListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NoticiasNoticiasListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
